#!/bin/bash

# in oh-my-zsh, this is a regular variable that's not exported, so re-defining it
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

set -e
echo "Installing zsh pre-requisites"

if [ ! -d $HOME/.oh-my-zsh ]
then
    echo "Installing Oh My Zsh"
    curl -L http://install.ohmyz.sh | sh
    if [ -f ~/.zshrc.pre-oh-my-zsh ]; then
        # Put my ~/.zshrc file back
        echo "Restore back zshrc"
        rm ~/.zshrc
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
    fi
fi

if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-autosuggestions ]; then
    echo "Installing autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
    echo "Installing syntax highlighting plugins..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
    echo "Installing powerlevel10k theme..."
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

echo "Done"
