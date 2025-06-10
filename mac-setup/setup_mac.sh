#!/bin/bash

# ================================================================
# macOS Developer Complete Setup 2025 - UPDATED VERSION
#
# Automated setup script that configures a complete development
# environment with the latest configurations and improvements
# ================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_section() { echo -e "${PURPLE}[SECTION]${NC} $1"; }

# Check if script is run as root
if [[ $EUID -eq 0 ]]; then
   log_error "This script should not be run as root"
   exit 1
fi

# Welcome message
clear
echo -e "${CYAN}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║               macOS Developer Setup 2025                     ║
║                     UPDATED VERSION                          ║
║                                                              ║
║  Complete automated setup for modern development workflow    ║
║  With optimized .zshrc, Starship, and latest tools           ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

log_info "Starting macOS Developer Setup..."
log_warning "This script will install and configure various tools."
echo

# Configuration options
read -p "Do you want to configure Git with work/personal dual setup? [y/N]: " SETUP_GIT_DUAL
read -p "Enter your name for Git config: " GIT_NAME
read -p "Enter your email for Git config: " GIT_EMAIL
if [[ $SETUP_GIT_DUAL =~ ^[Yy]$ ]]; then
    read -p "Enter your work email: " GIT_WORK_EMAIL
fi

echo
log_info "Configuration complete. Starting installation..."
sleep 2

# ================================================================
# SYSTEM PREPARATION
# ================================================================
log_section "🍎 System Preparation"

# Install Rosetta 2 for Apple Silicon Macs
if [[ $(uname -m) == "arm64" ]]; then
    log_info "Installing Rosetta 2 for Apple Silicon..."
    sudo softwareupdate --install-rosetta --agree-to-license
fi

# Install Xcode Command Line Tools
log_info "Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    xcode-select --install
    log_warning "Please complete Xcode Command Line Tools installation and re-run script"
    exit 1
fi

# ================================================================
# PACKAGE MANAGER SETUP
# ================================================================
log_section "📦 Package Manager Setup"

# Install Homebrew
if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    log_info "Homebrew already installed. Updating..."
    brew update
fi

# ================================================================
# TERMINAL & SHELL SETUP
# ================================================================
log_section "⚡ Terminal & Shell Setup"

# Install modern terminal
log_info "Installing Warp terminal..."
brew install --cask warp

# Install iTerm2 as backup
log_info "Installing iTerm2 as backup..."
brew install --cask iterm2

# Install fonts
log_info "Installing developer fonts..."
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-cascadia-code

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Starship prompt
log_info "Installing Starship prompt..."
brew install starship

# ================================================================
# MODERN CLI TOOLS
# ================================================================
log_section "🛠️ Modern CLI Tools"

log_info "Installing modern CLI replacements..."
brew install \
    eza \
    bat \
    fd \
    duf \
    ripgrep \
    fzf \
    zoxide \
    btop \
    dust \
    procs \
    hyperfine \
    git-delta \
    lazygit \
    glow \
    jq \
    yq \
    wget \
    curl \
    httpie \
    git \
    gh \
    tealdeer \
    mcfly \
    commitizen \
    mise \
    direnv \
    thefuck \
    micro \
    gnupg \
    fastfetch \
    glances \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-completions

# Configure fzf
$(brew --prefix)/opt/fzf/install --all

# Fix Homebrew zsh plugins permissions
log_info "Fixing Homebrew zsh plugins permissions..."
chmod go-w '/opt/homebrew/share' 
chmod -R go-w '/opt/homebrew/share/zsh'

# ================================================================
# VERSION MANAGERS
# ================================================================
log_section "🔧 Version Managers"

# Install fnm (Fast Node Manager)
log_info "Installing fnm (Node.js version manager)..."
brew install fnm

# Install uv (Python package manager)
log_info "Installing uv (Python package manager)..."
brew install uv

# Install pyenv for Python versions
log_info "Installing pyenv..."
brew install pyenv

