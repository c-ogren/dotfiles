#!/usr/bin/env bash
# Set up a machine from this repo: install its packages, then link the configs.
#
#   ./bootstrap.sh laptop              # packages/common.txt + packages/laptop.txt
#   ./bootstrap.sh desktop             # packages/common.txt + packages/desktop.txt
#   ./bootstrap.sh --dry-run laptop    # change nothing; show what's missing,
#                                      # what's installed but unlisted, and
#                                      # what stow would do
#
# Safe to re-run: installs use --needed and stow restows. Changes under /etc
# (README › System setup) are not done here.
set -euo pipefail

die()  { printf 'bootstrap: %s\n' "$*" >&2; exit 1; }
warn() { printf 'bootstrap: warning: %s\n' "$*" >&2; }
step() { printf '\n==> %s\n' "$*"; }

dry_run=0
if [[ ${1:-} == -n || ${1:-} == --dry-run ]]; then dry_run=1; shift; fi
role=${1:-}
[[ $role == laptop || $role == desktop ]] || die "usage: $0 [--dry-run] laptop|desktop"
[[ $EUID -ne 0 ]] || die "run as your user; it calls sudo itself"

dotfiles=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
lists=("$dotfiles/packages/common.txt" "$dotfiles/packages/$role.txt")

# --------------------------------------------------------------- packages

# One name per line, '#' starts a comment, "repo/name" = third-party repo.
mapfile -t wanted < <(sed -e 's/#.*//' -e 's/[[:space:]]//g' -e '/^$/d' "${lists[@]}" | LC_ALL=C sort -u)
names=("${wanted[@]##*/}")   # without any repo/ prefix

# Repos have to be set up by hand before anything is installed.
repos=$(pacman-conf --repo-list)
for entry in "${wanted[@]}"; do
	[[ $entry == */* ]] || continue
	grep -qx -- "${entry%%/*}" <<<"$repos" ||
		die "$entry needs the [${entry%%/*}] repo in /etc/pacman.conf (README › System setup)"
done
if printf '%s\n' "${names[@]}" | grep -q '^lib32-' && ! grep -qx multilib <<<"$repos"; then
	die "lib32-* packages need [multilib]: uncomment it in /etc/pacman.conf"
fi

if ((!dry_run)); then
	step "Updating the system"
	sudo pacman -Syu
fi

# Anything not in an official/configured repo is built from the AUR.
declare -A in_repo=()
while read -r pkg; do in_repo[$pkg]=1; done < <(pacman -Slq)
repo_pkgs=() aur_pkgs=()
for entry in "${wanted[@]}"; do
	if [[ $entry == */* || -n ${in_repo[$entry]:-} ]]; then
		repo_pkgs+=("$entry")
	else
		aur_pkgs+=("$entry")
	fi
done

if ((dry_run)); then
	step "${#repo_pkgs[@]} repo + ${#aur_pkgs[@]} AUR packages listed for $role"
	printf 'AUR: %s\n' "${aur_pkgs[*]}"
	step "Listed but not installed"
	pacman -T "${names[@]}" || true
	step "Installed explicitly but not in common.txt or $role.txt"
	comm -23 <(pacman -Qqe | LC_ALL=C sort) <(printf '%s\n' "${names[@]}" | LC_ALL=C sort)
