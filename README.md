# MacOS Development Environment Setup

<p align="center">
  <img src="./assets/dmndev-logo.svg" alt="dmnDev Logo" width="300"/>
</p>

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![Last Commit](https://img.shields.io/github/last-commit/diegomnDev/setup?color=green)
![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)
![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)

A comprehensive guide to setting up a MacOS development environment with pre-configured dotfiles and scripts.

## Table of Contents

- [MacOS Development Environment Setup](#macos-development-environment-setup)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Why This Setup?](#why-this-setup)
    - [Who Is This For?](#who-is-this-for)
    - [Prerequisites](#prerequisites)
    - [System Preparation](#system-preparation)
    - [MacOS Settings](#macos-settings)
  - [System Preferences](#system-preferences)
    - [Terminal Commands for System Preferences](#terminal-commands-for-system-preferences)
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
      - [Raycast Configuration](#raycast-configuration)
    - [Development Apps](#development-apps)
    - [SetApp Applications](#setapp-applications)
    - [App Store Applications](#app-store-applications)
  - [Browser Extensions](#browser-extensions)
    - [Chrome/Brave Extensions](#chromebrave-extensions)
  - [Visual Studio Code Setup](#visual-studio-code-setup)
    - [Settings](#settings)
    - [Recommended Extensions](#recommended-extensions)
  - [Git Configuration](#git-configuration)
  - [Project Structure](#project-structure)
  - [Maintenance](#maintenance)
    - [Additional Utility Tools](#additional-utility-tools)
  - [Roadmap](#roadmap)
  - [Changelog](#changelog)
    - [v0.1.0 (2025-03-06)](#v010-2025-03-06)
    - [v0.2.0 (2025-003-22)](#v020-2025-003-22)
  - [Support](#support)
  - [License](#license)
  - [Contributing](#contributing)

## Introduction

This repository contains configuration files, scripts, and documentation to set up a complete MacOS development environment. It includes terminal configuration, development tools, recommended applications, and best practices for Mac users, especially focused on web development.

### Why This Setup?

Setting up a development environment on a new Mac can be time-consuming and tedious. This project aims to:

- **Save time**: Automate repetitive setup tasks
- **Standardize environments**: Ensure consistent configurations across machines
- **Optimize workflow**: Include best-in-class tools and configurations
- **Reduce friction**: Eliminate common setup issues and pitfalls
- **Share knowledge**: Document best practices for Mac development

### Who Is This For?

- Developers setting up a new Mac
- Teams wanting to standardize their development environments
- Anyone looking to improve their MacOS development workflow

### Prerequisites

- MacOS Ventura (13.0) or later
- Administrator access
- Internet connection
- At least 20GB of free disk space

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
brew install eza bat fd ripgrep tealdeer fzf wget git delta zoxide mcfly jq yq starship commitizen htop
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
# Option 1: Install via the official installer (manual approach)
curl -sSL https://install.python-poetry.org | python3 --
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# Option 2: Install via Homebrew (recommended for easier updates)
brew install poetry

# Common configuration (applies to both installation methods)
poetry config virtualenvs.in-project true


# Java
sdk install java
sdk install maven
```

### Databases

```bash
# Database Management Tools
brew install --cask dbeaver-community pgadmin4 sequel-ace dbngin
```

## Applications

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
  alt-tab \
  spotify

# Install QuickLook plugins for developers
brew install --cask \
  qlcolorcode \     # Syntax highlighting in previews
  qlstephen \       # Preview files without extensions
  qlmarkdown \      # Preview Markdown files
  quicklook-json \  # Preview JSON files
  quicklook-csv \   # Preview CSV files
  webpquicklook \   # Preview WebP images
  suspicious-package \  # Preview .pkg files
  apparency \       # Preview apps and extensions
  qlvideo           # Preview videos

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
  trae \
  github \
  figma \
  postman \
  mockoon

# Manual installation of Docker Desktop
# Download from https://www.docker.com/products/docker-desktop
echo "Remember to manually install Docker Desktop from the official website"

# AI Tools
brew install --cask claude chatgpt
```

Note: Some applications like Postman appear in both lists because they can be installed either via Homebrew or downloaded directly.

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

### App Store Applications

Install these applications from the Mac App Store:

- **Wappalyzer** - Technology profiler for websites
- **Octotree** - GitHub code tree
- **OctoLinker** - Navigate through GitHub repositories efficiently
- **File Icons for GitHub and GitLab** - Add file icons to GitHub and GitLab
- **1Blocker** - Ad blocker
- **Microsoft Office** - Word, Excel, PowerPoint, etc.

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
- Wappalyzer - Technology profiler
```

Install these extensions from the Chrome Web Store in your preferred browser.

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
code --install-extension yzhang.markdown-all-in-one
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

```code
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

## Roadmap

- [ ] Add examples of configured environments
- [ ] Include alternatives to recommended tools
- [ ] Add detailed database configuration guides
- [ ] Add Docker compose configurations for common development stacks
- [ ] Create sample projects for Python, Node.js, and Java
- [ ] Provide terminal cheatsheet with common commands
- [ ] Add specific development environment setups for different roles (Frontend, Backend, DevOps)

## Changelog

### v0.1.0 (2025-03-06)

- Initial repository setup
- Added basic documentation
- Included configuration files (.zshrc, settings.json)
- Added maintenance script

### v0.2.0 (2025-003-22)

- Added BBDD installation and configuration
- Added BBD management tools

## Support

If you find this project helpful, consider buying me a coffee.

<p align="center">
  <a href="https://www.buymeacoffee.com/dmndev"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="150"></a>
</p>

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
