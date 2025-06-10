<div align="center">

# MacOS Development Environment Setup

<p align="center">
  <img src="./assets/dmndev-logo.svg" alt="dmnDev Logo" width="300"/>
</p>

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![Last Commit](https://img.shields.io/github/last-commit/diegomnDev/setup?color=green)
![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)
![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)

</div>

A comprehensive guide to setting up a MacOS development environment with pre-configured dotfiles and automated setup scripts

## Table of Contents

- [MacOS Development Environment Setup](#macos-development-environment-setup)
      - [A comprehensive guide to setting up a MacOS development environment with pre-configured dotfiles and automated setup scripts.](#a-comprehensive-guide-to-setting-up-a-macos-development-environment-with-pre-configured-dotfiles-and-automated-setup-scripts)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Why This Setup?](#why-this-setup)
    - [Who Is This For?](#who-is-this-for)
    - [Prerequisites](#prerequisites)
  - [Quick Setup (Automated)](#quick-setup-automated)
    - [What the Setup Script Does](#what-the-setup-script-does)
    - [Running the Setup Script](#running-the-setup-script)
  - [Manual Setup](#manual-setup)
    - [System Preparation](#system-preparation)
    - [MacOS Settings](#macos-settings)
  - [System Preferences](#system-preferences)
    - [Terminal Commands for System Preferences](#terminal-commands-for-system-preferences)
  - [Terminal Setup](#terminal-setup)
    - [Homebrew](#homebrew)
    - [Terminal Apps](#terminal-apps)
    - [Modern CLI Tools](#modern-cli-tools)
    - [Oh My Zsh](#oh-my-zsh)
    - [iTerm2 Configuration](#iterm2-configuration)
  - [Development Tools](#development-tools)
    - [Version Managers](#version-managers)
    - [Programming Languages](#programming-languages)
    - [Databases](#databases)
  - [Applications](#applications)
    - [Productivity Apps](#productivity-apps)
      - [Raycast Configuration](#raycast-configuration)
    - [Development Apps](#development-apps)
    - [Browsers](#browsers)
    - [SetApp Applications](#setapp-applications)
    - [App Store Applications](#app-store-applications)
  - [Browser Extensions](#browser-extensions)
    - [Chrome/Brave Extensions](#chromebrave-extensions)
  - [Visual Studio Code/Cursor Setup](#visual-studio-codecursor-setup)
    - [Settings](#settings)
    - [Recommended Extensions](#recommended-extensions)
  - [Core Extensions](#core-extensions)
  - [GitHub Integration](#github-integration)
  - [UI/UX Enhancement](#uiux-enhancement)
  - [Utility Extensions](#utility-extensions)
  - [Git Configuration](#git-configuration)
  - [Essential Tools You Must Learn](#essential-tools-you-must-learn)
    - [Modern CLI Replacements](#modern-cli-replacements)
    - [Navigation and Search](#navigation-and-search)
    - [Git Workflow](#git-workflow)
    - [Development Workflow](#development-workflow)
    - [System Management](#system-management)
    - [Key Functions and Aliases](#key-functions-and-aliases)
  - [Project Structure](#project-structure)
  - [Maintenance](#maintenance)
    - [Using the Maintenance Script](#using-the-maintenance-script)
    - [Available Commands](#available-commands)
    - [Additional Utility Tools](#additional-utility-tools)
  - [Roadmap](#roadmap)
  - [Changelog](#changelog)
    - [v0.3.0 (2025-06-10)](#v030-2025-06-10)
    - [v0.2.1 (2025-03-22)](#v021-2025-03-22)
    - [v0.2.0 (2025-03-22)](#v020-2025-03-22)
    - [v0.1.0 (2025-03-06)](#v010-2025-03-06)
  - [Support](#support)
  - [License](#license)
  - [Contributing](#contributing)

## Introduction

This repository contains configuration files, automated setup scripts, and documentation to set up a complete MacOS development environment. It includes terminal configuration, development tools, recommended applications, and best practices for Mac users, especially focused on modern web development.

### Why This Setup?

Setting up a development environment on a new Mac can be time-consuming and tedious. This project aims to:

- **Save time**: Automate repetitive setup tasks with a single script
- **Standardize environments**: Ensure consistent configurations across machines
- **Optimize workflow**: Include best-in-class tools and configurations
- **Reduce friction**: Eliminate common setup issues and pitfalls
- **Share knowledge**: Document best practices for Mac development
- **Modern tools**: Use cutting-edge CLI tools that improve productivity

### Who Is This For?

- Developers setting up a new Mac
- Teams wanting to standardize their development environments
- Anyone looking to improve their MacOS development workflow
- Developers who want to learn modern CLI tools and workflows

### Prerequisites

- MacOS Ventura (13.0) or later
- Administrator access
- Internet connection
- At least 20GB of free disk space

## Quick Setup (Automated)

🚀 **NEW**: We now provide a comprehensive automated setup script that configures everything for you!

### What the Setup Script Does

The `setup_mac.sh` script provides a complete automated installation that includes:

✅ **System Preparation**

- Installs Rosetta 2 for Apple Silicon Macs
- Installs Xcode Command Line Tools
- Applies macOS optimizations and settings

✅ **Package Managers & CLI Tools**

- Homebrew installation and configuration
- Modern CLI tools (eza, bat, fd, ripgrep, fzf, etc.)
- Version managers (fnm, pyenv, SDKMAN, uv)

✅ **Terminal Setup**

- Warp and iTerm2 terminal applications
- Nerd Fonts (JetBrains Mono, Fira Code, Cascadia Code)
- Oh My Zsh with optimized configuration
- Starship prompt with Gruvbox Rainbow theme
- Homebrew zsh plugins (autosuggestions, syntax highlighting)

✅ **Development Environment**

- Node.js LTS via fnm
- Python 3.13.4 via pyenv
- Java via SDKMAN
- Global packages for each language

✅ **Applications**

- Code editors (VS Code, Cursor, Zed, Sublime Text)
- Database clients (DBeaver, DBngin)
- API clients (Bruno, Postman, Insomnia, Mockoon)
- Git clients (Fork, GitHub Desktop)
- Productivity apps (Raycast, Rectangle, Notion, etc.)
- Browsers (Arc, Chrome, Firefox, Brave, Edge)

✅ **Configuration**

- Optimized .zshrc with modern aliases and functions
- Git configuration with Delta integration
- VS Code settings and extensions
- System preferences optimization

✅ **Maintenance Tools**

- Downloads maintenance script from GitHub
- Creates workspace directory structure
- Backs up existing configurations

### Running the Setup Script

```bash
# Download and run the setup script
curl -fsSL https://raw.githubusercontent.com/diegomnDev/setup/main/mac-setup/setup_mac.sh -o setup_mac.sh
chmod +x setup_mac.sh
./setup_mac.sh
```

The script will:

1. Ask for your Git configuration (name, email, work email if dual setup)
2. Install and configure everything automatically
3. Provide progress updates and colored output
4. Create backups of existing configurations
5. Display a comprehensive summary at the end

**Estimated time**: 30-45 minutes depending on internet speed and system.

## Manual Setup

If you prefer to install components manually or want to understand each step, follow the sections below.

### System Preparation

```bash
# Install Rosetta 2 (required for running Intel-based apps on Apple Silicon Macs)
softwareupdate --install-rosetta --agree-to-license
```

### MacOS Settings

1. **Appearance:**
   - Enable Dark Mode
   - Show battery percentage
   - Configure Night Shift

2. **Dock:**
   - Make it smaller
   - Turn off "Show recent applications in Dock"
   - Enable auto-hide

3. **Finder:**
   - Set New Finder windows to show: Downloads
   - Configure sidebar favorites
   - Disable all tags
   - Show filename extensions
   - Set search to the current folder

4. **Safari:**
   - Set Safari to open with all windows from last session
   - Enable developer features

## System Preferences

### Terminal Commands for System Preferences

```bash
# Finder optimizations
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
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

# Privacy
defaults write com.apple.finder QLEnableTextSelection -bool true

# Reload affected applications
killall Finder
```

## Terminal Setup

### Homebrew

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Update Homebrew
brew update
```

### Terminal Apps

```bash
# Install terminal applications
brew install --cask warp iterm2

# Install Nerd Fonts for terminal
brew install --cask font-jetbrains-mono-nerd-font font-fira-code-nerd-font font-cascadia-code
```

### Modern CLI Tools

```bash
# Install modern CLI tools that replace traditional commands
brew install \
    eza \              # Modern ls replacement
    bat \              # Modern cat with syntax highlighting
    fd \               # Modern find replacement
    duf \              # Modern df replacement
    ripgrep \          # Modern grep replacement
    fzf \              # Fuzzy finder
    zoxide \           # Smart cd replacement
    btop \             # Modern htop replacement
    dust \             # Modern du replacement
    procs \            # Modern ps replacement
    hyperfine \        # Benchmarking tool
    git-delta \        # Better git diff viewer
    lazygit \          # Terminal UI for git
    glow \             # Markdown viewer
    jq \               # JSON processor
    yq \               # YAML processor
    wget \             # Download tool
    curl \             # HTTP client
    httpie \           # User-friendly HTTP client
    git \              # Version control
    gh \               # GitHub CLI
    tealdeer \         # Fast tldr implementation
    mcfly \            # Better shell history
    commitizen \       # Conventional commits
    mise \             # Runtime version manager
    direnv \           # Environment variable manager
    thefuck \          # Command correction
    micro \            # Modern terminal editor
    gnupg \            # Encryption
    fastfetch \        # System information
    glances            # System monitoring
```

### Oh My Zsh

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew zsh plugins (better than Oh My Zsh plugins)
brew install \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-completions

# Install Starship prompt
brew install starship

# Configure fzf
$(brew --prefix)/opt/fzf/install --all
```

### iTerm2 Configuration

The repository includes pre-configured iTerm2 profiles and color schemes:

**Import Profile:**

1. Open iTerm2
2. Go to Preferences > Profiles
3. Click "Other Actions" > Import JSON Profiles
4. Select `iterm_profile.json` from this repository

**Import Dracula Color Scheme:**

1. Download `Dracula.itermcolors` from this repository
2. Double-click the file to import it into iTerm2
3. In Preferences > Profiles > Colors, select "Dracula" from the Color Presets dropdown

The pre-configured profile includes:

- JetBrains Mono Nerd Font
- Optimized key bindings for development
- Proper transparency and blur settings
- 256-color terminal support

## Development Tools

### Version Managers

```bash
# Install fnm (Fast Node Manager) - Modern alternative to nvm
brew install fnm

# Install uv (Modern Python package manager)
brew install uv

# Install pyenv for Python versions
brew install pyenv

# Install SDKMAN for Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

### Programming Languages

```bash
# Node.js (via fnm)
fnm install --lts
fnm use lts-latest
npm install -g pnpm yarn typescript ts-node nodemon npm-check-updates serve next-platter

# Python (via pyenv)
pyenv install 3.13.4
pyenv global 3.13.4

# Install Python tools with uv
uv tool install black ruff mypy pytest jupyter-core pipx

# Java (via SDKMAN)
sdk install java
sdk install java 21.0.7-tem
sdk install maven
sdk install gradle
```

### Databases

```bash
# Database Management Tools
brew install --cask dbeaver-community dbngin

# Install databases via Homebrew (optional)
brew install postgresql redis
```

For detailed database installation and configuration instructions, including PostgreSQL, MariaDB, MongoDB, and Redis setup, please refer to the [Database Installation Guide](dev-setup/bbdd/db-installation-guide.md).

## Applications

### Productivity Apps

```bash
# Install Productivity Applications
brew install --cask \
  raycast \
  rectangle \
  alt-tab \
  notion \
  appcleaner \
  setapp \
  keka \
  imageoptim \
  calibre \
  vlc \
  spotify

# Install QuickLook plugins for developers
brew install --cask \
  qlcolorcode \       # Syntax highlighting in previews
  qlstephen \         # Preview files without extensions
  qlmarkdown \        # Preview Markdown files
  quicklook-json \    # Preview JSON files
  quicklook-csv \     # Preview CSV files
  webpquicklook \     # Preview WebP images
  suspicious-package \ # Preview .pkg files
  apparency \         # Preview apps and extensions
  qlvideo             # Preview videos

# Reload QuickLook to apply changes
qlmanage -r

# Note: After installing QuickLook plugins like qlmarkdown, you need to open a Markdown file
# and select "Open" when prompted about security. macOS requires you to explicitly approve
# the QuickLook generator the first time it runs. Until you do this, previews may not work properly.
```

#### Raycast Configuration

Raycast is a powerful alternative to Spotlight. After installation, configure these essential extensions:

- Clipboard History
- Window Management
- Calculator
- Calendar
- System Commands
- Terminal Commands
- Color Picker
- Password Generator

### Development Apps

```bash
# Install Development Applications
brew install --cask \
  visual-studio-code \
  cursor \
  zed \
  sublime-text \
  github \
  fork \
  figma \
  postman \
  insomnia \
  bruno \
  mockoon \
  dbeaver-community \
  dbngin \
  orbstack \          # Modern Docker Desktop alternative
  proxyman

# AI Tools
brew install --cask claude chatgpt
```

**Note**: OrbStack is recommended over Docker Desktop for better performance and resource usage on macOS.

### Browsers

```bash
# Install Web Browsers
brew install --cask \
  arc \
  google-chrome \
  firefox \
  brave-browser \
  microsoft-edge
```

### SetApp Applications

```bash
# Install SetApp
brew install --cask setapp latest
```

Recommended apps from SetApp include:

- **Bartender** - Menu bar management
- **CleanShotX** - Advanced screen capture
- **TablePlus** - Premium database management
- **Paste** - Advanced clipboard manager
- **OneSwitch** - System toggles
- **QuitAll** - Application manager
- **Mission Control Plus** - Enhanced window management
- **CleanMyMac** - System maintenance
- **NotePlan** - Note-taking and planning
- **OpenIn** - File opener
- **Better Zip** - Archive management
- **AirBuddy** - Enhanced AirPods integration
- **MagicMenu** - Menu extensions
- **Spark** - Modern email client
- **iStats** - System monitoring

### App Store Applications

Install these applications from the Mac App Store:

- **Wappalyzer** - Technology profiler for websites
- **1Blocker** - Content blocker for Safari
- **Microsoft Office** - Word, Excel, PowerPoint, etc.
- **Xcode** - iOS/macOS development (if needed)

## Browser Extensions

### Chrome/Brave Extensions

```code
# Productivity
- Checker Plus for Gmail™
- File Icons for GitHub and GitLab
- I don't care about cookies
- uBlock Origin
- Window Resizer

# Development
- JSON Viewer
- JSONVue
- Lighthouse
- OctoLinker
- Octotree - GitHub code tree
- React Developer Tools
- Vue.js devtools
- Wappalyzer - Technology profiler
```

Install these extensions from the Chrome Web Store in your preferred browser.

## Visual Studio Code/Cursor Setup

### Settings

The repository includes a `settings.json` file with optimized settings for development:

- Modern theme configuration
- Font configuration (JetBrains Mono Nerd Font)
- Editor behavior optimizations
- Language-specific settings
- Git integration
- GitHub Copilot configuration

### Recommended Extensions

The automated setup script installs all essential extensions. For manual installation:

## Core Extensions

```bash
code --install-extension aaron-bond.better-comments
code --install-extension austenc.tailwind-docs
code --install-extension bradgashler.htmltagwrap
code --install-extension bradlc.vscode-tailwindcss
code --install-extension christian-kohler.npm-intellisense
code --install-extension christian-kohler.path-intellisense
code --install-extension chunsen.bracket-select
code --install-extension csstools.postcss
code --install-extension davidanson.vscode-markdownlint
code --install-extension dbaeumer.vscode-eslint
code --install-extension donjayamanne.githistory
code --install-extension dsznajder.es7-react-js-snippets
code --install-extension eamodio.gitlens
code --install-extension ecmel.vscode-html-css
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension editorconfig.editorconfig
```

## GitHub Integration

```bash
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension github.vscode-pull-request-github
code --install-extension github.vscode-github-actions
```

## UI/UX Enhancement

```bash
code --install-extension pustelto.bracketeer
code --install-extension stivo.tailwind-fold
```

## Utility Extensions

```bash
code --install-extension humao.rest-client
code --install-extension kisstkondoros.vscode-gutter-preview
code --install-extension lokalise.i18n-ally
code --install-extension meganrogge.template-string-converter
code --install-extension mikestead.dotenv
code --install-extension ms-azuretools.vscode-containers
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-ceintl.vscode-language-pack-es
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension naumovs.color-highlight
code --install-extension pflannery.vscode-versionlens
code --install-extension pkief.material-icon-theme
code --install-extension pmneo.tsimporter
code --install-extension pranaygp.vscode-css-peek
code --install-extension quicktype.quicktype
code --install-extension redhat.vscode-yaml
code --install-extension ritwickdey.liveserver
code --install-extension saoudrizwan.claude-dev
code --install-extension shardulm94.trailing-spaces
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension streetsidesoftware.code-spell-checker-spanish
code --install-extension tombonnike.vscode-status-bar-format-toggle
code --install-extension unifiedjs.vscode-mdx
code --install-extension usernamehw.errorlens
code --install-extension vincaslt.highlight-matching-tag
code --install-extension wayou.vscode-todo-highlight
code --install-extension yoavbls.pretty-ts-err
```

**For Cursor editor**, replace `code` with `cursor` in the commands above.

## Git Configuration

```bash
# Install GitHub CLI
brew install gh

# Configure Git user
git config --global user.name "Your Name"
git config --global user.email you@your-domain.com

# Set default branch to main
git config --global init.defaultBranch main

# Configure editor
git config --global core.editor "cursor --wait"

# Configure Delta for better diffs
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

# Login to GitHub and check repositories
gh auth login
gh repo list

# Configure npm author details
npm set init-author-name="your name"
npm set init-author-email="you@example.com"
npm set init-author-url="example.com"
```

## Essential Tools You Must Learn

🎯 **This section contains the most important tools and commands you should master for maximum productivity.**

### Modern CLI Replacements

**Learn these immediately - they replace traditional commands:**

| Traditional | Modern Alternative | Why Learn It |
|-------------|-------------------|--------------|
| `ls` | `eza` (`ls`, `ll`, `la` aliases) | Icons, git status, better formatting |
| `cat` | `bat` | Syntax highlighting, line numbers |
| `grep` | `ripgrep` (`rg`) | Faster, better defaults, respects .gitignore |
| `find` | `fd` | Simpler syntax, faster, respects .gitignore |
| `cd` | `zoxide` (`z` command) | Smart directory jumping based on frequency |
| `du` | `dust` | Visual disk usage with charts |
| `top/htop` | `btop/glances` | Beautiful system monitoring |
| `ps` | `procs` | Better process viewer with search |
| `nano` | `micro` | Modern terminal editor with mouse support, syntax highlighting |

**Essential commands to practice:**

```bash
# Navigation
z project-name     # Jump to frequently used directories
ll                 # List files with icons and git status
la                 # List all files including hidden

# File operations
bat config.json    # View file with syntax highlighting
rg "searchterm"    # Search in files (faster than grep)
fd "filename"      # Find files (simpler than find)

# System monitoring
btop              # System monitor
glances           # Cross-platform system monitor with web interface
glances -w        # Web interface (access via http://localhost:61208)
dust              # Disk usage analyzer
procs             # Process viewer
```

### Navigation and Search

**FZF (Fuzzy Finder) - CRITICAL to learn:**

```bash
fzf                    # Fuzzy find files
Ctrl+R                 # Fuzzy search command history
Ctrl+T                 # Fuzzy find files and insert in command
Alt+C                  # Fuzzy find directories and cd
preview <filename>     # Preview files with fzf and bat
```

**Zoxide (Smart cd) - Learn these patterns:**

```bash
z project             # Jump to project directory
z doc                 # Jump to documents
zi                    # Interactive directory selection
zl                    # List frequent directories
```

### Git Workflow

**LazyGit - Visual Git interface (ESSENTIAL):**

```bash
lg                    # Launch LazyGit
# Learn these keys in LazyGit:
# - Space: Stage/unstage
# - c: Commit
# - P: Push
# - p: Pull
# - Tab: Switch panels
```

**Git with Delta (Better diffs):**

```bash
gd                    # Git diff with Delta (beautiful output)
gds                   # Git diff staged
glog                  # Beautiful git log
gs                    # Git status (short format)
```

### Development Workflow

**Version Managers - Master these:**

```bash
# Node.js with fnm
fnm install 20        # Install Node 20
fnm use 20            # Use Node 20
fnm list             # List installed versions

# Python with pyenv
pyenv install 3.12.0  # Install Python version
pyenv global 3.12.0   # Set global version
pyenv versions        # List versions
pyenv-upgrade         # Custom function to upgrade Python

# Java with SDKMAN
sdk install java 21   # Install Java 21
sdk use java 21       # Use Java 21
sdk list java        # List available versions
```

**Package Managers:**

```bash
# Node.js
pnpm install         # Faster than npm
pnpm dev            # Run development server

# Python with uv (MUCH faster than pip)
uv add package      # Add package
uv run script.py    # Run Python script
uv tool install    # Install global tools
```

### System Management

**Maintenance Script - Run regularly:**

```bash
maintenance-script all                      # Update everything
maintenance-script check                    # System diagnostics
maintenance-script brew py node java clean  # Update for specific components
```

**Homebrew Management:**

```bash
brew update && brew upgrade  # Update packages
brew cleanup                # Clean old versions
brew doctor                 # Health check
```

### Key Functions and Aliases

**Custom Functions (defined in .zshrc):**

```bash
mkcd project-name       # Create directory and cd into it
mkproject name          # Create full project structure
gnb feature-branch      # Git new branch
killport 3000           # Kill process on port 3000
sysinfo                 # System information
pyenv-upgrade           # Upgrade Python and reinstall packages
mkvenv                  # Create Python virtual environment
serve 8080              # Start HTTP server on port
```

**Essential Aliases:**

```bash
# Navigation
..                   # cd ..
...                  # cd ../..
....                 # cd ../../..
~                    # cd ~

# Git shortcuts
g                    # git
gs                   # git status
ga                   # git add
gaa                  # git add .
gc                   # git commit
gcm                  # git commit -m
gp                   # git push
gl                   # git pull

# System
ip                   # Get local IP
myip                 # Get public IP
ports                # Show listening ports
reload               # Reload .zshrc
cleanup              # Remove .DS_Store files
```

**Docker/Container Management (with OrbStack):**

```bash
d                    # docker
dc                   # docker-compose
dps                  # docker ps
dimg                 # docker images
dstop                # Stop all containers
dclean               # Clean system
```

## Project Structure

```code
~/workspace/
├── personal/      # Personal projects
├── work/          # Work projects
├── experiments/   # Experimental code
└── setup/         # Setup and configuration files
    ├── dotfiles/       # Configuration files (.zshrc, etc.)
    ├── mac-setup/      # MacOS setup scripts
    ├── dev-setup/      # Development environment setup
    └── setup-scripts/  # Maintenance and utility scripts
```

## Maintenance

The repository includes a comprehensive maintenance script that automatically downloads from GitHub during setup.

### Using the Maintenance Script

The script is automatically downloaded and installed during the setup process:

```bash
# Run complete system update
maintenance-script all

# Or run selective updates for specific components
maintenance-script brew py node java clean

# Run system diagnostics
maintenance-script check

# Get help
maintenance-script
```

### Available Commands

The maintenance script supports the following commands:

- `all` or `update` - Run complete system update
- `check`, `status`, or `diagnostics` - Display system information
- `clean` or `cleanup` - Clean system caches
- `backup` - Backup configurations
- `homebrew` or `brew` - Update only Homebrew
- `python` or `py` - Update only Python tools
- `node`, `nodejs`, or `npm` - Update only Node.js
- `java` - Update only Java tools
- `db` or `databases` - Manage database services
- `delete` or `remove` - Delete old backups

The script provides:

- Updates Homebrew and its packages
- Updates Python and its packages via uv
- Updates Node.js and npm packages via fnm
- Updates Java and related tools via SDKMAN
- Manages database services
- Cleans up system caches
- Runs system diagnostics
- Backup configurations
- Delete old backups

### Additional Utility Tools

```bash
# Install additional utilities
# Archive utilities
brew install p7zip unar
```

## Roadmap

- [ ] Add backup script to export current configuration before formatting
- [ ] Create restore script to quickly apply saved preferences
- [ ] Add troubleshooting guide for common macOS setup issues
- [ ] Add script to sync dotfiles with personal GitHub repository
- [ ] Provide terminal cheatsheet with common commands

## Changelog

### v0.3.0 (2025-06-10)

- **NEW**: Complete automated setup script (`setup_mac.sh`)
- **NEW**: Automated maintenance script download from GitHub
- **NEW**: Modern CLI tools integration (eza, bat, fd, ripgrep, zoxide, etc.)
- **NEW**: Version managers setup (fnm, pyenv, uv, SDKMAN)
- **NEW**: iTerm2 profile and Dracula color scheme
- **NEW**: Essential tools learning guide
- **UPDATED**: Complete VS Code/Cursor extensions list
- **UPDATED**: Starship prompt with Gruvbox Rainbow theme
- **UPDATED**: Optimized .zshrc with modern aliases and functions
- **UPDATED**: Application list with latest tools
- **IMPROVED**: Documentation structure and clarity

### v0.2.1 (2025-03-22)

- Added Docker Compose configuration for all databases
- Added initialization scripts for each database system
- Added container volume persistence
- Added container management commands

### v0.2.0 (2025-03-22)

- Added PostgreSQL, MariaDB, MongoDB, and Redis database configurations
- Added database connection and management instructions

### v0.1.0 (2025-03-06)

- Initial repository setup
- Added basic documentation
- Included configuration files (.zshrc, settings.json)
- Added basic maintenance script

## Support

If you find this project helpful, consider buying me a coffee.

<p align="center">
  <a href="https://www.buymeacoffee.com/dmndev"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="150"></a>
</p>

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