else
	step "Installing ${#repo_pkgs[@]} repo packages"
	sudo pacman -S --needed "${repo_pkgs[@]}"

	if ((${#aur_pkgs[@]})); then
		if ! command -v yay >/dev/null; then
			step "Building yay from the AUR"
			build=$(mktemp -d)
			trap 'rm -rf "$build"' EXIT
			git clone --depth 1 https://aur.archlinux.org/yay.git "$build/yay"
			(cd "$build/yay" && makepkg -si --needed)
		fi
		step "Installing ${#aur_pkgs[@]} AUR packages"
		# One broken AUR build shouldn't stop the configs from being linked;
		# the check at the end lists whatever is still missing.
		yay -S --needed "${aur_pkgs[@]}" || warn "some AUR packages failed (see above); continuing"
	fi
fi

# ---------------------------------------------------------------- configs

# Every top-level directory is a Stow package except these:
#   packages  the lists above
#   firefox   its profile directory is named per install; linked further down
stow_pkgs=()
for dir in "$dotfiles"/*/; do
	pkg=$(basename "$dir")
	[[ $pkg == packages || $pkg == firefox ]] || stow_pkgs+=("$pkg")
done

if ((dry_run)); then
	step "Links stow would add (simulated; nothing listed = all in place)"
	stow --dir="$dotfiles" --target="$HOME" --simulate --verbose=1 "${stow_pkgs[@]}" 2>&1 |
		grep -v '^WARNING: in simulation mode' || true
	exit 0
fi

step "Linking ${#stow_pkgs[@]} packages with stow"
# Directories other programs also write into. Stow replaces a directory that
# doesn't exist yet with one symlink into the repo ("folding"), so without
# these every app's files under e.g. ~/.local/share would end up in git.
mkdir -p ~/.config ~/.local/bin ~/.local/share ~/.claude
stow --dir="$dotfiles" --target="$HOME" --restow "${stow_pkgs[@]}"

# Firefox: link user.js and chrome/ into the existing default-release profile.
# Firefox has to have run once so that the profile exists.
shopt -s nullglob
ff_src=("$dotfiles"/firefox/.config/mozilla/firefox/*/)
ff_profiles=(~/.config/mozilla/firefox/*.default-release ~/.mozilla/firefox/*.default-release)
shopt -u nullglob
ff_status="not linked"
if ((${#ff_src[@]} != 1)); then
	warn "firefox: expected one profile directory in the repo, found ${#ff_src[@]}"
elif ((${#ff_profiles[@]} != 1)); then
	warn "firefox: found ${#ff_profiles[@]} *.default-release profiles; start Firefox once, then rerun"
else
	ff_status="linked into ${ff_profiles[0]}"
	for name in user.js chrome; do
		src=${ff_src[0]%/}/$name target=${ff_profiles[0]}/$name
		[[ $(readlink -f "$target") == "$(readlink -f "$src")" ]] && continue
		if [[ -e $target || -L $target ]]; then
			warn "firefox: $target already exists, leaving it alone"
			ff_status="not linked"
			continue
		fi
		ln -sr "$src" "$target"
	done
fi

bat cache --build >/dev/null   # registers the custom bat/delta theme

# ----------------------------------------------------------------- verify

step "Checking"
failed=0

if missing=$(pacman -T "${names[@]}"); then
	echo "✓ all ${#names[@]} listed packages installed"
else
	printf '✗ not installed:\n%s\n' "$missing"
	failed=1
fi

# Every tracked file in a stowed package must resolve to the repo copy.
bad=0
while read -r file; do
	pkg=${file%%/*}
	[[ $(readlink -f "$HOME/${file#"$pkg"/}") == "$(readlink -f "$dotfiles/$file")" ]] && continue
	printf '✗ not linked: ~/%s\n' "${file#"$pkg"/}"
	bad=1
done < <(git -C "$dotfiles" ls-files -- "${stow_pkgs[@]}")
if ((bad)); then failed=1; else echo "✓ all ${#stow_pkgs[@]} stow packages linked"; fi

for name in user.js chrome; do
	[[ $ff_status == linked* && $(readlink -f "${ff_profiles[0]}/$name") == "$(readlink -f "${ff_src[0]%/}/$name")" ]] ||
		ff_status="not linked"
done
if [[ $ff_status == linked* ]]; then echo "✓ firefox $ff_status"; else echo "– firefox $ff_status"; fi

echo
echo "Not done here: README › System setup (/etc changes, services)."
exit "$failed"
