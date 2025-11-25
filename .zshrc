# =============================================================================
# ZSH Configuration - Modular Setup
# =============================================================================

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    git
    zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Environment Detection
# -----------------------------------------------------------------------------
if [[ $(uname -m) == "arm64" ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
    export ARCHFLAGS="-arch arm64"
else
    export HOMEBREW_PREFIX="/usr/local"
    export ARCHFLAGS="-arch x86_64"
fi

# -----------------------------------------------------------------------------
# PATH Configuration
# -----------------------------------------------------------------------------
typeset -U PATH  # Remove duplicates

# Core paths
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:$PATH"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Development tools
export PATH="${HOMEBREW_PREFIX}/opt/mysql@8.0/bin:$PATH"
export PATH="${HOME}/.local/bin:$PATH"

# -----------------------------------------------------------------------------
# Editor & Locale
# -----------------------------------------------------------------------------
export EDITOR="vim"
export LC_ALL="ko_KR.UTF-8"
export LANG="ko_KR.UTF-8"

# -----------------------------------------------------------------------------
# History Configuration
# -----------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# -----------------------------------------------------------------------------
# Tool Configurations
# -----------------------------------------------------------------------------

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# SDKMAN (must be at the end)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# RVM
export PATH="$PATH:$HOME/.rvm/bin"

# GPG
export GPG_TTY=$(tty)

# -----------------------------------------------------------------------------
# Zsh Plugins (Homebrew installed)
# -----------------------------------------------------------------------------
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ${HOMEBREW_PREFIX}/share/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null

# -----------------------------------------------------------------------------
# Aliases - Safety
# -----------------------------------------------------------------------------
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# -----------------------------------------------------------------------------
# Aliases - Navigation
# -----------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias ll='ls -alh'
alias la='ls -A'

# ls with colors
if ls --version > /dev/null 2>&1; then
    alias ls='ls --color=auto'
    alias l.='ls -d .* --color=auto'
else
    alias ls='ls -G'
    alias l.='ls -dG .*'
fi

# -----------------------------------------------------------------------------
# Aliases - Modern CLI Tools
# -----------------------------------------------------------------------------
command -v bat > /dev/null && alias cat='bat'
command -v eza > /dev/null && alias le='eza --long --tree --level=3 --all'
command -v exa > /dev/null && alias le='exa --long --tree --level=3 --all'

# -----------------------------------------------------------------------------
# Aliases - Development
# -----------------------------------------------------------------------------
alias k='kubectl'
alias tf='terraform'
alias g='git'
alias python='python3'
alias pip='pip3'

# Grep with colors
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# -----------------------------------------------------------------------------
# Aliases - Utilities
# -----------------------------------------------------------------------------
alias weather='curl v2.wttr.in/Seoul'
alias ncd='ncdu --color dark -rr -x'
alias ctags='${HOMEBREW_PREFIX}/bin/ctags'

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

# Yazi file manager with cd on exit
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# -----------------------------------------------------------------------------
# Local Configuration (secrets, machine-specific settings)
# -----------------------------------------------------------------------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
