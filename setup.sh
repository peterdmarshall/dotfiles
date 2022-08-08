#!/bin/zsh

# Install neovim
brew install neovim

# Symlink neovim config
ln -s ~/Tools/dotfiles/nvim ~/.config/nvim

# Install Core Utils
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

# Install ripgrep
brew install ripgrep

# Install spaceship with default ZSH_CUSTOM location
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


