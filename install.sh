#!/usr/bin/env sh

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


if [[ $MY_ENV == "linux" ]]
then
    # Global Installs
    sudo dnf install tmux
    sudo dnf install kitty
    sudo dnf install hyprland
    sudo dnf install wofi
    sudo dnf install dolphin
    sudo dnf install waybar
    sudo dnf install neovim
    sudo dnf install gcc-c++
    sudo dnf install fzf
    make -C /home/sman/.local/share/nvim/lazy/telescope-fzf-native.nvim/

    # Hyprland
    rm -rf $HOME/.config/hypr
    ln -s $DOTFILES/hypr $HOME/.config/hypr

    # Waybar
    rm -rf $HOME/.config/waybar
    ln -s $DOTFILES/waybar $HOME/.config/waybar
fi

# Make a bin dir if it doesn't exist
mkdir -p $HOME/.local/bin

# Kitty
rm -rf $HOME/.config/kitty
ln -s $DOTFILES/kitty $HOME/.config/kitty

# Zsh
rm -rf $HOME/.zshrc
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
rm -rf $HOME/.tmux.conf

# t script
rm -rf $HOME/.local/bin/t
ln -sf $DOTFILES/scripts/t $HOME/.local/bin/t
ln -sf $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf


# Notes
#
