# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export POWERLEVEL9K_INSTANT_PROMPT=quiet

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

if [ -f $HOME/.ssh/id_ed25519 ]; then
  zstyle :omz:plugins:ssh-agent identities id_ed25519
else
  zstyle :omz:plugins:ssh-agent identities id_rsa
fi

# Load plugins
plugins=(git aws docker ssh-agent terraform kubectl)

source $ZSH/oh-my-zsh.sh

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prefer nvim if it exists
if [ -x "$(command -v lvim)"  ]; then
  alias vim="lvim"
fi

# Set notes dir
export NOTE_DIR="$HOME/Code/github/1davidmichael/Notes"
export NOTE_REPO="git@github.com:1davidmichael/Notes.git"

# Set various paths for tooling if the are present
[ -d $HOME/.bin ] && export PATH=$PATH:~/.bin

if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
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

# Add Golang bin dir to path
if [ -d $HOME/go/bin ]; then
  export PATH="$HOME/go/bin":$PATH
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Alias docker to podman if podman command is present
# This is to avoid licensing issues on work PC: https://www.docker.com/blog/updating-product-subscriptions/
if command -v podman &> /dev/null; then
  alias docker="podman"
fi

export PATH="$HOME/.rd/bin":"$PATH"

if [ $(uname) = "Darwin" ]; then
  alias upgrayedd="brew update && brew upgrade"
else
  alias upgrayedd="sudo apt update && sudo apt upgrade -y"
fi

# Set default AWS region to us-east-1
export AWS_DEFAULT_REGION=us-east-1

# Disable saml2aws keychain for WSL2 compatibility
export SAML2AWS_DISABLE_KEYCHAIN=true
export TERM=screen-256color-bce

# Select editor based on what is available
if command -v lvim &> /dev/null; then
  export EDITOR=lvim
else
  export EDITOR=vim
fi

# Sets this prevents previous command output to next line
# # https://stackoverflow.com/questions/30940299/zsh-repeats-command-in-output
DISABLE_AUTO_TITLE="true"

function gi() { curl -sL "https://www.toptal.com/developers/gitignore/api/$@" ;}
export PATH=/Users/dmichael/.local/bin:$PATH

# bun completions
[ -s "/Users/dmichael/.bun/_bun" ] && source "/Users/dmichael/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
