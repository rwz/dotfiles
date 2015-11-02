set PATH $XDG_CONFIG_HOME/bin $PATH

for file in git heroku rvm
  source $XDG_CONFIG_HOME/fish/$file.fish
end

set CDPATH ~ ~/Projects
