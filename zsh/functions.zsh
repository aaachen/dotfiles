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

function rgvim {
    choice=$(rg -il $@ | fzf -0 -1 --ansi --preview "cat {}")
    [[ ! -z "$choice" ]] && vim "+/"$@ $choice
}
