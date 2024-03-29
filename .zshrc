export EDITOR=nvim
export SHELL=$(which zsh)

if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi

# https://unix.stackexchange.com/a/132117
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
ssh-add -l 2 > /dev/null > /dev/null
if [ $? -ge 2 ]; then
  ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
  [ -s "$HOME/.ssh/id_rsa" ] && ssh-add "$HOME/.ssh/id_rsa"
  [ -s "$HOME/.ssh/id_ed25519" ] && ssh-add "$HOME/.ssh/id_ed25519"
fi

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ ! -s "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  tmux source "$HOME/.config/tmux/tmux.conf"
fi

autoload -U compinit; compinit

if [ ! -s "$HOME/.antidote/antidote.zsh" ]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
fi
source "$HOME/.antidote/antidote.zsh"
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

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
function venv() {
  if [ -z "$1" ]; then
    if [ ! -d ".venv" ]; then
      echo "No venv found."
      return
    fi

    source .venv/bin/activate
  elif [ "$1" = "install" ]; then
    if [ -z "$VIRTUAL_ENV" ]; then
      echo "No virtual environment is active."
      return
    fi

    [ -s requirements.txt ] && python -m pip install -r requirements.txt
    [ -s requirements-test.txt ] && python -m pip install -r requirements-test.txt
  elif [ "$1" = "uninstall" ]; then
    if [ -z "$VIRTUAL_ENV" ]; then
      echo "No virtual environment is active."
      return
    fi

    python -m pip uninstall -y -r <(python -m pip freeze)
  fi
}

alias mkvenv="python -m venv .venv"

function rmvenv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  fi
  [ -d ".venv" ] && rm -r .venv
}

# Run `p10k configure` to customize
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
