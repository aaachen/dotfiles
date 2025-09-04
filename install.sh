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
    # Special handling for zshrc: backup if it exists
    if [[ $filename == "zshrc" ]] && [[ -e $linkname ]]; then
        local timestamp=$(date +%Y%m%d%H%M%S)
        mv "$linkname" "$linkname.backup.$timestamp"
        info "backed up existing $linkname to $linkname.backup.$timestamp"
    elif [[ -e $linkname ]] && [[ ! -L $linkname ]]; then
        error "$linkname exists and is not a symlink"
        exit 1
    fi

    # override any existing symlinks, don't follow dir
    ln -sfn $PWD/$filename $linkname
    success "created $linkname symlink"
}

# install sub modules
# let vim plug install the vim dependencies
find . -mindepth 2 -maxdepth 2 -name 'install.sh' | while read FILE; do
    info "running $FILE..."
    $FILE
done

# link
info "linking ${(j: :)FILES}..."
for FILE in ${FILES[@]}
do
    link $FILE
done

