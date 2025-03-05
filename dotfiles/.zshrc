# Enable Powerlevel10k instant prompt (keep at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History configuration
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # Record timestamp
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # Ignore duplicated commands
setopt hist_ignore_space      # Ignore commands that start with space
setopt hist_verify            # Show command with history expansion before running it
setopt share_history          # Share history between sessions

# Better completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion
zstyle ':completion:*' rehash true                         # Automatically find new executables

# Oh-My-Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Auto-update behavior
zstyle ':omz:update' mode auto

# ZSH autosuggestions configuration
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

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

# === Custom Functions ===
# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract most known archives
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unar $1        ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

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

# === Tool Configuration ===
# FZF Configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Python development enhancements
export PYTHONDONTWRITEBYTECODE=1  # Don't create .pyc files

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

# Initialize zoxide
eval "$(zoxide init zsh)"

# Load Starship prompt if installed (alternative to Powerlevel10k)
# command -v starship >/dev/null && eval "$(starship init zsh)"