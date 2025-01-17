# While lazy loading requires manual overriding, it helps minimize zsh startup time, especially when creating splits

function load_nvm() {
  if [ -z "$NVM_LOADED" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    NVM_LOADED=true
  fi
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

function load_pyenv() {
  if [ -z "$PYENV_LOADED" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    PYENV_LOADED=true
  fi
}

function pyenv() {
  unset -f pyenv
  load_pyenv
  pyenv "$@"
}

function load_gcloud() {
  if [ -z "$GCLOUD_LOADED" ]; then
    if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
    if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
    GCLOUD_LOADED=true
  fi
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

