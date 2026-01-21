# FZF Configuration - DevLab
# =============================

# Add FZF to PATH
if [[ ! "$PATH" == */home/dev/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dev/.fzf/bin"
fi

# Load completions (safe)
[ -f ~/.fzf/shell/completion.bash ] && source ~/.fzf/shell/completion.bash 2>/dev/null

# Load key bindings (safe)
[ -f ~/.fzf/shell/key-bindings.bash ] && source ~/.fzf/shell/key-bindings.bash 2>/dev/null

# FZF options
export FZF_DEFAULT_OPTS='
  --color=bg+:#3c3836,bg:#1d2021,border:#504945,spinner:#fb4934
  --color=hl:#b8bb26,fg:#ebdbb2,header:#b8bb26,info:#fabd2f,pointer:#fb4934
  --color=marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#b8bb26
  --height 40% --border --layout=reverse
'

# Use fd if available
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