# Install SDKMAN for Java
log_info "Installing SDKMAN for Java..."
if [[ ! -d "$HOME/.sdkman" ]]; then
    curl -s "https://get.sdkman.io" | bash
fi

# ================================================================
# DEVELOPMENT TOOLS
# ================================================================
log_section "💻 Development Tools"

# Editors
log_info "Installing code editors..."
brew install --cask cursor
brew install --cask zed
brew install --cask visual-studio-code
brew install --cask sublime-text

# Database clients
log_info "Installing database clients..."
# brew install --cask tableplus --> Setapp
brew install --cask dbeaver-community
brew install --cask dbngin

# API clients
log_info "Installing API clients..."
brew install --cask bruno
brew install --cask postman
brew install --cask insomnia
brew install --cask mockoon

# Git clients
log_info "Installing Git clients..."
brew install --cask fork
brew install --cask github

# Design tools
log_info "Installing design tools..."
brew install --cask figma

# Development utilities
log_info "Installing development utilities..."
# brew install --cask docker
brew install --cask orbstack  # Alternative to Docker Desktop
brew install --cask proxyman

# ================================================================
# PRODUCTIVITY APPS
# ================================================================
log_section "🚀 Productivity Applications"

# Core productivity
log_info "Installing core productivity apps..."
brew install --cask raycast
brew install --cask rectangle
brew install --cask alt-tab
brew install --cask notion

# Menu bar utilities
log_info "Installing menu bar utilities..."
# brew install --cask bartender --> Setapp
# brew install --cask stats --> iStats Setapp
# brew install --cask cleanshot --> Setapp

# Utilities
log_info "Installing utilities..."
brew install --cask appcleaner
brew install --cask latest
brew install --cask setapp
brew install --cask keka
brew install --cask imageoptim
# brew install --cask cleanmymac --> Setapp

# ================================================================
# BROWSERS
# ================================================================
log_section "🌐 Web Browsers"

log_info "Installing web browsers..."
brew install --cask arc
brew install --cask google-chrome
brew install --cask firefox
brew install --cask brave-browser
brew install --cask microsoft-edge

# ================================================================
# QUICKLOOK PLUGINS
# ================================================================
log_section "🔍 QuickLook Plugins"

log_info "Installing QuickLook plugins..."
brew install --cask qlcolorcode
brew install --cask qlstephen
brew install --cask qlmarkdown
brew install --cask quicklook-json
brew install --cask quicklook-csv
brew install --cask webpquicklook
brew install --cask suspicious-package
brew install --cask apparency
brew install --cask qlvideo

# Reload QuickLook
qlmanage -r

# ================================================================
# MULTIMEDIA & COMMUNICATION
# ================================================================
log_section "📱 Multimedia & Communication"

log_info "Installing multimedia apps..."
brew install --cask vlc
brew install --cask spotify
brew install --cask calibre
brew install --cask iina
# brew install --cask slack --> Microsft Teams
# brew install --cask zoom --> Microsft Teams

# AI assistants
brew install --cask claude
brew install --cask chatgpt

# ================================================================
# SYSTEM CONFIGURATION
# ================================================================
log_section "⚙️ System Configuration"

log_info "Applying macOS optimizations..."

# Performance optimizations - I love it but I prefer to test 1 by 1
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# defaults write com.apple.dock expose-animation-duration -float 0.1
# defaults write com.apple.dock autohide-delay -float 0
# defaults write com.apple.dock autohide-time-modifier -float 0.5

# Finder optimizations
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Show Library folder
chflags nohidden ~/Library

# Preview optimizations
defaults write com.apple.Preview ApplePersistenceIgnoreState YES

# Keyboard optimizations
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 2
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Screenshot optimizations
defaults write com.apple.screencapture type jpg
defaults write com.apple.screencapture disable-shadow -bool true
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots
defaults write com.apple.screencapture include-date -bool true

# Trackpad improvements
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
# defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Security
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# Privacy
defaults write com.apple.finder QLEnableTextSelection -bool true

