# ================================================================
# macOS Developer .zshrc 2025 - OMZ + Homebrew Plugins
# ================================================================

# Homebrew PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# ================================================================
# HISTORY CONFIGURATION
# ================================================================
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history         # Record timestamp
setopt hist_expire_dups_first   # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups         # Ignore duplicated commands
setopt hist_ignore_space        # Ignore commands that start with space
setopt hist_verify              # Show command with history expansion before running it
setopt share_history            # Share history between sessions

# Additional useful options
setopt auto_cd                  # Auto-cd (just type directory name)
setopt correct                  # Command correction

# ================================================================
# OH MY ZSH CONFIGURATION
# ================================================================
export ZSH="$HOME/.oh-my-zsh"

# Theme - choose one:
ZSH_THEME=""            # Modern and fast
# ZSH_THEME="robbyrussell"        # Simple and reliable
# ZSH_THEME="powerlevel10k/powerlevel10k"  # Uncomment for p10k

# Auto-update behavior
zstyle ':omz:update' mode auto

# ================================================================
# PLUGINS (Only OMZ native plugins - NOT Homebrew ones)
# ================================================================
plugins=(
  # CORE - Native OMZ plugins
  git
  z
  colored-man-pages
  extract
  command-not-found

  # DEVELOPER TOOLS - Native OMZ plugins
  docker
  kubectl
  npm
  yarn
  python
  pip
  gradle
  mvn
  sdk

  # MACOS INTEGRATION - Native OMZ plugins
  macos
  brew

  # OTHER - Native OMZ plugins
  emoji
)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ================================================================
# HOMEBREW ZSH PLUGINS CONFIGURATION
# ================================================================

