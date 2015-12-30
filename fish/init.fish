set PATH $XDG_CONFIG_HOME/bin $PATH

for file in git heroku rvm
  source $XDG_CONFIG_HOME/fish/$file.fish
end

# default editor
set -xg EDITOR "vim"

# go things
set -xg GOPATH "$HOME/Projects/go"
set -xg GOBIN "$GOPATH/bin"
set PATH $GOBIN $PATH

# some cd shortcuts
set CDPATH . ~ ~/Projects $GOPATH/src

# exercism
set -xg EXERCISM_CONFIG_FILE $XDG_CONFIG_HOME/support

# rvm always wants to be loaded last
rvm current 1>/dev/null 2>&1
