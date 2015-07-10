export DOTFILES_ROOT=$(cd "$( dirname "$0" )" && pwd)

for dir in zsh git gem vim tmux
do
  source $DOTFILES_ROOT/$dir/init.sh
done
