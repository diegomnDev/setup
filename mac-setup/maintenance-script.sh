#!/bin/bash

# ================================================================
# macOS Maintenance Script 2025 - Enhanced Version
# Combines the best of both maintenance scripts with modern tools
# ================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ================================================================
# LOGGING FUNCTIONS
# ================================================================

# Enhanced logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_section() { echo -e "${PURPLE}[SECTION]${NC} $1"; }

# Function to print formatted messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}=== ${message} ===${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ================================================================
# HOMEBREW FUNCTIONS
# ================================================================

update_homebrew() {
    log_section "🍺 Updating Homebrew and packages"

    if command_exists brew; then
        # Update Homebrew
        log_info "Updating Homebrew itself..."
        brew update

        # Upgrade packages
        log_info "Upgrading installed packages..."
        brew upgrade

        # Cleanup old versions
        log_info "Cleaning up old versions..."
        brew cleanup -s

        # Run brew doctor for health check
        log_info "Running brew doctor..."
        if brew doctor; then
            log_success "Homebrew is healthy!"
        else
            log_warning "Homebrew doctor found some issues"
        fi

        log_success "Homebrew updated successfully"
    else
        log_error "Homebrew is not installed"
        return 1
    fi
}

# ================================================================
# PYTHON FUNCTIONS
# ================================================================

update_python() {
    log_section "🐍 Updating Python and packages"

    # Update pyenv if available
    if command_exists pyenv; then
        log_info "Updating pyenv..."

        # Update pyenv via Homebrew if installed that way
        if brew list | grep -q pyenv; then
            brew upgrade pyenv
        fi

        # List installed versions
        log_info "Python versions installed:"
        pyenv versions

        # Get current version
        local current_version=$(pyenv version-name)
        log_info "Current Python version: $current_version"

        # Update pip for current version
        log_info "Updating pip..."
        pip install --upgrade pip

        # Update global packages
        log_info "Updating global Python packages..."
        pip list --outdated --format=freeze 2>/dev/null | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U 2>/dev/null || true

        log_success "Python and packages updated successfully"
    else
        log_warning "pyenv is not installed"
    fi

    # Update uv (modern Python package manager)
    if command_exists uv; then
        log_info "Updating uv Python tools..."
        uv tool upgrade --all
        log_success "uv tools updated successfully"
    else
        log_info "uv not found - consider installing for faster Python package management"
    fi

    # Update Poetry if available
    if command_exists poetry; then
        log_info "Updating Poetry..."
        poetry self update
        log_success "Poetry updated successfully"
    fi
}

# ================================================================
# NODE.JS FUNCTIONS
# ================================================================

update_node() {
    log_section "📦 Updating Node.js and packages"

    # Handle fnm (modern, faster alternative to nvm)
    if command_exists fnm; then
        log_info "Using fnm for Node.js management..."

        # Source fnm
        eval "$(fnm env --use-on-cd)"

        # Install latest LTS
        log_info "Installing latest LTS Node.js..."
        fnm install --lts
        fnm use lts-latest

        # Update npm
        log_info "Updating npm..."
        npm install -g npm@latest

        # Update global npm packages
        log_info "Updating global npm packages..."
        npm update -g

        log_success "Node.js (via fnm) and npm updated successfully"
    else
        log_warning "fnm is not installed"
    fi

    # Update pnpm if available
    if command_exists pnpm; then
        log_info "Updating pnpm..."
        npm update -g pnpm
        log_info "Updating global pnpm packages..."
        pnpm update -g 2>/dev/null || log_warning "Some pnpm global packages may have failed to update"
        log_success "pnpm packages updated successfully"
    fi

    # Update yarn if available
    if command_exists yarn; then
        log_info "Updating yarn..."
        npm install -g yarn@latest
        log_success "yarn updated successfully"
    fi
}

# ================================================================
# JAVA FUNCTIONS
# ================================================================

