# MacOS Development Environment Setup

A comprehensive guide to setting up a MacOS development environment with pre-configured dotfiles and scripts.

## Table of Contents

- [Introduction](#introduction)
- [System Preferences](#system-preferences)
- [Terminal Setup](#terminal-setup)
  - [Homebrew](#homebrew)
  - [Terminal Apps](#terminal-apps)
  - [Oh My Zsh](#oh-my-zsh)
- [Development Tools](#development-tools)
  - [Package Managers](#package-managers)
  - [Programming Languages](#programming-languages)
  - [Databases](#databases)
- [Applications](#applications)
  - [Productivity Apps](#productivity-apps)
  - [Development Apps](#development-apps)
  - [SetApp Applications](#setapp-applications)
- [Visual Studio Code Setup](#visual-studio-code-setup)
  - [Recommended Extensions](#recommended-extensions)
  - [Settings](#settings)
- [Git Configuration](#git-configuration)
- [Project Structure](#project-structure)
- [Maintenance](#maintenance)

## Introduction

This repository contains configuration files, scripts, and documentation to set up a complete MacOS development environment. It includes terminal configuration, development tools, recommended applications, and best practices for Mac users, especially focused on web development.

## System Preferences

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

### Terminal Commands for System Preferences

```bash
# Take screenshots as JPG instead of PNG
defaults write com.apple.screencapture type jpg

# Don't reopen previous previewed files when opening a new one
defaults write com.apple.Preview ApplePersistenceIgnoreState YES

# Show Library folder
chflags nohidden ~/Library

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Reload Finder to apply changes
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

# Install Nerd Font for terminal
brew install --cask font-hack-nerd-font

# Install modern CLI tools
brew install eza bat fd ripgrep tldr fzf wget git delta zoxide mcfly jq yq starship commitizen
```

### Oh My Zsh

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Install essential plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
```

The repository includes a pre-configured `.zshrc` file with:

- History configuration
- Better completion setup
- Custom aliases for modern replacements of standard commands
- Useful functions like `mkcd` and `extract`
- Integration with tools like FZF, zoxide, and more

## Development Tools

### Package Managers

```bash
# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Configure environment
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

# Install SDKMAN for Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo 'source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.zshrc
```

### Programming Languages

```bash
# Node.js
nvm install node  # Install latest Node.js
npm install -g pnpm yarn typescript depcheck next-platter npm-check-updates

# Python
brew install pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc
pyenv install 3.13.2
pyenv global 3.13.2

# Poetry (Python dependency management)
curl -sSL https://install.python-poetry.org | python3 --
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
poetry config virtualenvs.in-project true

# Java
sdk install java
sdk install maven
```

### Databases

```bash
# Database Management Tools
brew install --cask dbeaver-community pgadmin4 sequel-ace dbngin

# TODO: Add database services
# Database Services (automatically managed by maintenance script)
# PostgreSQL, MongoDB, MySQL, and Redis can be installed and managed
# See the maintenance script for details
```

## Applications

### Development Apps

```bash
# Install Development Applications
brew install --cask \
  visual-studio-code \
  cursor \
  github \
  figma \
  postman \
  intellij-idea \
  pycharm

# Manual installation of Docker Desktop
# Download from https://www.docker.com/products/docker-desktop
echo "Remember to manually install Docker Desktop from the official website"

# AI Tools
brew install --cask claude chatgpt
```

### Productivity Apps

```bash
# Install Productivity Applications
brew install --cask \
  raycast \
  google-chrome \
  firefox \
  brave-browser \
  rectangle \
  calibre \
  vlc \
  skype \
  logi-options+ \
  imageoptim \
  alt-tab

# Install QuickLook plugins for developers
brew install --cask \
  qlcolorcode \     # Syntax highlighting in previews
  qlstephen \       # Preview files without extensions
  qlmarkdown \      # Preview Markdown files
  quicklook-json \  # Preview JSON files
  quicklook-csv \   # Preview CSV files
  webpquicklook \   # Preview WebP images
  suspicious-package \ # Preview .pkg files
  apparency \       # Preview apps and extensions
  qlvideo           # Preview videos

# Reload QuickLook to apply changes
qlmanage -r
```

### SetApp Applications

```bash
# Install SetApp
brew install --cask setapp latest
```

Recommended apps from SetApp include:

- Bartender (menu bar management)
- CleanShotX (screen capture)
- TablePlus (database management)
- Paste (clipboard manager)
- OneSwitch (system toggles)
- QuitAll (application manager)
- Mission Control Plus (window management)
- CleanMyMac (system maintenance)
- NotePlan (note-taking and planning)
- OpenIn (file opener)
- Better Zip (archive management)
- AirBuddy (AirPods integration)
- MagicMenu (menu extensions)
- Spark (email client)

## Visual Studio Code Setup

### Settings

The repository includes a `settings.json` file with optimized settings for development:

- Tokyo Night theme with customized colors
- Font configuration (Hack Nerd Font)
- Editor behavior optimizations
- Language-specific settings
- Git integration
- GitHub Copilot configuration

### Recommended Extensions

The repository contains scripts to install essential VS Code extensions:

```bash
# Core Extensions
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
code --install-extension eamodio.gitlens
code --install-extension ecmel.vscode-html-css
code --install-extension editorconfig.editorconfig
code --install-extension enkia.tokyo-night
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag

# GitHub Integration
code --install-extension github.copilot
code --install-extension github.copilot-chat
code --install-extension github.github-vscode-theme
code --install-extension github.vscode-github-actions

# Utility and Productivity
code --install-extension humao.rest-client
code --install-extension kisstkondoros.vscode-gutter-preview
code --install-extension lokalise.i18n-ally
code --install-extension meganrogge.template-string-converter
code --install-extension mikestead.dotenv
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-ceintl.vscode-language-pack-es
code --install-extension ms-playwright.playwright
code --install-extension ms-vscode-remote.remote-containers
code --install-extension naumovs.color-highlight
code --install-extension pflannery.vscode-versionlens
code --install-extension pkief.material-icon-theme

# Language Support
code --install-extension prisma.prisma
code --install-extension pustelto.bracketeer
code --install-extension quicktype.quicktype
code --install-extension ritwickdey.liveserver
code --install-extension shardulm94.trailing-spaces
code --install-extension stivo.tailwind-fold
code --install-extension stkb.rewrap
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension tombonnike.vscode-status-bar-format-toggle
code --install-extension unifiedjs.vscode-mdx
code --install-extension usernamehw.errorlens
code --install-extension vincaslt.highlight-matching-tag
code --install-extension vitest.explorer
code --install-extension vscode-icons-team.vscode-icons
code --install-extension wayou.vscode-todo-highlight
code --install-extension yoavbls.pretty-ts-errors

# Language-specific extensions
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension kevinrose.vsc-python-indent
code --install-extension njpwerner.autodocstring
code --install-extension vscjava.vscode-java-pack
code --install-extension redhat.java
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-java-debug
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension pmneo.tsimporter

# For Cursor editor (alternative to VS Code)
# Use the same extensions with cursor --install-extension instead of code --install-extension
```

All extensions match the complete list from the Steps.docx document. You can use this script to install them all at once, or pick the ones you need.

## Git Configuration

```bash
# Install GitHub CLI
brew install gh

# Configure Git user
git config --global user.name "Your Name"
git config --global user.email you@your-domain.com

# Set default branch to main
git config --global init.defaultBranch main

# Configure diff visualization
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

# Login to GitHub and check repositories
gh auth login
gh repo list

# Configure npm author details
npm set init-author-name="your name"
npm set init-author-email="you@example.com"
npm set init-author-url="example.com"
```

## Project Structure

```
~/workspace/
├── python/      # Python projects
├── typescript/  # TypeScript/JavaScript projects
├── java/        # Java projects
└── setup/       # Setup and configuration files
    ├── dotfiles/       # Configuration files (.zshrc, etc.)
    ├── mac-setup/      # MacOS setup scripts
    ├── dev-setup/      # Development environment setup
    └── setup-scripts/  # Maintenance and utility scripts
```

## Maintenance

The repository includes a comprehensive maintenance script (`maintenance-script.sh`) that:

- Updates Homebrew and its packages
- Updates Python and its packages
- Updates Node.js and npm packages
- Updates Java and related tools
- Manages database services
- Cleans up system caches
- Backs up configuration files

This script provides a menu-based interface with various options:

```bash
./maintenance-script.sh
```

The script offers these options:

1. Update everything
2. Update Homebrew and packages
3. Update Python and packages
4. Update Node.js, npm and pnpm
5. Update Java and tools
6. Update databases
7. Clean system
8. Check system status
9. Backup configurations

The script uses color-coded output and performs comprehensive checks to ensure your development environment stays up-to-date and optimized.

### Additional Utility Tools

```bash
# Install additional utilities
brew install p7zip unar  # Archive utilities
```

---

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
