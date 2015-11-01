set -x __fish_datadir $DOTFILES_ROOT/fish

function fish_prompt
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal
  echo -n ' > '
end

function fish_greeting
  fortune
end

# rvm

source ~/.rvm/scripts/rvm

# heroku

set -gx PATH /usr/local/heroku/bin $PATH
set -x ION_USER ppravosud
alias h "heroku"
alias hs "heroku _sudo --reason reasons"
alias ic "ion-client"
