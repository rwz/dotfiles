alias tmux="tmux -f $DOTFILES_ROOT/tmux/tmux.conf"

mux() {
  local session=$(basename `pwd`)
  tmux attach -t $session || tmux new -s $session
}
