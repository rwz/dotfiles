alias tmux "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

function mux
  set -l session (basename (pwd))
  tmux attach -t $session; or tmux new -s $session
end
