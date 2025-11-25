# =============================================================================
# Dotfiles Makefile
# =============================================================================

DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
SHELL := /bin/bash

# Dotfiles to link
DOTFILES := .zshrc .zshenv .vimrc .gitconfig .gitignore .curlrc .inputrc

.PHONY: all help install deploy update sync brew backup clean test vim

all: help

help:
	@echo "Dotfiles Management"
	@echo ""
	@echo "Usage:"
	@echo "  make install     Install everything (fresh machine)"
	@echo "  make deploy      Create symlinks to home directory"
	@echo "  make update      Pull latest changes and redeploy"
	@echo "  make sync        Sync current config to dotfiles"
	@echo "  make brew        Install/update Homebrew packages"
	@echo "  make vim         Setup Vim with plugins"
	@echo "  make backup      Backup current dotfiles"
	@echo "  make clean       Remove symlinks"
	@echo "  make test        Verify installation"
	@echo ""

# Full installation for fresh machine
install:
	@echo "==> Running full installation..."
	@bash $(DOTPATH)/install.sh

# Create symlinks only
deploy:
	@echo "==> Creating symlinks..."
	@$(foreach file, $(DOTFILES), \
		if [ -f "$(DOTPATH)/$(file)" ]; then \
			ln -sfnv $(DOTPATH)/$(file) $(HOME)/$(file); \
		fi;)
	@if [ -d "$(DOTPATH)/bin" ]; then \
		ln -sfnv $(DOTPATH)/bin $(HOME)/bin; \
	fi
	@echo "==> Done!"

# Update from git and redeploy
update:
	@echo "==> Updating dotfiles..."
	@cd $(DOTPATH) && git pull origin master
	@$(MAKE) deploy
	@echo "==> Updated!"

# Sync current machine config to dotfiles
sync:
	@echo "==> Syncing Brewfile..."
	@brew bundle dump --file=$(DOTPATH)/Brewfile --force
	@echo "==> Brewfile updated"
	@echo ""
	@echo "Note: Review changes before committing:"
	@echo "  cd $(DOTPATH) && git diff"

# Install Homebrew packages
brew:
	@echo "==> Installing Homebrew packages..."
	@brew bundle --file=$(DOTPATH)/Brewfile
	@echo "==> Done!"

# Setup Vim with plugins
vim:
	@echo "==> Setting up Vim..."
	@mkdir -p $(HOME)/.vim/{autoload,plugged,colors,undo,backup,swap}
	@if [ ! -f "$(HOME)/.vim/autoload/plug.vim" ]; then \
		echo "Installing vim-plug..."; \
		curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi
	@echo "Installing Vim plugins..."
	@vim +PlugInstall +qall
	@echo "==> Vim setup complete!"

# Backup current dotfiles
backup:
	@echo "==> Creating backup..."
	@mkdir -p $(HOME)/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)
	@$(foreach file, $(DOTFILES), \
		if [ -f "$(HOME)/$(file)" ] && [ ! -L "$(HOME)/$(file)" ]; then \
			cp $(HOME)/$(file) $(HOME)/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)/; \
		fi;)
	@echo "==> Backup complete!"

# Remove symlinks
clean:
	@echo "==> Removing symlinks..."
	@$(foreach file, $(DOTFILES), \
		if [ -L "$(HOME)/$(file)" ]; then \
			rm -v $(HOME)/$(file); \
		fi;)
	@if [ -L "$(HOME)/bin" ]; then \
		rm -v $(HOME)/bin; \
	fi
	@echo "==> Cleaned!"

# Verify installation
test:
	@echo "==> Testing installation..."
	@echo ""
	@echo "Symlinks:"
	@$(foreach file, $(DOTFILES), \
		if [ -L "$(HOME)/$(file)" ]; then \
			echo "  ✓ $(file)"; \
		else \
			echo "  ✗ $(file) (not linked)"; \
		fi;)
	@echo ""
	@echo "Tools:"
	@command -v brew >/dev/null && echo "  ✓ Homebrew" || echo "  ✗ Homebrew"
	@command -v zsh >/dev/null && echo "  ✓ ZSH" || echo "  ✗ ZSH"
	@command -v git >/dev/null && echo "  ✓ Git" || echo "  ✗ Git"
	@command -v fzf >/dev/null && echo "  ✓ FZF" || echo "  ✗ FZF"
	@command -v bat >/dev/null && echo "  ✓ bat" || echo "  ✗ bat"
	@command -v rg >/dev/null && echo "  ✓ ripgrep" || echo "  ✗ ripgrep"
	@[ -d "$(HOME)/.sdkman" ] && echo "  ✓ SDKMAN" || echo "  ✗ SDKMAN"
	@[ -d "$(HOME)/.oh-my-zsh" ] && echo "  ✓ Oh My Zsh" || echo "  ✗ Oh My Zsh"
	@echo ""
	@echo "Local config:"
	@[ -f "$(HOME)/.zshrc.local" ] && echo "  ✓ ~/.zshrc.local exists" || echo "  ⚠ ~/.zshrc.local not found"
	@echo ""
