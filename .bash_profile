export PATH=$PATH:/usr/local/bin
export PATH=$HOME/anaconda/bin:$PATH
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT
export PS1="[\A \u@\h \W]\$ "

# functions
function mkcd {
  last=$(eval "echo \$$#")
  if [ ! -n "$last" ]; then
    echo "Enter a directory name"
  elif [ -d $last ]; then
    echo "$last already exists"
  else
    mkdir $@ && cd $last
  fi
}

function cd { if [[ $@ == "-" ]]; then command cd - > /dev/null; else command cd "$@"; fi;}

# function g { if [ -z "$1"] && git status; else command git "$@"; fi;}
# brew start
archey -o

eval $(thefuck --alias)
shopt -s extglob

[[ -f ~/.bashrc ]] && . ~/.bashrc
