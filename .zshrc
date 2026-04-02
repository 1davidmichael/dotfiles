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

if [ -f "$HOME/.ssh/id_ed25519" ]; then
  zstyle :omz:plugins:ssh-agent identities id_ed25519
else
  zstyle :omz:plugins:ssh-agent identities id_rsa
fi

# Load plugins
plugins=(git aws docker ssh-agent terraform)

source $ZSH/oh-my-zsh.sh

# ── Environment Variables ─────────────────────────────────────────────────────

export NOTE_DIR="$HOME/Code/github/1davidmichael/Notes"
export NOTE_REPO="git@github.com:1davidmichael/Notes.git"

export AWS_DEFAULT_REGION=us-east-1

# Disable saml2aws keychain for WSL2 compatibility
export SAML2AWS_DISABLE_KEYCHAIN=true
export TERM=screen-256color-bce

# Prevents previous command output bleeding into next line prompt
# https://stackoverflow.com/questions/30940299/zsh-repeats-command-in-output
DISABLE_AUTO_TITLE="true"

# ── Editor ────────────────────────────────────────────────────────────────────

if command -v nvim &> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# ── PATH Additions ────────────────────────────────────────────────────────────

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.bin" ]; then
  export PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -d "$HOME/.poetry/bin" ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

if [ -d "$HOME/.config/composer/vendor/bin" ]; then
  export PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi

if [ -d "$HOME/.dotnet/tools" ]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi

if [ -d "$HOME/.guard/bin" ]; then
  export PATH="$HOME/.guard/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
  export PATH="$HOME/go/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  source "/opt/homebrew/opt/nvm/nvm.sh"
fi
if [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]; then
  source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

if [ -d "${KREW_ROOT:-$HOME/.krew}/bin" ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

if [ -d "/opt/homebrew/opt/node@22/bin" ]; then
  export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
fi

if [ -d "$HOME/.jenv/bin" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

if [ -d "/opt/homebrew/opt/gradle@7/bin" ]; then
  export PATH="/opt/homebrew/opt/gradle@7/bin:$PATH"
fi

if [ -d "/opt/homebrew/opt/openjdk/bin" ]; then
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi

if [ -d "$HOME/.rvm/bin" ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
fi

if [ -d "$HOME/.codeium/windsurf/bin" ]; then
  export PATH="$HOME/.codeium/windsurf/bin:$PATH"
fi

if [ -d "$HOME/.rd/bin" ]; then
  export PATH="$HOME/.rd/bin:$PATH"
fi

if [ -x "/usr/libexec/java_home" ]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 21)
fi

# ── Aliases ───────────────────────────────────────────────────────────────────

if [ $(uname) = "Darwin" ]; then
  alias upgrayedd="brew update && brew upgrade"
else
  alias upgrayedd="sudo apt update && sudo apt upgrade -y"
fi

if [ -x "$(command -v lvim)" ]; then
  alias vim="lvim"
fi

# ── Functions ─────────────────────────────────────────────────────────────────

function gi() { curl -sL "https://www.toptal.com/developers/gitignore/api/$@" ;}

# ── Tool Sourcing ─────────────────────────────────────────────────────────────

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
