#!/bin/bash
# =============================================================================
# macOS Dotfiles Installation Script
# =============================================================================
# Usage: curl -fsSL https://raw.githubusercontent.com/joswlv/dotfiles/master/install.sh | bash
# Or: ./install.sh
# =============================================================================

set -e

DOTFILES_DIR="${HOME}/dotfiles"
DOTFILES_REPO="https://github.com/joswlv/dotfiles.git"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# -----------------------------------------------------------------------------
# Pre-flight checks
# -----------------------------------------------------------------------------
check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        error "This script is intended for macOS only"
    fi
    info "macOS detected: $(sw_vers -productVersion)"
}

check_xcode_cli() {
    if ! xcode-select -p &>/dev/null; then
        info "Installing Xcode Command Line Tools..."
        xcode-select --install
        read -p "Press [Enter] after Xcode CLI tools installation completes..."
    fi
    success "Xcode CLI tools installed"
}

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add to PATH for current session
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
    success "Homebrew installed"
}

install_brew_packages() {
    info "Installing Homebrew packages from Brewfile..."
    if [[ -f "${DOTFILES_DIR}/Brewfile" ]]; then
        brew bundle --file="${DOTFILES_DIR}/Brewfile" || warning "Some packages failed to install"
    else
        warning "Brewfile not found, skipping brew bundle"
    fi
    success "Homebrew packages installed"
}

# -----------------------------------------------------------------------------
# Dotfiles
# -----------------------------------------------------------------------------
clone_dotfiles() {
    if [[ -d "${DOTFILES_DIR}" ]]; then
        info "Dotfiles directory exists, pulling latest..."
        cd "${DOTFILES_DIR}" && git pull origin master
    else
        info "Cloning dotfiles..."
        git clone "${DOTFILES_REPO}" "${DOTFILES_DIR}"
    fi
    success "Dotfiles cloned/updated"
}

backup_existing() {
    local backup_dir="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    local files_to_backup=(".zshrc" ".vimrc" ".gitconfig" ".gitignore")

    for file in "${files_to_backup[@]}"; do
        if [[ -f "${HOME}/${file}" ]] && [[ ! -L "${HOME}/${file}" ]]; then
            mkdir -p "${backup_dir}"
            mv "${HOME}/${file}" "${backup_dir}/"
            info "Backed up ${file} to ${backup_dir}"
        fi
    done
}

create_symlinks() {
    info "Creating symlinks..."

    local dotfiles=(
        ".zshrc"
        ".zshenv"
        ".vimrc"
        ".gitconfig"
        ".gitignore"
        ".curlrc"
        ".inputrc"
    )

    for file in "${dotfiles[@]}"; do
        if [[ -f "${DOTFILES_DIR}/${file}" ]]; then
            ln -sfn "${DOTFILES_DIR}/${file}" "${HOME}/${file}"
            success "Linked ${file}"
        fi
    done

    # Create bin symlink
    if [[ -d "${DOTFILES_DIR}/bin" ]]; then
        ln -sfn "${DOTFILES_DIR}/bin" "${HOME}/bin"
        success "Linked bin directory"
    fi
}

# -----------------------------------------------------------------------------
# Oh My Zsh
# -----------------------------------------------------------------------------
install_oh_my_zsh() {
    if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
        info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    success "Oh My Zsh installed"

    # Install custom plugins
    local custom_plugins_dir="${HOME}/.oh-my-zsh/custom/plugins"

    if [[ ! -d "${custom_plugins_dir}/zsh-fzf-history-search" ]]; then
        info "Installing zsh-fzf-history-search plugin..."
        git clone https://github.com/joshskidmore/zsh-fzf-history-search.git "${custom_plugins_dir}/zsh-fzf-history-search"
    fi
    success "ZSH plugins installed"
}

# -----------------------------------------------------------------------------
# Vim
# -----------------------------------------------------------------------------
setup_vim() {
    info "Setting up Vim..."

    # Clean up old Vundle if exists
    if [[ -d "${HOME}/.vim/bundle" ]]; then
        info "Removing old Vundle plugins..."
        rm -rf "${HOME}/.vim/bundle"
    fi

    # Create vim directories
    mkdir -p "${HOME}/.vim/autoload"
    mkdir -p "${HOME}/.vim/plugged"
    mkdir -p "${HOME}/.vim/colors"
    mkdir -p "${HOME}/.vim/undo"
    mkdir -p "${HOME}/.vim/backup"
    mkdir -p "${HOME}/.vim/swap"

    # Install vim-plug (plugin manager)
    if [[ ! -f "${HOME}/.vim/autoload/plug.vim" ]]; then
        info "Installing vim-plug..."
        curl -fLo "${HOME}/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Install vim plugins headlessly
    info "Installing Vim plugins (this may take a moment)..."
    vim -es -u "${HOME}/.vimrc" -i NONE -c "PlugInstall" -c "qa" 2>/dev/null || \
    vim +PlugInstall +qall 2>/dev/null || \
    warning "Vim plugin installation needs manual run: vim +PlugInstall +qall"

    success "Vim configured"
}

# -----------------------------------------------------------------------------
# Development Tools
# -----------------------------------------------------------------------------
install_sdkman() {
    if [[ ! -d "${HOME}/.sdkman" ]]; then
        info "Installing SDKMAN..."
        curl -s "https://get.sdkman.io" | bash
        source "${HOME}/.sdkman/bin/sdkman-init.sh"
    fi
    success "SDKMAN installed"
}

setup_fzf() {
    if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
        info "Setting up FZF..."
        "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    fi
    success "FZF configured"
}

# -----------------------------------------------------------------------------
# Local Configuration
# -----------------------------------------------------------------------------
setup_local_config() {
    if [[ ! -f "${HOME}/.zshrc.local" ]]; then
        info "Creating local config template..."
        cp "${DOTFILES_DIR}/.zshrc.local.example" "${HOME}/.zshrc.local"
        warning "Please edit ~/.zshrc.local to add your secrets and machine-specific settings"
    fi
}

# -----------------------------------------------------------------------------
# macOS Defaults
# -----------------------------------------------------------------------------
configure_macos_defaults() {
    info "Configuring macOS defaults..."

    # Finder
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Dock
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock show-recents -bool false

    # Screenshots
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"
    defaults write com.apple.screencapture type -string "png"

    # Keyboard
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Trackpad
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

    # Restart affected applications
    for app in "Finder" "Dock"; do
        killall "${app}" &>/dev/null || true
    done

    success "macOS defaults configured"
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    echo ""
    echo "=============================================="
    echo "  macOS Dotfiles Installation"
    echo "=============================================="
    echo ""

    check_macos
    check_xcode_cli
    install_homebrew
    clone_dotfiles
    backup_existing
    install_brew_packages
    install_oh_my_zsh
    create_symlinks
    setup_vim
    install_sdkman
    setup_fzf
    setup_local_config

    read -p "Configure macOS defaults? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        configure_macos_defaults
    fi

    echo ""
    echo "=============================================="
    success "Installation complete!"
    echo "=============================================="
    echo ""
    warning "Next steps:"
    echo "  1. Edit ~/.zshrc.local to add your secrets"
    echo "  2. Install SDKMAN SDKs: sdk install java 17.0.9-tem"
    echo "  3. Restart your terminal or run: source ~/.zshrc"
    echo "  4. (If Vim plugins failed) Run: vim +PlugInstall +qall"
    echo ""
}

main "$@"