update_java() {
    log_section "☕ Updating Java and related tools"

    # Check for SDKMAN (it's a function, not a binary command)
    if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] || [[ -d "$HOME/.sdkman" ]]; then
        # Source SDKMAN
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

        log_info "Updating SDKMAN..."
        sdk selfupdate

        log_info "Updating candidate information..."
        sdk update

        log_info "Upgrading installed candidates..."
        sdk upgrade

        log_info "Flushing SDKMAN caches..."
        sdk flush

        log_success "Java and related tools updated successfully"
    else
        log_warning "SDKMAN is not installed"
    fi
}

# ================================================================
# DATABASE FUNCTIONS
# ================================================================

update_databases() {
    log_section "🗄️ Managing database services"

    local services_restarted=0

    # PostgreSQL
    if brew services list | grep -q postgresql; then
        log_info "Restarting PostgreSQL..."
        brew services restart postgresql
        services_restarted=$((services_restarted + 1))
        log_success "PostgreSQL restarted"
    fi

    # MongoDB
    if brew services list | grep -q mongodb-community; then
        log_info "Restarting MongoDB..."
        brew services restart mongodb-community
        services_restarted=$((services_restarted + 1))
        log_success "MongoDB restarted"
    fi

    # MySQL/MariaDB
    if brew services list | grep -q mysql; then
        log_info "Restarting MySQL..."
        brew services restart mysql
        services_restarted=$((services_restarted + 1))
        log_success "MySQL restarted"
    fi

    # Redis
    if brew services list | grep -q redis; then
        log_info "Restarting Redis..."
        brew services restart redis
        services_restarted=$((services_restarted + 1))
        log_success "Redis restarted"
    fi

    if [ $services_restarted -eq 0 ]; then
        log_info "No database services found running"
    else
        log_success "$services_restarted database service(s) restarted"
    fi
}

# ================================================================
# SYSTEM CLEANUP FUNCTIONS
# ================================================================

