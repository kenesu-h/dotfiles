alias nvimdiff="nvim -d"
alias nvim-config="nvim ~/.config/nvim"

# https://stackoverflow.com/a/65375231
function fzcd() {
  if [ -z "$1" ]; then
    cd "$(fd . --type d --base-directory=. | fzf)"
    return
  fi

  cd "$(fd . --type d --base-directory="$1" | fzf)"
}

function fzcdroot() {
  fzcd "$(git root)"
}

# https://stackoverflow.com/a/23442470
function cdroot() {
  cd "$(git root)"
}

function jqfmt() {
  if [ -z "$1" ]; then
    echo "File path required."
    return
  fi

  jq . "$1" | sponge "$1"
}

function docker-compose() {
  docker compose "$@"
}

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

  if [ -d ".venv" ]; then
    rm -r .venv
  fi
}

