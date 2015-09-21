export PATH="/usr/local/heroku/bin:$PATH"

alias h="heroku"
alias hs="heroku _sudo --reason reasons"
alias ic="ion-client"

export ION_USER=ppravosud

cloud() {
  eval "$(ion-client shell)"
  cloud "$@"
}

heroku_cloud_display() {
  if [[ ${HEROKU_CLOUD} != 'production' && ${HEROKU_CLOUD} != '' ]]; then
    echo "%{$fg[blue]%}[%{$fg[cyan]%}${HEROKU_CLOUD:u}%{$fg[blue]%}] "
  fi
}
