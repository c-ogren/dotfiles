# ============================================================
# 1. Shell Environment
# ============================================================

autoload -U colors && colors

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"

if (( $+commands[bat] )); then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi
export ZK_NOTEBOOK_DIR="$HOME/notes"

# ============================================================
# 2. History & Core Behavior
# ============================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE      # leading space = keep out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt NO_BEEP


# ============================================================
# 3. Completion
# ============================================================

zmodload zsh/complist
autoload -Uz compinit

_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
[[ -d "${_zcompdump:h}" ]] || mkdir -p "${_zcompdump:h}"
compinit -d "$_zcompdump"
unset _zcompdump

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'


# ============================================================
# 4. Key Bindings
# ============================================================

bindkey -e

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind both the normal-mode sequence and the terminfo (application-mode) one,
# since terminals/multiplexers differ in which they send.
_bindkey_both() {
    local widget="$1" raw="$2" cap="$3"
    bindkey "$raw" "$widget"
    [[ -n "${terminfo[$cap]}" ]] && bindkey "${terminfo[$cap]}" "$widget"
}

_bindkey_both up-line-or-beginning-search   '^[[A'  kcuu1
_bindkey_both down-line-or-beginning-search '^[[B'  kcud1
_bindkey_both beginning-of-line             '^[[H'  khome
_bindkey_both end-of-line                   '^[[F'  kend
_bindkey_both delete-char                   '^[[3~' kdch1
_bindkey_both reverse-menu-complete         '^[[Z'  kcbt
unfunction _bindkey_both

bindkey '^[[1;5C' forward-word    # Ctrl+Right
bindkey '^[[1;5D' backward-word   # Ctrl+Left


# ============================================================
# 5. Eza
# ============================================================

export EZA_COLORS='di=38;2;88;166;255:'\
'ln=38;2;57;197;207:'\
'ex=38;2;87;171;90:'\
'ur=38;2;201;209;217:'\
'uw=38;2;210;153;34:'\
'ux=38;2;88;166;255:'\
'gr=38;2;118;131;144:'\
'gw=38;2;210;153;34:'\
'gx=38;2;88;166;255:'\
'tr=38;2;118;131;144:'\
'tw=38;2;210;153;34:'\
'tx=38;2;88;166;255:'\
'uu=38;2;201;209;217:'\
'gu=38;2;118;131;144:'\
'da=38;2;118;131;144:'\
'sn=38;2;210;153;34:'\
'sb=38;2;201;209;217:'\
'xx=38;2;255;123;114'

if (( $+commands[eza] )); then
    alias ls='eza --icons=auto'
    alias ll='eza -la --icons=auto'
    alias la='eza -a --icons=auto'
    alias lt='eza --tree --level=2 --icons=auto'
fi


# ============================================================
# 6. General Aliases
# ============================================================

alias c='bat'

alias rgrep='rg --smart-case --hyperlink-format=default'

alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias dmesg='dmesg --color=auto'

alias md='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

alias ports='sudo ss -tulpn'

myip() {
  case "$1" in
    4|ipv4|-4)
      curl -4 -fsS https://ifconfig.me
      echo
      ;;
    6|ipv6|-6)
      curl -6 -fsS https://ifconfig.me
      echo
      ;;
    "")
      echo "IPv4: $(curl -4 -fsS https://ifconfig.me 2>/dev/null || echo unavailable)"
      echo "IPv6: $(curl -6 -fsS https://ifconfig.me 2>/dev/null || echo unavailable)"
      ;;
    *)
      echo "usage: myip [4|6]"
      return 1
      ;;
  esac
}

ipinfo() {
  local token_file="$HOME/.config/ipinfo/token"
  local ip="$1"

  if [[ ! -r "$token_file" ]]; then
    echo "ipinfo token not found: $token_file" >&2
    return 1
  fi

  local token
  token=$(<"$token_file")

  if [[ -n "$ip" ]]; then
    curl -fsS \
      -H "Authorization: Bearer $token" \
      "https://ipinfo.io/$ip" | jq
  else
    curl -fsS \
      -H "Authorization: Bearer $token" \
      "https://ipinfo.io" | jq
  fi
}

