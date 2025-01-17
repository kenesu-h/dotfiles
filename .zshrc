# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOME/.config/zsh/antidote.zsh"
source "$HOME/.config/zsh/tmux.zsh"
source "$HOME/.config/zsh/lazy.zsh"

source "$HOME/.config/zsh/env.zsh"
source "$HOME/.config/zsh/function.zsh"

if [ -n "$CORP_ENV" ]; then
  source "$HOME/.config/corp/.zshrc"
fi

autoload -U compinit; compinit

# Run `p10k configure` to customize
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
