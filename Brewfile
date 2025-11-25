# =============================================================================
# Brewfile - Homebrew Bundle for macOS
# =============================================================================
# Install: brew bundle --file=~/dotfiles/Brewfile
# Dump current: brew bundle dump --file=~/dotfiles/Brewfile --force
# =============================================================================

# -----------------------------------------------------------------------------
# Taps
# -----------------------------------------------------------------------------
tap "homebrew/bundle"
tap "homebrew/services"
tap "hashicorp/tap"
tap "jesseduffield/lazygit"
tap "derailed/k9s"
tap "nikitabobko/tap"
tap "aoki/redis-cli"
tap "common-fate/granted"

# -----------------------------------------------------------------------------
# Core CLI Tools
# -----------------------------------------------------------------------------
brew "coreutils"                    # GNU core utilities
brew "curl"                         # HTTP client
brew "wget"                         # File retriever
brew "git"                          # Version control
brew "vim"                          # Text editor
brew "tree"                         # Directory listing
brew "htop"                         # Process viewer
brew "lsof"                         # List open files
brew "jq"                           # JSON processor
brew "ripgrep"                      # Fast grep
brew "fd"                           # Fast find
brew "fzf"                          # Fuzzy finder
brew "bat"                          # Cat with syntax highlighting
brew "yazi"                         # Terminal file manager
brew "zoxide"                       # Smarter cd
brew "tig"                          # Git TUI
brew "lazygit"                      # Git TUI (alternative)
brew "gh"                           # GitHub CLI
brew "procs"                        # Modern ps
brew "pstree"                       # Process tree

# -----------------------------------------------------------------------------
# Shell & ZSH
# -----------------------------------------------------------------------------
brew "zsh-autosuggestions"
brew "zsh-completions"
brew "zsh-history-substring-search"
brew "zsh-syntax-highlighting"
brew "shellcheck"                   # Shell script linter
brew "checkbashisms"

# -----------------------------------------------------------------------------
# Development - Languages & Runtimes
# -----------------------------------------------------------------------------
# Python
brew "pyenv"
brew "python@3.11"
brew "python@3.10"
brew "poetry"
brew "uv"                           # Fast Python package manager
brew "virtualenv"
brew "black"                        # Python formatter
brew "mypy"                         # Python type checker
brew "ipython"
brew "python-lsp-server"

# Node.js
brew "node"
brew "pnpm"
brew "yarn", link: false

# JVM
brew "openjdk@17"
brew "maven"
brew "gradle"
brew "sbt"
brew "scala@2.12"

# Go (installed via SDKMAN or direct)
# Ruby
brew "ruby"

# Others
brew "cmake"
brew "ninja"
brew "autoconf"
brew "automake"
brew "libtool"
brew "gcc"
brew "php"

# -----------------------------------------------------------------------------
# Data Engineering & Big Data
# -----------------------------------------------------------------------------
brew "apache-flink"
brew "kafka"
brew "hadoop", link: false
brew "trino"
brew "avro-tools"
brew "go-parquet-tools"
brew "mysql@8.0"
brew "aoki/redis-cli/redis-cli"

# -----------------------------------------------------------------------------
# DevOps & Infrastructure
# -----------------------------------------------------------------------------
brew "hashicorp/tap/terraform"
brew "kubernetes-cli"
brew "helm"
brew "k9s"
brew "minikube"
brew "docker", link: false
brew "common-fate/granted/granted"  # AWS role switching

# -----------------------------------------------------------------------------
# Security & Encryption
# -----------------------------------------------------------------------------
brew "gnupg"
brew "openssl@3"

# -----------------------------------------------------------------------------
# Media & Graphics
# -----------------------------------------------------------------------------
brew "ffmpeg"
brew "imagemagick"
brew "graphviz"
brew "gifsicle"

# -----------------------------------------------------------------------------
# Text & Document Processing
# -----------------------------------------------------------------------------
brew "poppler"                      # PDF tools
brew "tesseract"                    # OCR
brew "hugo"                         # Static site generator
brew "figlet"                       # ASCII art
brew "cowsay"
brew "nkf"                          # Japanese encoding
brew "recode"                       # Character set conversion

