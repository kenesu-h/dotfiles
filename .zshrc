export EDITOR=nvim
export SHELL=$(which zsh)

if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi

# https://unix.stackexchange.com/a/132117
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
ssh-add -l 2>/dev/null >/dev/null
if [ $? -ge 2 ]; then
  ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
  if [[ $(uname) == "Darwin" ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_rsa
  else
    ssh-add ~/.ssh/id_rsa
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# Lazy-loaded Tools
function load_thefuck() {
  if [ -z "$THEFUCK_LOADED" ]; then
    eval "$(thefuck --alias)"
    THEFUCK_LOADED=true
  fi
}

function load_nvm() {
  if [ -z "$NVM_LOADED" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    NVM_LOADED=true
  fi
}

function load_pyenv() {
  if [ -z "$PYENV_LOADED" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    PYENV_LOADED=true
  fi
}

function load_gcloud() {
  if [ -z "$GCLOUD_LOADED" ]; then
    if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
    if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
    GCLOUD_LOADED=true
  fi
}

function thefuck() {
  unset -f thefuck
  load_thefuck
  thefuck "$@"
}

function fuck() {
  unset -f fuck
  load_thefuck
  fuck "$@"
}

function nvm() {
  unset -f nvm
  load_nvm
  nvm "$@"
}

function node() {
  unset -f node
  load_nvm
  node "$@"
}

function npm() {
  unset -f npm
  load_nvm
  npm "$@"
}

function yarn() {
  unset -f yarn
  load_nvm
  yarn "$@"
}

function nvim() {
  unset -f nvim
  load_nvm
  nvim "$@"
}

function pyenv() {
  unset -f pyenv
  load_pyenv
  pyenv "$@"
}

function gcloud() {
  unset -f gcloud
  load_gcloud
  gcloud "$@"
}

function cloud-sql-proxy() {
  unset -f cloud-sql-proxy
  load_gcloud
  cloud-sql-proxy "$@"
}

# Aliases
alias bw-login="envchain bw bw login --apikey"

function bw-password() {
  local bw_session=$(envchain bw bw unlock --passwordenv BW_PASSWORD)
  if [ -z "$bw_session" ]; then
    echo "Failed to unlock Bitwarden."
    return 1
  fi

  echo $(bw get password --session $bw_session "$@")
  bw lock >> /dev/null
}

alias venv="source .venv/bin/activate"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