# 1. ZSH Completions (MUST BE FIRST)
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# 2. ZSH Autosuggestions
if [[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  # Autosuggestions configuration
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
  export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# 3. ZSH Syntax Highlighting (MUST BE LAST!)
if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
  # Set highlighters directory if needed
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
fi

# ================================================================
# TOOL INITIALIZATION
# ================================================================

# Modern CLI tools
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v mcfly >/dev/null && eval "$(mcfly init zsh)"
command -v thefuck >/dev/null && eval "$(thefuck --alias)"

# Version managers
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

# SDKMAN
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ================================================================
# KEY BINDINGS
# ================================================================
# Navigation
bindkey "^[[1;3C" forward-word      # Alt+right
bindkey "^[[1;3D" backward-word     # Alt+left
bindkey "^A" beginning-of-line      # Ctrl+A
bindkey "^E" end-of-line            # Ctrl+E
bindkey "^[[H" beginning-of-line    # Home
bindkey "^[[F" end-of-line          # End

# Editing
bindkey "^K" kill-line              # Ctrl+K - delete to end of line
bindkey "^U" backward-kill-line     # Ctrl+U - delete to start of line
bindkey "^W" backward-kill-word     # Ctrl+W - delete word backward

# ================================================================
# MODERN CLI ALIASES
# ================================================================

# File operations
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --git --group-directories-first --header'
  alias la='eza -la --icons --git --group-directories-first --header'
  alias lt='eza -T --icons --git-ignore --level=3'
  alias ltl='eza -T -L 2 --icons --git-ignore'
  alias lta='eza -Ta --icons'
else
  alias ls='ls -G'
  alias ll='ls -la'
  alias la='ls -la'
fi

# Text processing
command -v bat >/dev/null 2>&1 && alias cat='bat --style=auto' || alias cat='cat'
command -v rg >/dev/null 2>&1 && alias rg_search='rg' || true
command -v fd >/dev/null 2>&1 && alias fd_search='fd' || true

# System monitoring
command -v dust >/dev/null 2>&1 && alias du='dust' || alias du='du -h'
command -v procs >/dev/null 2>&1 && alias ps='procs' || alias ps='ps aux'
command -v btop >/dev/null 2>&1 && alias top='btop' || alias top='htop'

# Editor
command -v micro >/dev/null 2>&1 && alias nano='micro' || true

# ================================================================
# NAVIGATION ALIASES
# ================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Zoxide integration
if command -v zoxide >/dev/null 2>&1; then
  # alias cd='z'
  alias zl='z -l'
  alias zi='z -i'
fi

# ================================================================
# GIT ALIASES
# ================================================================
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpo='git push origin'
alias gl='git pull'
alias glo='git pull origin'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias glog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gundo='git reset --soft HEAD~1'

# LazyGit
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit' || true

# Delta integration for git diff
if command -v delta >/dev/null 2>&1; then
  alias gd='git diff | delta'
  alias gds='git diff --staged | delta'
fi

# ================================================================
# DOCKER ALIASES
# ================================================================
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dstop='docker stop $(docker ps -q)'
alias dclean='docker system prune -f'
alias dvolumes='docker volume ls'

# ================================================================
# KUBERNETES ALIASES
# ================================================================
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'

# ================================================================
# SYSTEM UTILITIES
# ================================================================
alias ip='ipconfig getifaddr en0'
alias myip='curl -s https://ipinfo.io/ip'
alias ports='lsof -iTCP -sTCP:LISTEN -P'
alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias dush='du -sh * 2>/dev/null | sort -hr | head -10'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.zshrc'

# File management
alias cleanup='find . -name ".DS_Store" -type f -delete 2>/dev/null'
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'

# JSON/YAML processing
if command -v jq >/dev/null 2>&1; then
  alias jqp='jq -C . | less -R'
  alias jqs='jq -r "."'
fi

if command -v yq >/dev/null 2>&1; then
  alias yqp='yq -C . | less -R'
fi

# ================================================================
# FZF ALIASES & CONFIGURATION
# ================================================================
if command -v fzf >/dev/null 2>&1; then
  alias f='fzf'
  alias fh='history | fzf'
  alias fkill='ps aux | fzf | awk "{print \$2}" | xargs kill -9'

  if command -v bat >/dev/null 2>&1; then
    alias preview='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
  fi
fi

# ================================================================
# CUSTOM FUNCTIONS
# ================================================================

# Create directory and navigate to it
mkcd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mkcd <directory>"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
  echo "Created and moved to: $1"
}

# Create project directory structure
mkproject() {
  if [[ -z "$1" ]]; then
    echo "Usage: mkproject <project-name>"
    return 1
  fi

  local project_dir="$HOME/workspace/projects/$1"
  mkdir -p "$project_dir" && cd "$project_dir"

  # Create basic project structure
  mkdir -p {src,docs,tests}
  touch README.md .gitignore

  echo "# $1" > README.md
  echo "Created project structure for: $1"
}

# Git new branch with optional push
gnb() {
  if [[ -z "$1" ]]; then
    echo "Usage: gnb <branch-name> [push]"
    return 1
  fi

  git checkout -b "$1"

  if [[ "$2" == "push" ]]; then
    git push -u origin "$1"
  fi
}

# Kill process on specific port
killport() {
  if [[ -z "$1" ]]; then
    echo "Usage: killport <port>"
    return 1
  fi

  local pids=$(lsof -ti:$1)
  if [[ -n "$pids" ]]; then
    echo "Killing processes on port $1: $pids"
    echo "$pids" | xargs kill -9
  else
    echo "No processes found on port $1"
  fi
}

# Quick system information
sysinfo() {
  echo "=== System Information ==="
  echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
  echo "Kernel: $(uname -r)"
  echo "Shell: $SHELL"
  echo "Uptime: $(uptime)"

  # Temperature information
  if command -v osx-cpu-temp >/dev/null 2>&1; then
    local temp=$(osx-cpu-temp -c | command grep -o '[0-9]\+\.[0-9]\+')
    if [[ "$temp" != "0.0" && -n "$temp" ]]; then
      echo "CPU Temp: ${temp}°C"
    fi
  fi

  if command -v fastfetch >/dev/null 2>&1; then
    fastfetch --config none
  elif command -v neofetch >/dev/null 2>&1; then
    neofetch --config none --disable theme icons --color_blocks off
  else
    echo "Memory: $(vm_stat | head -4)"
    echo "Disk: $(df -h / | tail -1)"
    echo "CPU: $(sysctl -n machdep.cpu.brand_string)"

    # Additional system stats
    echo "Load Average: $(uptime | awk -F'load averages:' '{print $2}')"

    # Battery info (for laptops)
    if command -v pmset >/dev/null 2>&1; then
      local battery=$(pmset -g batt | command grep -o '[0-9]\+%' | head -1)
      if [[ -n "$battery" ]]; then
        echo "Battery: $battery"
      fi
    fi
  fi
}

# Upgrade Python version and reinstall packages
pyenv-upgrade() {
  if ! command -v pyenv >/dev/null 2>&1; then
    echo "❌ pyenv not installed"
    return 1
  fi

  local current=$(pyenv version-name)
  echo "🐍 Current Python version: $current"

  # Get latest available version
  local latest=$(pyenv install --list | 
    command grep -E '^\s*3\.[0-9]+\.[0-9]+$' | 
    command grep -v -E 'anaconda|miniconda|stackless' |
    sed 's/^[[:space:]]*//' | 
    sort -V | 
    tail -1)

  echo "🚀 Latest Python version: $latest"

  # Check if update is needed
  if [[ "$current" == "$latest" ]]; then
    echo "✅ Already on latest version!"
    return 0
  fi

  # Ask for confirmation
  echo "📦 This will:"
  echo "   1. Install Python $latest"
  echo "   2. Export packages from $current"
  echo "   3. Install all packages in $latest"
  echo "   4. Set $latest as global default"
  
  read "?Continue? (y/N): " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled"
    return 1
  fi

  # Create temp file for packages
  local temp_requirements="/tmp/pyenv_packages_$(date +%s).txt"

  echo "📋 Exporting current packages..."
  if command -v pip >/dev/null 2>&1; then
    pip freeze > "$temp_requirements"
    echo "   Saved $(wc -l < "$temp_requirements") packages"
  else
    echo "⚠️  No pip found, will only install basic packages"
    echo "pip" > "$temp_requirements"
  fi

  echo "⬇️  Installing Python $latest..."
  if ! pyenv install "$latest"; then
    echo "❌ Failed to install Python $latest"
    rm -f "$temp_requirements"
    return 1
  fi

  echo "🔧 Setting $latest as global default..."
  pyenv global "$latest"

  # Verify new installation
  echo "🧪 Testing new Python installation..."
  python --version

  echo "📦 Installing packages..."
  # Upgrade pip first
  pip install --upgrade pip

  # Install packages from requirements
  if [[ -s "$temp_requirements" ]]; then
    echo "   Installing $(wc -l < "$temp_requirements") packages..."
    if pip install -r "$temp_requirements"; then
      echo "✅ All packages installed successfully!"
    else
      echo "⚠️  Some packages failed to install, check manually:"
      echo "   pip install -r $temp_requirements"
      echo "   Requirements saved at: $temp_requirements"
      return 1
    fi
  fi

  # Cleanup
  rm -f "$temp_requirements"

  echo ""
  echo "🎉 Python upgrade completed!"
  echo "   Old version: $current"
  echo "   New version: $latest"
  echo "   Packages: Reinstalled"
  echo ""
  echo "💡 You can remove old version with: pyenv uninstall $current"
}

# Quick Python version upgrade check
pyenv-check-update() {
  if ! command -v pyenv >/dev/null 2>&1; then
    echo "pyenv not installed"
    return 1
  fi

  local current=$(pyenv version-name)
  local latest=$(pyenv install --list | 
    command grep -E '^\s*3\.[0-9]+\.[0-9]+$' | 
    command grep -v -E 'anaconda|miniconda|stackless' |
    sed 's/^[[:space:]]*//' | 
    sort -V | 
    tail -1)

  if [[ "$current" == "$latest" ]]; then
    echo "✅ Python $current (latest)"
  else
    echo "🔄 Python $current → $latest available"
    echo "   Run 'pyenv-upgrade' to update"
  fi
}

# Create Python virtual environment
mkvenv() {
  local venv_name="${1:-venv}"
  python3 -m venv "$venv_name"
  source "$venv_name/bin/activate"
  pip install --upgrade pip
  echo "Created and activated virtual environment: $venv_name"
}

# Search and replace in files
replace() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: replace <search> <replace> [file_pattern]"
    return 1
  fi

  local search="$1"
  local replace="$2"
  local pattern="${3:-*}"

  if command -v rg >/dev/null 2>&1 && command -v sd >/dev/null 2>&1; then
    rg -l "$search" --glob "$pattern" | xargs sd "$search" "$replace"
  else
    command find . -name "$pattern" -type f -exec sed -i '' "s/$search/$replace/g" {} +
  fi
}

# Quick HTTP server
serve() {
  local port="${1:-8000}"
  echo "Starting HTTP server on port $port..."
  python3 -m http.server "$port"
}

# ================================================================
# ENVIRONMENT VARIABLES
# ================================================================
export EDITOR='cursor'
export BROWSER='arc'
export LANG='en_US.UTF-8'

# Development
export PYTHONDONTWRITEBYTECODE=1
export NODE_OPTIONS="--max-old-space-size=8192"

# FZF configuration
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info --preview-window=right:50%"

# Path additions
export PATH="$HOME/.local/bin:$PATH"

# GPG
export GPG_TTY=$(tty)

# ================================================================
# CONDITIONAL SOURCING
# ================================================================

# Source additional local configuration if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ================================================================
# STARSHIP PROMPT
# ================================================================
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

echo "🚀 .zshrc loaded successfully!"