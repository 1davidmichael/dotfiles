# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="robbyrussell"

# Load plugins
plugins=(git aws ssh-agent docker)

source $ZSH/oh-my-zsh.sh

# Prefer nvim if it exists
if [ -x "$(command -v nvim)"  ]; then
  alias vim="nvim"
fi

# Set notes dir
export NOTE_DIR="$HOME/Code/github/1davidmichael/Notes"

# Add ssh keys to ssh-agent
zstyle :omz:plugins:ssh-agent identities id_rsa id_devops

# Set various paths for tooling if the are present
[ -d $HOME/.bin ] && export PATH=$PATH:~/.bin

if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -d  $HOME/.poetry ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
