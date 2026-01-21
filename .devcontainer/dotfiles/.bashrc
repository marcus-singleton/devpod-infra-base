#!/bin/bash
# =====================================================
# .bashrc - Gruvbox (Official Colors, Suckless Style)
# Extracted from ellisonleao/gruvbox.nvim
# Zero dependencies - all colors embedded
# =====================================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# =====================================================
# Gruvbox Official Color Palette (Complete)
# Source: ellisonleao/gruvbox.nvim
# RGB values for ANSI true color
# =====================================================

# Dark backgrounds
GRUVBOX_DARK0_HARD="\033[38;2;29;32;33m"       # #1d2021
GRUVBOX_DARK0="\033[38;2;40;40;40m"            # #282828
GRUVBOX_DARK1="\033[38;2;60;56;54m"            # #3c3836
GRUVBOX_DARK2="\033[38;2;80;73;69m"            # #504945
GRUVBOX_DARK3="\033[38;2;102;92;84m"           # #665c54
GRUVBOX_DARK4="\033[38;2;124;111;100m"         # #7c6f64

# Light foregrounds
GRUVBOX_LIGHT0="\033[38;2;251;241;199m"        # #fbf1c7
GRUVBOX_LIGHT1="\033[38;2;235;219;178m"        # #ebdbb2
GRUVBOX_LIGHT2="\033[38;2;213;196;161m"        # #d5c4a1
GRUVBOX_LIGHT3="\033[38;2;189;174;147m"        # #bdae93
GRUVBOX_LIGHT4="\033[38;2;168;153;132m"        # #a89984

# Bright colors
GRUVBOX_BRIGHT_RED="\033[38;2;251;73;52m"      # #fb4934
GRUVBOX_BRIGHT_GREEN="\033[38;2;184;187;38m"   # #b8bb26
GRUVBOX_BRIGHT_YELLOW="\033[38;2;250;189;47m"  # #fabd2f
GRUVBOX_BRIGHT_BLUE="\033[38;2;131;165;152m"   # #83a598
GRUVBOX_BRIGHT_PURPLE="\033[38;2;211;134;155m" # #d3869b
GRUVBOX_BRIGHT_AQUA="\033[38;2;142;192;124m"   # #8ec07c
GRUVBOX_BRIGHT_ORANGE="\033[38;2;254;128;25m"  # #fe8019

# Neutral colors
GRUVBOX_NEUTRAL_RED="\033[38;2;204;36;29m"     # #cc241d
GRUVBOX_NEUTRAL_GREEN="\033[38;2;152;151;26m"  # #98971a
GRUVBOX_NEUTRAL_YELLOW="\033[38;2;215;153;33m" # #d79921
GRUVBOX_NEUTRAL_BLUE="\033[38;2;69;133;136m"   # #458588
GRUVBOX_NEUTRAL_PURPLE="\033[38;2;177;98;134m" # #b16286
GRUVBOX_NEUTRAL_AQUA="\033[38;2;104;157;106m"  # #689d6a
GRUVBOX_NEUTRAL_ORANGE="\033[38;2;214;93;14m"  # #d65d0e

# Gray
GRUVBOX_GRAY="\033[38;2;146;131;116m"          # #928374

# Reset
RESET="\033[0m"

# Active colors (hard contrast, dark mode)
BG0=$GRUVBOX_DARK0_HARD
FG1=$GRUVBOX_LIGHT1
RED=$GRUVBOX_BRIGHT_RED
GREEN=$GRUVBOX_BRIGHT_GREEN
YELLOW=$GRUVBOX_BRIGHT_YELLOW
BLUE=$GRUVBOX_BRIGHT_BLUE
PURPLE=$GRUVBOX_BRIGHT_PURPLE
AQUA=$GRUVBOX_BRIGHT_AQUA
ORANGE=$GRUVBOX_BRIGHT_ORANGE
GRAY=$GRUVBOX_GRAY

# =====================================================
# Welcome Message (Official Gruvbox)
# =====================================================
if [ "$TERM" != "linux" ]; then
    echo -e "\n${ORANGE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${GREEN}  DevLab Development Workspace${RESET}"
    echo -e "${ORANGE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${YELLOW}👤 User:${RESET} $(whoami)@$(hostname)"
    echo -e "  ${YELLOW}🛠 Tools:${RESET} docker, kubectl, terraform, k3d, helm"
    echo -e "  ${YELLOW}📅 Date:${RESET} $(date '+%A, %B %d, %Y at %H:%M %Z')"
    
    if git rev-parse --git-dir > /dev/null 2>&1; then
        branch=$(git branch --show-current 2>/dev/null)
        echo -e "  ${YELLOW}🌿 Branch:${RESET} ${branch:-detached}"
    fi
    
    disk_usage=$(df -h / | tail -1 | awk '{print $5}')
    echo -e "  ${YELLOW}💾 Disk:${RESET} ${disk_usage} used"
    
    echo -e "  ${YELLOW}💡 Tip:${RESET} Type 'alias' to see all shortcuts"
    echo -e "${ORANGE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
fi

# =====================================================
# History Configuration
# =====================================================
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar 2>/dev/null

# =====================================================
# Color Support
# =====================================================
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# =====================================================
# Aliases
# =====================================================
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'

# Kubernetes
alias k='kubectl'
alias kx='kubectl exec -it'
alias kl='kubectl logs -f'
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply -f'
alias kdel='kubectl delete'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'

# =====================================================
# Functions
# =====================================================
mkcd() { mkdir -p "$1" && cd "$1"; }

extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "$1 cannot be extracted" ;;
        esac
    else
        echo "$1 is not a valid file"
    fi
}

psgrep() { ps aux | grep -v grep | grep -i -e VSZ -e "$1"; }
myip() { curl -s ifconfig.me; }
serve() { python3 -m http.server "${1:-8000}"; }

dsh() {
    [ -z "$1" ] && echo "Usage: dsh <container>" && return 1
    docker exec -it "$1" /bin/bash || docker exec -it "$1" /bin/sh
}

ksh() {
    [ -z "$1" ] && echo "Usage: ksh <pod>" && return 1
    kubectl exec -it "$1" -- /bin/bash || kubectl exec -it "$1" -- /bin/sh
}

kns() {
    if [ -z "$1" ]; then
        echo "Current namespace: $(kubectl config view --minify --output 'jsonpath={..namespace}')"
    else
        kubectl config set-context --current --namespace="$1"
        echo "Switched to namespace: $1"
    fi
}

dctail() {
    [ -z "$1" ] && docker compose logs -f || docker compose logs -f "$1"
}

gca() {
    [ -z "$1" ] && echo "Usage: gca <commit message>" && return 1
    git add . && git commit -m "$1" && git push
}

# =====================================================
# Kubernetes Completion
# =====================================================
if command -v kubectl &>/dev/null; then
    if kubectl completion bash &>/dev/null; then
        source <(kubectl completion bash)
        complete -F __start_kubectl k
    fi
fi

# =====================================================
# Prompt (Official Gruvbox)
# =====================================================
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ "$TERM" != "linux" ]; then
    PS1="${GREEN}\u@\h${RESET}:${BLUE}\w${YELLOW}\$(parse_git_branch)${RESET}\$ "
else
    PS1='\u@\h:\w\$ '
fi

# =====================================================
# Environment Variables
# =====================================================
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export EDITOR='nvim'
export VISUAL='nvim'
export KUBE_EDITOR='nvim'

# =====================================================
# Local Customizations
# =====================================================
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

