if test -d /usr/local/heroku/bin
  set -gx PATH /usr/local/heroku/bin $PATH
end

alias h "heroku"
alias hs "heroku sudo --reason reasons"
alias cloud "heroku_cloud"
alias debug "heroku_debug"
