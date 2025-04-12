#!/usr/bin/env sh

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make a bin dir if it doesn't exist
mkdir -p $HOME/.local/bin

# Kitty
rm -rf $HOME/.config/kitty
ln -s $DOTFILES/kitty $HOME/.config/kitty

# Zsh
ln -sf $DOTFILES/zsh/zshrc $HOME/.zshrc

# Aerospace (Mac)
rm -rf $HOME/.config/aerospace
ln -s $DOTFILES/aerospace $HOME/.config/aerospace

# Neovim
rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim $HOME/.config/nvim

# Git
ln -sf $DOTFILES/git/gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/git/gitignore_global $HOME/.gitignore_global

# Phpactor
rm -rf $HOME/.config/phpactor
ln -s $DOTFILES/phpactor $HOME/.config/phpactor

# Scripts
mkdir -p $HOME/.local/bin

# NVM (Node Version Manager)
mkdir -p $HOME/.nvm
ln -sf $DOTFILES/nvm/default-packages $HOME/.nvm/default-packages

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Tmux
rm -rf $HOME/.config/tmux
ln -sf $DOTFILES/tmux $HOME/.config/tmux

# t script
rm -rf $HOME/.local/bin/t
ln -sf $DOTFILES/scripts/t $HOME/.local/bin/t


# Notes
