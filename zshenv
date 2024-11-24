# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
# .zshenv contains exported variables that should be available to other programs.
# For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv.
# You can set $ZDOTDIR in .zshenv to specify an alternative location for the rest of your zsh configuration.

# The load order is: 
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes]

# rust cargo bin
export PATH=$PATH:$HOME/.cargo/bin
. "$HOME/.cargo/env"

export PATH=$PATH:$HOME/.spicetify
# I don't make user script here
# export PATH=$PATH:$HOME/bin

export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/Applications:$PATH

export f="/home/andrew/Dropbox/forest"
export fu="/home/andrew/Dropbox/forest/Utilities"
export fimg="/home/andrew/Dropbox/forest/Utilities/Images"
