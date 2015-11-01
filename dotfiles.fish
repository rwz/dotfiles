set -x DOTFILES_ROOT (dirname (status -f))

for dir in fish git gem vim tmux
  source $DOTFILES_ROOT/$dir/init.fish
end
