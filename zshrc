# .zshrc: interactive shell settings for zsh

#############################
#  oh-my-zsh configuration  #
#############################

system_name="$(uname -s)"
case "${system_name}" in
    Linux*)     
        export ZSH="${HOME}/.oh-my-zsh"
        ;;
    Darwin*)    
        export ZSH="${HOME}/.oh-my-zsh"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;
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

# Set up mise for runtime management
# eval "$(mise activate zsh)"
# eval $(thefuck --alias)

# nvm
# source /usr/share/nvm/init-nvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Added by LM Studio CLI (lms)
export PATH="$PATH:${HOME}/.lmstudio/bin"
# End of LM Studio CLI section

# Keychain
if type "keychain" > /dev/null; then 
    # https://serverfault.com/questions/672346/straight-forward-way-to-run-ssh-agent-and-ssh-add-on-login-via-ssh
    eval $(keychain -q --eval id_ed25519);
fi

