if [ ! -s "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  tmux source "$HOME/.config/tmux/tmux.conf"
fi

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

