# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  docker
  kubectl
  brew
  npm
  python
  pip
  iterm2
  macos
  emoji
  zsh-nvm
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Bindkeys personalizados
bindkey "^[f" forward-word      # Alt+derecha en macOS/iTerm2
bindkey "^[b" backward-word     # Alt+izquierda en macOS/iTerm2
bindkey "^A" beginning-of-line      # Ctrl+A - inicio de línea
bindkey "^E" end-of-line            # Ctrl+E - fin de línea
bindkey "^[[H" beginning-of-line    # Home - inicio de línea
bindkey "^[[F" end-of-line          # End - fin de línea
bindkey "^K" kill-line              # Ctrl+K - eliminar desde cursor hasta el final
bindkey "^U" backward-kill-line     # Ctrl+U - eliminar desde cursor hasta el inicio

# Mejoras visuales con eza (reemplazo moderno de exa)
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias lt='eza -T --icons --git-ignore'
alias ltl='eza -T -L 2 --icons --git-ignore'
alias lta='eza -Ta --icons'

# Alternativas con lsd
alias lsd='lsd --icon=always'
alias lsl='lsd -l --icon=always'
alias lsa='lsd -la --icon=always'

# Alternativas mejoradas
alias cat='bat --style=auto'
alias preview='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

# Búsqueda mejorada
alias grep='rg'

# Git log mejorado (con formato visual)
alias glog='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Utilidades
alias ip='ipconfig getifaddr en0'
alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# Para zoxide (navegación inteligente)
alias cd='z'
alias zl='z -l'      # Listar ubicaciones frecuentes
alias zi='z -i'      # Modo interactivo

# Para fzf (búsqueda difusa)
alias f='fzf'
alias fh='history | fzf'
alias fkill='ps aux | fzf | awk "{print \$2}" | xargs kill -9'

# Para mcfly (búsqueda en historial)
alias mh='mcfly search'

# Para delta (mejor visualización de diff)
alias gd='git diff | delta'
alias gdst='git diff --staged | delta'

# Para jq (procesamiento JSON)
alias jqp='jq -C . | less -R'   # Salida con color
alias jqs='jq -r "."'           # Salida sin comillas

# Para yq (procesamiento YAML)
alias yqp='yq -C . | less -R'   # Salida con color

# Combinaciones útiles
alias dush='du -sh * | sort -hr | head -10'   # Top 10 directorios por tamaño
alias ports='lsof -iTCP -sTCP:LISTEN -P'      # Ver puertos abiertos
alias path='echo $PATH | tr ":" "\n"'         # Ver PATH en formato legible
alias cleanup='fd -H ".*DS_Store" -tf -X rm'  # Eliminar archivos .DS_Store usando fd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
export PATH="$HOME/.local/bin:$PATH"