# -----------------------------------------------------------------------------
# Networking & HTTP
# -----------------------------------------------------------------------------
brew "httpie"                       # Modern HTTP client
brew "telnet"

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------
brew "mas"                          # Mac App Store CLI
brew "terminal-notifier"
brew "reattach-to-user-namespace"   # tmux clipboard
brew "sevenzip"
brew "diff-so-fancy"                # Better git diff
brew "direnv"                       # Directory-based env
brew "atuin"                        # Shell history

# -----------------------------------------------------------------------------
# Libraries (dependencies)
# -----------------------------------------------------------------------------
brew "glib"
brew "cairo"
brew "harfbuzz"
brew "pango"
brew "gdk-pixbuf"
brew "librsvg"
brew "libyaml"
brew "libzip"
brew "libgit2"
brew "openssl@3"
brew "xz"
brew "zstd"
brew "bzip2"

# -----------------------------------------------------------------------------
# Cask Applications
# -----------------------------------------------------------------------------
cask "visual-studio-code", args: { appdir: "/Applications" }
cask "warp"                         # Modern terminal
cask "aerospace"                    # Tiling window manager
cask "rectangle"                    # Window management
cask "karabiner-elements", args: { appdir: "/Applications" }
cask "keka", args: { appdir: "/Applications" }
cask "gas-mask", args: { appdir: "/Applications" }
cask "gpg-suite"
cask "hiddenbar"
cask "jordanbaird-ice"              # Menu bar management
cask "shottr"                       # Screenshot tool
cask "keycastr"                     # Keystroke visualizer
cask "macdown", args: { appdir: "/Applications" }
cask "visualvm"
cask "android-file-transfer", args: { appdir: "/Applications" }
cask "font-symbols-only-nerd-font"

# -----------------------------------------------------------------------------
# Mac App Store
# -----------------------------------------------------------------------------
mas "Keynote", id: 409183694
mas "Xcode", id: 497799835
mas "MenubarX", id: 1575588022

# -----------------------------------------------------------------------------
# VS Code Extensions
# -----------------------------------------------------------------------------
# Core
vscode "anthropic.claude-code"
vscode "github.copilot"
vscode "github.copilot-chat"
vscode "ms-ceintl.vscode-language-pack-ko"
vscode "dracula-theme.theme-dracula"
vscode "vscode-icons-team.vscode-icons"

# Git
vscode "eamodio.gitlens"
vscode "mhutchie.git-graph"
vscode "waderyan.gitblame"

# Python
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.debugpy"
vscode "ms-python.isort"
vscode "ms-python.vscode-python-envs"

# Jupyter
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"

# Go
vscode "golang.go"
vscode "premparihar.gotestexplorer"
vscode "quillaja.goasm"
vscode "windmilleng.vscode-go-autotest"

# Kotlin/Scala
vscode "fwcd.kotlin"
vscode "mathiasfrohlich.kotlin"
vscode "scala-lang.scala"

# SQL & Data
vscode "adpyke.vscode-sql-formatter"
vscode "renesaarsoo.sql-formatter-vsc"
vscode "mtxr.sqltools"
vscode "jakebathman.mysql-syntax"
vscode "camilesing.flink-sql"
vscode "snowflake.snowflake-vsc"
vscode "houssemslimani.snowflake-syntax-highlight"
vscode "linjun.clickhouse-support"
vscode "ultram4rine.sqltools-clickhouse-driver"
vscode "dvirtz.parquet-viewer"
vscode "grapecity.gc-excelviewer"
vscode "aykutsarac.jsoncrack-vscode"

# DBT
vscode "bastienboutonnet.vscode-dbt"
vscode "henriblancke.vscode-dbt-formatter"
vscode "innoverio.vscode-dbt-power-user"

# Docker & Containers
vscode "docker.docker"
vscode "ms-azuretools.vscode-docker"
vscode "ms-azuretools.vscode-containers"
vscode "ms-vscode-remote.remote-containers"

# Web & Templates
vscode "samuelcolvin.jinjahtml"
vscode "cjamesmay.plush"

# Productivity
vscode "johnpapa.vscode-peacock"
vscode "marp-team.marp-vscode"
vscode "figma.figma-vscode-extension"
vscode "no-more-life.no-more-jira-extension"

# Database Clients
vscode "cweijan.dbclient-jdbc"
vscode "cweijan.vscode-database-client2"

# AI/LLM
vscode "openai.chatgpt"
vscode "altimateai.vscode-altimate-mcp-server"
