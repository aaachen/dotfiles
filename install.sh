#!/usr/bin/env zsh

set -e 

FILES=(vim vimrc zshenv zshrc tmux.conf tmux.conf.local)

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $@\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $@\n"
}

error () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $@\n"
}

# link name: ~/.$1 to target: $1
function link () {
    local filename=$1
    if [[ ! -e $filename ]]; then
        error "$filename to be linked doesn't exist"
        exit 1
    fi

    local linkname="$HOME/.$filename"
    # backup files that are not symlinks before (potentially?) overwriting them 
    if [[ -e $linkname ]] && [[ ! -L $linkname ]]; then
        error "$linkname exists and is not a symlink"
        exit 1
    fi

    # override any existing symlinks, don't follow dir
    ln -sfn $PWD/$filename $linkname
    success "created $linkname symlink"
}

# install sub modules
find . -mindepth 2 -name 'install.sh' | while read FILE; do
    info "running $FILE..."
    $FILE
done

# link
info "linking ${(j: :)FILES}..."
for FILE in ${FILES[@]}
do
    link $FILE
done

# Oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing now..."
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

