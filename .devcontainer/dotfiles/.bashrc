# ============================================
# DevContainer Bash Configuration
# Infrastructure Development Environment
# ============================================

# ============================================
# Base Settings
# ============================================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ============================================
# History Configuration
# ============================================

# Don't put duplicate lines or lines starting with space in history
HISTCONTROL=ignoreboth

# Large history
HISTSIZE=10000
HISTFILESIZE=20000

# Append to history file, don't overwrite
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# ============================================
# Shell Options
# ============================================

# Check window size after each command
shopt -s checkwinsize

# Enable ** for recursive globbing
shopt -s globstar

# Autocorrect typos in path names when using cd
shopt -s cdspell

# Case-insensitive tab completion
bind 'set completion-ignore-case on'

# Show all matches if ambiguous
bind 'set show-all-if-ambiguous on'

# Show completion list immediately
bind 'set show-all-if-unmodified on'

# ============================================
# Prompt
# ============================================

# Git branch in prompt
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Colorful prompt with git branch
PS1='\[\033[01;32m\]🐳 \u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\] $(parse_git_branch)\[\033[00m\]\$ '

# ============================================
# Colors
# ============================================

# Enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ============================================
# Navigation Aliases
# ============================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# List directory contents
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lth'  # Sort by time
alias lz='ls -lSh'  # Sort by size

# ============================================
# General Aliases
# ============================================

# Common shortcuts
alias c='clear'
alias h='history'
alias j='jobs -l'
alias mkdir='mkdir -pv'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# ============================================
# Git Aliases
# ============================================

alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate --all'
alias gll='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gst='git stash'
alias gstp='git stash pop'

# ============================================
# Docker Aliases
# ============================================

alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'

# Docker containers
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dstart='docker start'
alias dstop='docker stop'
alias drestart='docker restart'
alias drm='docker rm'
alias drmf='docker rm -f'

# Docker images
alias di='docker images'
alias drmi='docker rmi'
alias dpull='docker pull'
alias dbuild='docker build'

# Docker exec
alias dex='docker exec -it'
alias dsh='docker exec -it'

# Docker logs
alias dlogs='docker logs -f'

# Docker cleanup
alias dprune='docker system prune -af'
alias dclean='docker system prune -a --volumes'

# ============================================
# Kubernetes Aliases
# ============================================

alias k='kubectl'
alias kx='kubectl exec -it'
alias kl='kubectl logs -f'

# Get resources
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kgns='kubectl get namespaces'

# Describe resources
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'

# Delete resources
alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'

# Apply/Create
alias ka='kubectl apply -f'
alias kc='kubectl create'
alias kr='kubectl run'

# Context and namespace
alias kctx='kubectl config current-context'
alias kns='kubectl config view --minify --output "jsonpath={..namespace}"'

# Wide output
alias kgpw='kubectl get pods -o wide'
alias kgsw='kubectl get services -o wide'

# Watch
alias kgpw='kubectl get pods -w'

# ============================================
# Terraform Aliases
# ============================================

alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'
alias tff='terraform fmt'
alias tfv='terraform validate'
alias tfo='terraform output'
alias tfs='terraform show'
alias tfw='terraform workspace'

# ============================================
# Utility Functions
# ============================================

# Tmux session manager
tm() {
    if [ -z "$1" ]; then
        tmux attach || tmux new -s main
    else
        tmux attach -t "$1" || tmux new -s "$1"
    fi
}

# Quick project navigation
cdp() {
    cd ~/projects/"$1" || cd /workspaces/"$1" || return
}

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives
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
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find process by name
psgrep() {
    ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# Get current IP
myip() {
    curl -s ifconfig.me
}

# Quick HTTP server
serve() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# Docker quick shell
dsh() {
    if [ -z "$1" ]; then
        echo "Usage: dsh <container>"
        return 1
    fi
    docker exec -it "$1" /bin/bash || docker exec -it "$1" /bin/sh
}

# Kubernetes quick shell
ksh() {
    if [ -z "$1" ]; then
        echo "Usage: ksh <pod>"
        return 1
    fi
    kubectl exec -it "$1" -- /bin/bash || kubectl exec -it "$1" -- /bin/sh
}

# Set kubectl namespace
kn() {
    if [ -z "$1" ]; then
        echo "Current namespace: $(kubectl config view --minify --output 'jsonpath={..namespace}')"
    else
        kubectl config set-context --current --namespace="$1"
        echo "Switched to namespace: $1"
    fi
}

# Docker compose tail logs
dctail() {
    if [ -z "$1" ]; then
        docker compose logs -f
    else
        docker compose logs -f "$1"
    fi
}

# Git quick commit
gcq() {
    git add .
    git commit -m "$1"
    git push
}

# ============================================
# Kubernetes Completion
# ============================================

if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
fi

# ============================================
# FZF Integration (if installed)
# ============================================

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
    
    # Use fd instead of find if available
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    
    # Preview files with bat if available
    if command -v bat &> /dev/null; then
        export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
    fi
fi

# ============================================
# Environment Variables
# ============================================

# Default editor
export EDITOR='nvim'
export VISUAL='nvim'

# Less colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# ============================================
# Welcome Message
# ============================================

# Show useful info when shell starts
if [ "$TERM" != "linux" ]; then
    echo -e "\n\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\033[1;34m  DevContainer Environment Ready\033[0m"
    echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "  \033[1;33m📦 Tools:\033[0m docker, kubectl, terraform, nvim"
    echo -e "  \033[1;33m💡 Tip:\033[0m Type 'alias' to see all shortcuts"
    echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n"
fi

# ============================================
# Custom Additions
# ============================================

# Add your custom aliases and functions below


