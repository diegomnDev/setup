# Enable Powerlevel10k instant prompt (keep at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh-My-Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Auto-update behavior
zstyle ':omz:update' mode auto

# Plugins
plugins=(
  # Core functionality
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting  # Keep this last among syntax plugins

  # Developer tools
  docker
  kubectl
  brew
  npm
  python
  pip
  zsh-nvm

  # System integration
  iterm2
  macos
  emoji
)

source $ZSH/oh-my-zsh.sh

# === Key Bindings ===
# Navigation
bindkey "^[f" forward-word          # Alt+right - move forward one word
bindkey "^[b" backward-word         # Alt+left - move backward one word
bindkey "^A" beginning-of-line      # Ctrl+A - move to start of line
bindkey "^E" end-of-line            # Ctrl+E - move to end of line
bindkey "^[[H" beginning-of-line    # Home - move to start of line
bindkey "^[[F" end-of-line          # End - move to end of line

# Editing
bindkey "^K" kill-line              # Ctrl+K - delete from cursor to end of line
bindkey "^U" backward-kill-line     # Ctrl+U - delete from cursor to start of line

# === Aliases ===
# Modern replacements for standard commands
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias lt='eza -T --icons --git-ignore'
alias ltl='eza -T -L 2 --icons --git-ignore'
alias lta='eza -Ta --icons'
alias cat='bat --style=auto'
alias grep='rg'

# Directory navigation with zoxide
alias cd='z'
alias zl='z -l'      # List frequent locations
alias zi='z -i'      # Interactive mode

# Git enhancements
alias glog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gd='git diff | delta'
alias gdst='git diff --staged | delta'

# File search and preview
alias preview='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias f='fzf'
alias fh='history | fzf'
alias fkill='ps aux | fzf | awk "{print \$2}" | xargs kill -9'
alias mh='mcfly search'

# JSON and YAML processing
alias jqp='jq -C . | less -R'   # Colored JSON output
alias jqs='jq -r "."'           # Raw JSON output
alias yqp='yq -C . | less -R'   # Colored YAML output

# System utilities
alias ip='ipconfig getifaddr en0'
alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias dush='du -sh * | sort -hr | head -10'   # Top 10 directories by size
alias ports='lsof -iTCP -sTCP:LISTEN -P'      # View open ports
alias path='echo $PATH | tr ":" "\n"'         # Display PATH in readable format
alias cleanup='fd -H ".*DS_Store" -tf -X rm'  # Remove .DS_Store files

# === Environment Setup ===
# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Python environment
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
export PATH="$HOME/.local/bin:$PATH"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load Starship prompt if installed (alternative to Powerlevel10k)
# command -v starship >/dev/null && eval "$(starship init zsh)"