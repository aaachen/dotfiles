#! /bin/bash

echo "Updating/cleaning Vim plugins:"

vim -E -s <<-EOF
    :source ~/.vimrc
    :PlugInstall
    :PlugClean
    :qa
EOF

echo "Done" 
