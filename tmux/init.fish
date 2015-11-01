alias tmux "tmux -f $DOTFILES_ROOT/tmux/tmux.conf"

function mux
  set -l session (basename (pwd))
  tmux attach -t $session; or tmux new -s $session
end