alias path='print -l ${(s.:.)PATH}'
alias history='fc -lfD'

alias zj='zellij'
alias ff='clear && fastfetch && read -rsk1'

alias sshsafe='TERM=xterm-256color ssh -o "IdentitiesOnly=yes" -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no"'

alias nvrun='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'


# ============================================================
# 7. Git Aliases
# ============================================================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'


# ============================================================
# 8. FZF
# ============================================================

[[ -r /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -r /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh


# ============================================================
# 9. Runtime Initializations
# ============================================================

(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[mise] )) && eval "$(mise activate zsh)"

if (( $+commands[keychain] )) && [[ -f "$HOME/.ssh/id_ed25519" ]]; then
    eval "$(keychain --eval --quiet id_ed25519)"
fi

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"


# ============================================================
# 10. Zoxide + FZF Helper
# ============================================================

zi() {
    local dir

    dir="$(
        zoxide query -l |
        fzf --preview 'eza --tree --level=2 --icons=auto {}'
    )" || return

    builtin cd "$dir"
}


# ============================================================
# 11. Git Helper
# ============================================================

# Usage:
#   gnew <branch-name> <commit-message>
gnew() {
    if (( $# < 2 )); then
        echo 'usage: gnew <branch-name> <commit-message>'
        return 1
    fi

    local branch="$1"
    shift
    local message="$*"

    # Commit what's staged; if nothing is, stage tracked changes only
    # (never sweep up untracked files).
    if git diff --cached --quiet; then
        git add -u || return
        if git diff --cached --quiet; then
            echo 'gnew: nothing to commit (stage new files with git add first)' >&2
            return 1
        fi
    fi

    git switch -c "$branch" &&
    git commit -m "$message" &&
    git push -u origin "$branch" &&
    gh pr create --fill
}


# ============================================================
# 12. Process Memory Helper
# ============================================================

vmrss() {
    if [[ -z "$1" ]]; then
        echo "usage: vmrss <PID>"
        return 1
    fi

    if [[ ! -d "/proc/$1" ]]; then
        echo "Error: process $1 does not exist."
        return 1
    fi

    local kb
    local mb

    kb="$(awk '/VmRSS/ {print $2}' "/proc/$1/status")"
    kb="${kb:-0}"

    mb="$(awk "BEGIN {printf \"%.2f\", $kb / 1024}")"

    echo "Process $1 VmRSS: ${kb} kB (${mb} MB)"
}


# ============================================================
# 13. Firewall Helper
# ============================================================

firewall() {
    case "$1" in
        on)
            sudo ufw enable
            ;;

        off)
            sudo ufw disable
            ;;

        -v|status)
            sudo ufw status verbose
            ;;

        rules)
            sudo ufw status numbered
            ;;

        reload)
            sudo ufw reload
            ;;

        *)
            echo "usage: firewall {on|off|-v|status|rules|reload}"
            return 1
            ;;
    esac
}

# ============================================================
# 14. Zsh Plugins
# ============================================================

_zplug=/usr/share/zsh/plugins
[[ -r $_zplug/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
    source $_zplug/zsh-autosuggestions/zsh-autosuggestions.zsh
# Must be sourced last.
[[ -r $_zplug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
    source $_zplug/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
unset _zplug

typeset -gA ZSH_HIGHLIGHT_STYLES

# GitHub Dark / deutan-friendly syntax highlighting.
ZSH_HIGHLIGHT_STYLES[command]='fg=#57AB5A,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#539BF5'
ZSH_HIGHLIGHT_STYLES[function]='fg=#539BF5'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#539BF5'

ZSH_HIGHLIGHT_STYLES[path]='fg=#CDD9E5,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#CDD9E5'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#C69026'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#C69026'

ZSH_HIGHLIGHT_STYLES[redirection]='fg=#56D4DD'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#E5534B,bold'
