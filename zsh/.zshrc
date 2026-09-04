# ============================================================
# 1. Shell Environment
# ============================================================

autoload -U colors && colors

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"


# ============================================================
# 2. History & Core Behavior
# ============================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt NO_BEEP


# ============================================================
# 3. Key Bindings
# ============================================================

bindkey -e

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


# ============================================================
# 4. Eza
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

alias ls='eza --icons=auto'
alias ll='eza -la --icons=auto'
alias la='eza -a --icons=auto'
alias lt='eza --tree --level=2 --icons=auto'


# ============================================================
# 5. General Aliases
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
alias myip='curl -fsS ifconfig.me; echo'

myipinfo() {
    curl -fsS ipinfo.io | jq
}

alias path='print -l ${(s.:.)PATH}'
alias history='fc -lfD'

alias zj='zellij'

alias sshsafe='TERM=xterm-256color ssh -o "IdentitiesOnly=yes" -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no"'

alias nvrun='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'


# ============================================================
# 6. Git Aliases
# ============================================================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'


# ============================================================
# 7. FZF
# ============================================================

[[ -r /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -r /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

bindkey "^T" fzf-file-widget
bindkey "^R" fzf-history-widget


# ============================================================
# 8. Runtime Initializations
# ============================================================

(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[mise] )) && eval "$(mise activate zsh)"

if (( $+commands[keychain] )) && [[ -f "$HOME/.ssh/id_ed25519" ]]; then
    eval "$(keychain --eval --quiet id_ed25519)"
fi

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"


# ============================================================
# 9. Zoxide + FZF Helper
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
# 10. Git Helper
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

    git switch -c "$branch" &&
    git add . &&
    git commit -m "$message" &&
    git push -u origin "$branch" &&
    gh pr create --fill
}


# ============================================================
# 11. Process Memory Helper
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
# 12. Firewall Helper
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
# 13. Zsh Plugins
# ============================================================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
