#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Función para imprimir mensajes con formato
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}=== ${message} ===${NC}"
}

# Función para imprimir errores
print_error() {
    echo -e "${RED}ERROR: $1${NC}"
}

# Función para imprimir éxito
print_success() {
    echo -e "${GREEN}SUCCESS: $1${NC}"
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para actualizar Homebrew y sus paquetes
update_homebrew() {
    print_message "$BLUE" "Actualizando Homebrew y paquetes"

    if command_exists brew; then
        # Actualizar Homebrew
        brew update

        # Actualizar paquetes
        brew upgrade

        # Actualizar Apps de Cask
        brew upgrade --cask

        # Limpieza
        brew cleanup -s

        # Doctor check
        brew doctor

        print_success "Homebrew actualizado correctamente"
    else
        print_error "Homebrew no está instalado"
    fi
}

# Función para actualizar Python y paquetes
update_python() {
    print_message "$BLUE" "Actualizando Python y paquetes"

    if command_exists pyenv; then
        # Actualizar pyenv
        pyenv update

        # Listar versiones instaladas
        echo "Versiones de Python instaladas:"
        pyenv versions

        # Actualizar pip
        pip install --upgrade pip

        # Actualizar paquetes globales
        pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U

        print_success "Python y paquetes actualizados correctamente"
    else
        print_error "pyenv no está instalado"
    fi

    # Actualizar Poetry si está instalado
    if command_exists poetry; then
        poetry self update
        print_success "Poetry actualizado correctamente"
    fi
}

# Función para actualizar Node.js y paquetes
update_node() {
    print_message "$BLUE" "Actualizando Node.js y paquetes"

    if command_exists nvm; then
        # Actualizar nvm
        (
            cd "$NVM_DIR"
            git fetch --tags origin
            git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
        ) && \. "$NVM_DIR/nvm.sh"

        # Instalar última versión LTS
        nvm install node
        nvm use node

        # Actualizar npm
        npm install -g npm@latest

        # Actualizar paquetes globales npm
        npm update -g

        print_success "Node.js y npm actualizados correctamente"
    else
        print_error "nvm no está instalado"
    fi

    # Actualizar pnpm si está instalado
    if command_exists pnpm; then
        # Actualizar pnpm
        pnpm self-update

        # Actualizar paquetes globales pnpm
        pnpm update -g

        print_success "pnpm y paquetes actualizados correctamente"
    else
        print_error "pnpm no está instalado"
    fi
}

# Función para actualizar Java y herramientas relacionadas
update_java() {
    print_message "$BLUE" "Actualizando Java y herramientas relacionadas"

    if command_exists sdk; then
        # Actualizar SDKMAN
        sdk selfupdate

        # Actualizar todos los candidatos instalados
        sdk update

        # Actualizar
        sdk upgrade

        print_success "Java y herramientas actualizadas correctamente"
    else
        print_error "SDKMAN no está instalado"
    fi
}

# Función para actualizar bases de datos
update_databases() {
    print_message "$BLUE" "Actualizando servicios de bases de datos"

    # PostgreSQL
    if brew services list | grep -q postgresql; then
        brew services restart postgresql
        print_success "PostgreSQL reiniciado"
    fi

    # MongoDB
    if brew services list | grep -q mongodb-community; then
        brew services restart mongodb-community
        print_success "MongoDB reiniciado"
    fi

    # MySQL
    if brew services list | grep -q mysql; then
        brew services restart mysql
        print_success "MySQL reiniciado"
    fi

    # Redis
    if brew services list | grep -q redis; then
        brew services restart redis
        print_success "Redis reiniciado"
    fi
}

# Función para limpiar el sistema
clean_system() {
    print_message "$BLUE" "Limpiando el sistema"

    # Limpiar caché de Homebrew
    brew cleanup -s

    # Limpiar caché de pip
    pip cache purge

    # Limpiar caché de npm
    npm cache clean --force

    # Limpiar caché de pnpm
    if command_exists pnpm; then
        pnpm store prune
    fi

    # Limpiar caché de yarn si está instalado
    if command_exists yarn; then
        yarn cache clean
    fi

    # Limpiar archivos temporales
    rm -rf ~/Library/Caches/*
    rm -rf ~/Library/Logs/*

    # Vaciar papelera
    rm -rf ~/.Trash/*

    print_success "Sistema limpiado correctamente"
}

# Función para verificar el estado del sistema
check_system() {
    print_message "$BLUE" "Verificando estado del sistema"

    # Verificar espacio en disco
    df -h /

    # Verificar memoria
    vm_stat

    # Verificar servicios de Homebrew
    brew services list

    # Verificar puertos en uso
    echo "Puertos en uso:"
    lsof -i -P | grep -i "listen"

    # Restar finder
    killall Finder
}

# Función para hacer backup de configuraciones
backup_configs() {
    print_message "$BLUE" "Realizando backup de configuraciones"

    BACKUP_DIR="$HOME/workspace/backups/$(date +%Y%m%d)"
    mkdir -p "$BACKUP_DIR"

    # Backup de configuraciones
    cp ~/.zshrc "$BACKUP_DIR/"
    cp ~/.gitconfig "$BACKUP_DIR/"

    # Lista de paquetes de Homebrew
    brew list > "$BACKUP_DIR/brew-packages.txt"
    brew list --cask > "$BACKUP_DIR/brew-casks.txt"

    # Lista de paquetes globales de npm
    if command_exists npm; then
        npm list -g --depth=0 > "$BACKUP_DIR/npm-global-packages.txt"
    fi

    # Lista de paquetes globales de pnpm
    if command_exists pnpm; then
        pnpm list -g > "$BACKUP_DIR/pnpm-global-packages.txt"
    fi

    # Lista de paquetes globales de pip
    if command_exists pip; then
        pip list > "$BACKUP_DIR/pip-packages.txt"
    fi

    print_success "Backup realizado en $BACKUP_DIR"
}

# Menú principal
show_menu() {
    clear
    echo -e "${YELLOW}=== Script de Mantenimiento del Sistema ===${NC}"
    echo "1. Actualizar todo"
    echo "2. Actualizar Homebrew y paquetes"
    echo "3. Actualizar Python y paquetes"
    echo "4. Actualizar Node.js, npm y pnpm"
    echo "5. Actualizar Java y herramientas"
    echo "6. Actualizar bases de datos"
    echo "7. Limpiar sistema"
    echo "8. Verificar estado del sistema"
    echo "9. Realizar backup de configuraciones"
    echo "0. Salir"
    echo
    echo -n "Selecciona una opción: "
}

# Función principal
main() {
    local option

    while true; do
        show_menu
        read option

        case $option in
            1)
                update_homebrew
                update_python
                update_node
                update_java
                update_databases
                clean_system
                check_system
                backup_configs
                ;;
            2) update_homebrew ;;
            3) update_python ;;
            4) update_node ;;
            5) update_java ;;
            6) update_databases ;;
            7) clean_system ;;
            8) check_system ;;
            9) backup_configs ;;
            0) exit 0 ;;
            *) print_error "Opción inválida" ;;
        esac

        echo
        echo -n "Presiona Enter para continuar..."
        read
    done
}

# Iniciar el script
main