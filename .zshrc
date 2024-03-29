# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# ZSH_THEME="bullet-train/bullet-train"
ZSH_THEME="dracula"
# ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git 
	 zsh-syntax-highlighting
	 zsh-completions
	 zsh-autosuggestions
	 zsh-fzf-history-search
	 )

# User configuration
export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/go/bin:/usr/local/mysql/bin:/usr/local/mysql/bin:/usr/local/opt/python/libexec/bin:/opt/homebrew/bin:$PATH"

export EDITOR="/usr/bin/vim"

source $ZSH/oh-my-zsh.sh

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Locale
export LC_ALL=ko_KR.UTF-8
export LANG=ko_KR.UTF-8

# Bullet train
BULLETTRAIN_PROMPT_ORDER=(
	time
    status
    custom
    context
    dir
    virtualenv
    go
    git
    cmd_exec_time
)

# go
BULLETTRAIN_GO_SHOW="true"

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if ls --version > /dev/null 2>&1; then
    alias ls='ls --color=auto'; #gnu
    alias l.='ls -d .* --color=auto'
else
    alias ls='ls -G'; #osx
    alias l.='ls -dG .*'
fi

## pyenv설정
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2&1; then
    eval "$(pyenv init -)"
fi

alias ll='ls -alh'
alias cat='bat'
alias le='exa --long --tree --level=3 --all'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias cd..='cd ..'
alias eclimd='~/Applications/Eclipse_neon.app/Contents/Eclipse/eclimd'
alias ctags='`brew --prefix`/bin/ctags'
#alias vimr='open -a VimR.app "$@"'
alias ag='ag --path-to-ignore ~/.agignore'
alias agl='ag --pager="less -XFR"'
alias ncd='ncdu --color dark -rr -x'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias bc='bc -l ~/.bcrc -q'
alias weather='curl v2.wttr.in/Seoul'
alias python='python3'
