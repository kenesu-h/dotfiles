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


# Tools
eval $(thefuck --alias)

function lazy_load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function nvm() {
  unset -f nvm
  lazy_load_nvm
  nvm $@
}

function node() {
  unset -f node
  lazy_load_nvm
  node $@
}

function pyenv() {
  unset -f pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  pyenv $@
}

function gcloud() {
  unset -f gcloud
  if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
  if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
  gcloud $@
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
