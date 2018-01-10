set PATH $XDG_CONFIG_HOME/bin $PATH

for file in git heroku rvm rustup
  source $XDG_CONFIG_HOME/fish/$file.fish
end

# default editor
set -xg EDITOR "vim"

# go things
set -xg GOPATH "$HOME/Projects/go"
set -xg GOBIN "$GOPATH/bin"
set PATH $GOBIN $PATH

# vimpager is unstable, causes issues
# uncomment after an update
# set -xg PAGER vimpager
set -xg PAGER less

# some cd shortcuts
set CDPATH . ~ ~/Projects $GOPATH/src

# exercism
set -xg EXERCISM_CONFIG_FILE $XDG_CONFIG_HOME/support

# rvm always wants to be loaded last
rvm current 1>/dev/null 2>&1

# undefine grep function since it fucks up streaming
functions -e grep