clean_system() {
    log_section "🧹 Cleaning system"

    # Homebrew cleanup
    log_info "Cleaning Homebrew caches..."
    brew cleanup -s

    # Python cache cleanup
    if command_exists pip; then
        log_info "Cleaning pip cache..."
        pip cache purge 2>/dev/null || true
    fi

    # Node.js cache cleanup
    if command_exists npm; then
        log_info "Cleaning npm cache..."
        npm cache clean --force
    fi

    if command_exists pnpm; then
        log_info "Cleaning pnpm store..."
        pnpm store prune
    fi

    if command_exists yarn; then
        log_info "Cleaning yarn cache..."
        yarn cache clean
    fi

    # System cache cleanup
    log_info "Cleaning system caches..."
    rm -rf ~/Library/Caches/* 2>/dev/null || true
    rm -rf ~/Library/Logs/* 2>/dev/null || true

    # Empty trash
    log_info "Emptying trash..."
    rm -rf ~/.Trash/* 2>/dev/null || true

    # macOS specific cleanup
    log_info "Running system maintenance..."
    sudo purge

    # Clean up .DS_Store files
    log_info "Removing .DS_Store files..."
    find . -name ".DS_Store" -type f -delete 2>/dev/null || true

    log_success "System cleaned successfully"
}

# ================================================================
# SYSTEM CHECK FUNCTIONS
# ================================================================

check_system() {
    log_section "🔍 System diagnostics"

    # System information
    log_info "System Information:"
    echo "macOS: $(sw_vers -productName) $(sw_vers -productVersion)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime)"
    echo

    # Disk space
    log_info "Disk usage:"
    df -h /
    echo

    # Memory usage
    log_info "Memory usage:"
    vm_stat | head -10
    echo

    # Tool versions
    log_info "Development tools versions:"
    command_exists brew && echo "Homebrew: $(brew --version | head -1)"
    command_exists git && echo "Git: $(git --version)"
    command_exists node && echo "Node.js: $(node --version)"
    command_exists python3 && echo "Python: $(python3 --version)"
    command_exists java && echo "Java: $(java -version 2>&1 | head -1)"
    echo

    # Homebrew services
    log_info "Homebrew services status:"
    brew services list
    echo

    # Network ports in use
    log_info "Active network connections:"
    lsof -i -P | grep -i "listen" | head -10
    echo

    # Check for system updates
    log_info "Checking for system updates..."
    softwareupdate -l 2>/dev/null || log_info "No system updates available"
    echo

    log_success "System diagnostics completed"
}

# ================================================================
# BACKUP FUNCTIONS
# ================================================================

backup_configs() {
    log_section "💾 Creating configuration backup"

    local backup_dir="$HOME/workspace/backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"

    log_info "Creating backup in: $backup_dir"

    # Backup configuration files
    log_info "Backing up configuration files..."
    [ -f ~/.zshrc ] && cp ~/.zshrc "$backup_dir/"
    [ -f ~/.zshrc.local ] && cp ~/.zshrc.local "$backup_dir/"
    [ -f ~/.gitconfig ] && cp ~/.gitconfig "$backup_dir/"
    [ -f ~/.gitconfig-work ] && cp ~/.gitconfig-work "$backup_dir/"
    [ -f ~/.ssh/config ] && cp ~/.ssh/config "$backup_dir/"

    # Starship config
    [ -f ~/.config/starship.toml ] && cp ~/.config/starship.toml "$backup_dir/"

    # VS Code settings
    if [ -d "$HOME/Library/Application Support/Code/User" ]; then
        mkdir -p "$backup_dir/vscode"
        cp "$HOME/Library/Application Support/Code/User/settings.json" "$backup_dir/vscode/" 2>/dev/null || true
        cp "$HOME/Library/Application Support/Code/User/keybindings.json" "$backup_dir/vscode/" 2>/dev/null || true
    fi

    # Package lists
    log_info "Creating package lists..."
    command_exists brew && brew list > "$backup_dir/brew-packages.txt"
    command_exists brew && brew list --cask > "$backup_dir/brew-casks.txt"

    if command_exists npm; then
        npm list -g --depth=0 > "$backup_dir/npm-global-packages.txt" 2>/dev/null || true
    fi

    if command_exists pnpm; then
        pnpm list -g > "$backup_dir/pnpm-global-packages.txt" 2>/dev/null || true
    fi

    if command_exists pip; then
        pip list > "$backup_dir/pip-packages.txt" 2>/dev/null || true
    fi

    # VS Code extensions
    if command_exists code; then
        code --list-extensions > "$backup_dir/vscode-extensions.txt" 2>/dev/null || true
    fi

    # Create backup info file
    cat > "$backup_dir/backup-info.txt" << EOF
Backup created: $(date)
System: $(sw_vers -productName) $(sw_vers -productVersion)
Hostname: $(hostname)
User: $(whoami)
EOF

    log_success "Backup completed in: $backup_dir"
}

# ================================================================
# DELETE BACKUPS FUNCTION
# ================================================================
delete_backups() {
    log_section "🗑️ Deleting old backups"

    local backup_dir="$HOME/workspace/backups"
    local num_backups_to_keep=5

    log_info "Checking for backups in: $backup_dir"

    if [ -d "$backup_dir" ]; then
        log_info "Found existing backups"

        local num_backups=$(ls -1d "$backup_dir"/* 2>/dev/null | wc -l | tr -d ' ')
        log_info "Total number of backups: $num_backups"

        if [ $num_backups -gt $num_backups_to_keep ]; then
            log_info "Removing old backups..."
            ls -1d "$backup_dir"/* 2>/dev/null | sort | head -n -$num_backups_to_keep | xargs rm -rf
            log_success "Old backups removed"
        else
            log_info "No backups to delete"
        fi
    else
        log_info "No backups found in: $backup_dir"
    fi
}

# ================================================================
# UPDATE ALL FUNCTION
# ================================================================

update_all() {
    log_section "🚀 Running complete system update"

    log_info "Starting comprehensive system maintenance..."
    echo

    # Run all update functions
    update_homebrew
    echo

    update_python
    echo

    update_node
    echo

    update_java
    echo

    update_databases
    echo

    clean_system
    echo

    check_system
    echo

    backup_configs
    echo

    log_success "Complete system update finished!"
    log_info "Summary: All tools updated, system cleaned, diagnostics run, and backup created"
}

# ================================================================
# MENU SYSTEM
# ================================================================

show_menu() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║             macOS Maintenance Script 2025                    ║
║                   Enhanced Version                           ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"

    echo -e "${YELLOW}Select an option:${NC}"
    echo "  1. 🚀 Update everything (recommended)"
    echo "  2. 🍺 Update Homebrew and packages"
    echo "  3. 🐍 Update Python and packages"
    echo "  4. 📦 Update Node.js, npm, and pnpm"
    echo "  5. ☕ Update Java and tools (SDKMAN)"
    echo "  6. 🗄️  Manage database services"
    echo "  7. 🧹 Clean system caches"
    echo "  8. 🔍 System diagnostics"
    echo "  9. 💾 Backup configurations"
    echo " 10. 🗑️ Delete old backups"
    echo "  0. 🚪 Exit"
    echo
    echo -n "Enter your choice [0-9]: "
}

# ================================================================
# COMMAND LINE INTERFACE
# ================================================================

# Handle command line arguments
handle_cli_args() {
    # If no arguments, show help
    if [ $# -eq 0 ]; then
        show_help
        exit 1
    fi

    # Process each argument
    for arg in "$@"; do
        case "$arg" in
            "all"|"update")
                log_info "Running complete system update..."
                update_all
                ;;
            "check"|"status"|"diagnostics")
                check_system
                ;;
            "clean"|"cleanup")
                clean_system
                ;;
            "backup")
                backup_configs
                ;;
            "delete"|"remove")
                delete_backups
                ;;
            "homebrew"|"brew")
                update_homebrew
                ;;
            "python"|"py")
                update_python
                ;;
            "node"|"nodejs"|"npm")
                update_node
                ;;
            "java")
                update_java
                ;;
            "db"|"database"|"databases")
                update_databases
                ;;
            "help"|"-h"|"--help")
                show_help
                exit 0
                ;;
            *)
                log_error "Unknown command: $arg"
                log_info "Use --help to see available commands"
                ;;
        esac
        echo  # Add spacing between operations
    done
}

show_help() {
    echo -e "${CYAN}macOS Maintenance Script 2025 - Enhanced Version${NC}"
    echo
    echo "Usage: $0 [command]"
    echo
    echo "Commands:"
    echo "  all, update        - Update everything (recommended)"
    echo "  check, status      - Run system diagnostics"
    echo "  clean, cleanup     - Clean system caches"
    echo "  backup             - Backup configurations"
    echo "  homebrew, brew     - Update Homebrew and packages"
    echo "  python, py         - Update Python and packages"
    echo "  node, nodejs, npm  - Update Node.js and packages"
    echo "  java               - Update Java tools (SDKMAN)"
    echo "  db, databases      - Manage database services"
    echo "  delete, remove     - Delete old backups"
    echo "  help, -h, --help   - Show this help message"
    echo
    echo "If no command is provided, the interactive menu will be displayed."
    echo
    echo "Examples:"
    echo "  $0 all             # Update everything"
    echo "  $0 check           # Run diagnostics only"
    echo "  $0 clean           # Clean system only"
}

# ================================================================
# MAIN FUNCTION
# ================================================================

main() {
    # Check if running with command line arguments
    if [ $# -gt 0 ]; then
        handle_cli_args "$@"
        return
    fi

    # Interactive menu mode
    local option
    while true; do
        show_menu
        read option

        echo

        case $option in
            1) update_all ;;
            2) update_homebrew ;;
            3) update_python ;;
            4) update_node ;;
            5) update_java ;;
            6) update_databases ;;
            7) clean_system ;;
            8) check_system ;;
            9) backup_configs ;;
            10) delete_backups ;;
            0)
                log_info "Exiting maintenance script. Have a great day!"
                exit 0
                ;;
            *)
                log_error "Invalid option. Please select 0-9."
                ;;
        esac

        echo
        echo -e "${YELLOW}Press Enter to continue...${NC}"
        read
    done
}

# ================================================================
# SCRIPT INITIALIZATION
# ================================================================

# Ensure we're not running as root
if [[ $EUID -eq 0 ]]; then
   log_error "This script should not be run as root"
   exit 1
fi

# Welcome message for interactive mode
if [ $# -eq 0 ]; then
    log_info "Starting macOS Maintenance Script 2025..."
    log_info "This script will help you maintain your development environment"
    sleep 1
fi

# Start the main function
main "$@"