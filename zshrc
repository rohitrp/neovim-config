# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting docker-compose z)

source $ZSH/oh-my-zsh.sh
. ~/z.sh

if [[ -r ~/.phpbrew/bashrc ]]; then
  source ~/.phpbrew/bashrc
fi

alias n='nvim .'
alias install='sudo apt-get install'
alias search='sudo apt-cache search'
alias purge='sudo apt-get purge'
alias update='sudo apt-get update'
alias c7="sudo chmod -R 777"
alias l="ls -l"
alias c="clear"
alias www="cd /var/www"
#alias code="cd ~/code"

export PATH=$PATH:/usr/local/go/bin:~/go/bin
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
export FZF_DEFAULT_COMMAND='rg --files'
# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^t' autosuggest-execute
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
[ -f ~/.zsh_secret ] && source ~/.zsh_secret

export NVM_DIR="/home/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/home/$USER/anaconda3/bin:$PATH

#export {http,https,ftp}_proxy="http://netmon.iitb.ac.in:80/"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fpath=($fpath "/home/rp/.zfunctions")
