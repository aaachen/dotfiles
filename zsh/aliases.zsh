#------------------------------------------------------------------------------#
#                                     alias                                    #
#------------------------------------------------------------------------------#

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias ..="cd .."
alias h="cd ~/Desktop"
alias l="ls -G"
alias ll="ls -al -G"
alias la="ls -aG"
alias ,dm="docker-machine"
alias v="vim"

# Git Aliases
alias gs='git status'
alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias ga='git add -A'
alias gm='git merge'
alias gr='git rebase'
alias co='git co'
alias gf='git fetch'
alias gd='git diff'
alias gplr='git pull --rebase'
alias gps='git push'
alias grs='git reset'

# pacman
alias orph='pacman -Qdtq'
alias rmorph='pacman -Rs $(pacman -Qdtq)'

# qrcp
alias receive-phone-file='qrcp receive --output=/home/andrew/tmp/qrcp'
alias send-phone-file='qrcp'

# Common shell functions
alias k9='kill -9'

# Homebrew
alias brewu='brew update && brew upgrade && brew cleanup && brew doctor'

case "$(uname -s)" in
    Linux*)     alias o="xdg-open"; alias open="xdg-open";;
    Darwin*)    alias o="open";;
esac
