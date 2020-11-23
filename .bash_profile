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
    echo "\`$last' already exists"
  else
    mkdir $@ && cd $last
  fi
}
function year {
 SCHOOL="/Users/Andrew/Desktop/School"
 if [ -z "$1" ]
 then 
     echo "Enter college year"
     return
 fi
 YEAR=
 case $1 in 
 1)
  YEAR="Freshman-Year"
  ;;
 2)
  YEAR="Sophomore-Year"
  ;;
 3)
  YEAR="Junior-Year"
  ;;
 *)
  echo "Unrecognized college year"
  ;;
 esac
 cd "$SCHOOL/$YEAR"
}

function cd { if [[ $@ == "-" ]]; then command cd - > /dev/null; else command cd "$@"; fi;}

# function g { if [ -z "$1"] && git status; else command git "$@"; fi;}
# brew start
archey -o

# source aliases
. .bash_aliases

eval $(thefuck --alias)
shopt -s extglob
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
