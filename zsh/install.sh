#!/bin/bash

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
    if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
        echo "Installing autosuggestions plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
        echo "Installing syntax highlighting plugins..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi
fi

echo "Done"
