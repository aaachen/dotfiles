# .zshrc: interactive shell settings for zsh

#############################
#  oh-my-zsh configuration  #
#############################

system_name="$(uname -s)"
case "${system_name}" in
    Linux*)     
        export ZSH="/home/andrew/.oh-my-zsh";;
    Darwin*)    
        export ZSH="/User/aaachen/.oh-my-zsh";;
        eval "$(/opt/homebrew/bin/brew shellenv)"
esac

ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Powerlevel10k instant prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
    git 
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# source custom functions
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################
#  User configuration  #
########################

# remove all oh_my_zsh git alias, currently doesn't support option to turn off
omz_alias_remove=($(alias | grep "='git" | sed 's/=.*//g' | tr "\n" " " | tr -d "'"))
for a in $omz_alias_remove; do
    unalias $a
done
unset omz_alias_remove

# local, non-oh-my-zsh things
export _ZSH="$HOME/dotfiles/zsh"

# zsh specific configuration files to source
config_files=($_ZSH/*.zsh)

for file in $config_files; do
    source $file
done

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
# Set up mise for runtime management
# eval "$(mise activate zsh)"
# eval $(thefuck --alias)

# nvm
source /usr/share/nvm/init-nvm.sh
