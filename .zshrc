# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

if [ -f $HOME/.ssh/id_devops ]; then
  zstyle :omz:plugins:ssh-agent identities id_rsa id_devops
else
  zstyle :omz:plugins:ssh-agent identities id_rsa
fi

# Load plugins
plugins=(git aws docker ssh-agent)

source $ZSH/oh-my-zsh.sh

# Prefer nvim if it exists
if [ -x "$(command -v nvim)"  ]; then
  alias vim="nvim"
fi

# Set notes dir
export NOTE_DIR="$HOME/Code/github/1davidmichael/Notes"
export NOTE_REPO="git@github.com:1davidmichael/Notes.git"

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

if [ -d  $HOME/.config/composer/vendor/bin ]; then
  export PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi

if [ -d  $HOME/.dotnet/tools ]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi

# Optionally add cfn-guard bin dir to path
if [ -d  $HOME/.guard/bin ]; then
  export PATH="$HOME/.guard/bin:$PATH"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Alias docker to podman if podman command is present
# This is to avoid licensing issues on work PC: https://www.docker.com/blog/updating-product-subscriptions/
if command -v podman &> /dev/null; then
  alias docker="podman"
fi

# Set default AWS region to us-east-1
export AWS_DEFAULT_REGION=us-east-1

# Disable saml2aws keychain for WSL2 compatibility
export SAML2AWS_DISABLE_KEYCHAIN=true

