set -x __fish_datadir $DOTFILES_ROOT/fish

# git status

source $__fish_datadir/git.fish

function fish_right_prompt
  __fish_git_prompt
end

function fish_prompt
  set_color $fish_color_cwd
  printf "%s" (prompt_pwd)
  set_color normal
  printf " > "
end

function fish_greeting
  fortune
end

# rvm

# doesn't work
# source ~/.rvm/scripts/rvm

# heroku

set -gx PATH /usr/local/heroku/bin $PATH
set -x ION_USER ppravosud
alias h "heroku"
alias hs "heroku _sudo --reason reasons"
alias ic "ion-client"