# ================================================================
# SHELL CONFIGURATION
# ================================================================
log_section "🐚 Shell Configuration"

log_info "Configuring optimized .zshrc..."

# Backup existing .zshrc
if [[ -f ~/.zshrc ]]; then
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create optimized .zshrc configuration
cat > ~/.zshrc << 'EOF'
# ================================================================
# macOS Developer .zshrc 2025
# Generated by automated setup script
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

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

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
EOF

# ================================================================
# STARSHIP CONFIGURATION
# ================================================================
log_section "⭐ Starship Configuration"

log_info "Configuring Starship with Gruvbox Rainbow preset..."
mkdir -p ~/.config

# Install Gruvbox Rainbow preset
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# ================================================================
# GIT CONFIGURATION
# ================================================================
log_section "🌿 Git Configuration"

# Configure global Git settings
log_info "Configuring Git..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global core.editor "cursor --wait"
git config --global core.pager "delta"
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side true
git config --global merge.conflictstyle zdiff3
git config --global diff.colorMoved default

# Git aliases
git config --global alias.st "status"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.ci "commit"
git config --global alias.unstage "reset HEAD --"
git config --global alias.last "log -1 HEAD"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Dual Git configuration if requested
if [[ $SETUP_GIT_DUAL =~ ^[Yy]$ ]]; then
    log_info "Setting up dual Git configuration..."

    # Create workspace directories
    mkdir -p ~/workspace/{personal,work}

    # Configure work-specific Git config
    cat > ~/.gitconfig-work << EOF
[user]
    name = $GIT_NAME
    email = $GIT_WORK_EMAIL

[core]
    sshCommand = "ssh -i ~/.ssh/id_rsa_work"
EOF

    # Add includeIf to main config
    git config --global includeIf.gitdir:~/workspace/work/.path ~/.gitconfig-work

    log_success "Dual Git configuration complete!"
    log_info "Personal repos: ~/workspace/personal/"
    log_info "Work repos: ~/workspace/work/"
fi

# ================================================================
# NODE.JS SETUP
# ================================================================
log_section "📦 Node.js Setup"

log_info "Installing Node.js LTS..."

# Source the current shell configuration to get fnm available
eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true
eval "$(fnm env --use-on-cd)" 2>/dev/null || true

# Install Node.js LTS
fnm install --lts
fnm default lts-latest

# Verify Node.js and npm are available
if command -v npm &>/dev/null; then
    log_info "Installing global npm packages..."
    npm install -g \
        pnpm \
        yarn \
        typescript \
        ts-node \
        nodemon \
        npm-check-updates \
        serve \
        next-platter
    log_success "Global npm packages installed successfully!"
else
    log_warning "npm not found in PATH. Please restart terminal and run:"
    log_warning "npm install -g pnpm yarn typescript ts-node nodemon npm-check-updates serve next-platter"
fi

# ================================================================
# PYTHON SETUP
# ================================================================
log_section "🐍 Python Setup"

log_info "Installing Python..."

# Initialize pyenv in current session
eval "$(pyenv init - zsh)" 2>/dev/null || true

# Check if Python 3.13.4 is already installed
if ! pyenv versions | grep -q "3.13.3"; then
    pyenv install 3.13.4
fi
pyenv global 3.13.4

# Install global Python tools with uv
log_info "Installing Python tools with uv..."
uv tool install black
uv tool install ruff
uv tool install mypy
uv tool install pytest
uv tool install jupyter-core
uv tool install pipx

# ================================================================
# JAVA SETUP
# ================================================================
log_section "☕ Java Setup"

