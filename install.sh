#!/usr/bin/env sh

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make a bin dir if it doesn't exist
mkdir -p $HOME/.local/bin

# Kitty
ln -s $DOTFILES/kitty $HOME/.config/kitty

# Zsh
ln -sf $DOTFILES/zsh/zshrc $HOME/.zshrc

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

# Tmux Plugins
mkdir ~/.tmux # put the tpm in it's own folder, because it will conflict with my tmux dotfiles otherwise
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Tmux Catppuccin
mkdir -p ~/.tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.tmux/plugins/catppuccin/tmux

# t script
rm -rf $HOME/.local/bin/t
ln -sf $DOTFILES/scripts/t $HOME/.local/bin/t


# Notes