log_info "Installing Java..."
# Source SDKMAN if available
if [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install java
    sdk install java 21.0.7-tem
    sdk install maven
    sdk install gradle
    log_success "Java tools installed successfully!"
else
    log_warning "SDKMAN not found. Please restart terminal and run:"
    log_warning "sdk install java && sdk install maven && sdk install gradle"
fi

# ================================================================
# MAINTENANCE SCRIPT
# ================================================================
log_section "🧹 Maintenance Script"

log_info "Downloading system maintenance script from GitHub..."
mkdir -p ~/.local/bin

# Download the maintenance script from GitHub
if curl -fsSL https://raw.githubusercontent.com/diegomnDev/setup/refs/heads/main/mac-setup/maintenance-script.sh -o ~/.local/bin/maintenance-script; then
    chmod +x ~/.local/bin/maintenance-script
    log_success "Maintenance script downloaded and installed successfully!"
    log_info "You can run it with: maintenance-script"
else
    log_warning "Failed to download maintenance script from GitHub"
    log_info "You can manually download it from:"
    log_info "https://raw.githubusercontent.com/diegomnDev/setup/refs/heads/main/mac-setup/maintenance-script.sh"
    log_info "Save it as ~/.local/bin/maintenance-script and make it executable with: chmod +x ~/.local/bin/maintenance-script"
fi

# ================================================================
# FINAL STEPS
# ================================================================
log_section "🎯 Final Steps"

# Create workspace directories
log_info "Creating workspace structure..."
mkdir -p ~/workspace/{personal,work,experiments}
mkdir -p ~/Screenshots
mkdir -p ~/.local/bin

# Restart affected applications
log_info "Restarting system components..."
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done

# ================================================================
# COMPLETION MESSAGE
# ================================================================
clear
echo -e "${CYAN}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║             SETUP COMPLETE! 🎉               ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

log_success "macOS Developer Setup 2025 completed successfully!"
echo
log_info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Set up SSH keys for Git repositories"
echo "  3. Install any additional paid apps from App Store"
echo "  4. Install additional paid apps from Setapp"
echo "  5. Configure Raycast extensions and shortcuts"
echo "  6. Set up Rectangle window management shortcuts"
echo "  7. Install hardware-specific software (Logi Options+, DisplayPilot 2)"
echo "  8. Install browser extensions for Safari, Chrome, and Arc"
echo "  9. Install extensions and configure settings in VSCode and Cursor"
echo " 10. Install plugins and configure settings in IntelliJ IDEA"
echo " 11. Configure GPG key for signing commits (if needed)"
echo " 12. Review and customize .zshrc, .gitconfig, and other dotfiles"
echo " 13. Run 'update-system check' to verify system tools"
echo " 14. Install Microsoft Office from App Store if needed"
echo " 15. Explore and enjoy your new development environment!"

echo
log_info "Optional terminal configuration:"
echo "  • iTerm2 and Warp profiles available for manual import"
echo "  • Dracula color scheme and custom profiles can be configured"

echo
log_info "Useful commands:"
echo "  • update-system all    - Update everything"
echo "  • update-system check  - System diagnostics"
echo "  • btop                 - System monitoring"
echo "  • lg                   - Git GUI (lazygit)"
echo "  • pyenv-upgrade        - Upgrade Python and reinstall packages"
echo "  • mkproject <name>     - Create new project structure"
echo "  • killport <port>      - Kill process on specific port"
echo "  • sysinfo              - Quick system information"

echo
log_info "Workspace directories created:"
echo "  • ~/workspace/personal    - Personal projects"
echo "  • ~/workspace/work        - Work projects"
echo "  • ~/workspace/experiments - Experimental code"

echo
log_warning "Some changes require logout/restart to take full effect"
log_success "Enjoy your optimized macOS development environment! 🚀"

echo
log_info "Features included:"
echo "  ✅ Optimized .zshrc with modern CLI tools"
echo "  ✅ Starship prompt with Gruvbox Rainbow theme"
echo "  ✅ Homebrew zsh plugins (autosuggestions, syntax highlighting)"
echo "  ✅ Complete development toolchain (Node.js, Python, Java)"
echo "  ✅ Modern CLI replacements (eza, bat, fd, ripgrep, etc.)"
echo "  ✅ Git configuration with Delta integration"
echo "  ✅ System maintenance scripts"
echo "  ✅ Productivity applications and utilities"