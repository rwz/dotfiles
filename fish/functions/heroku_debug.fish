function heroku_debug
  set -xg HEROKU_DEBUG 1
  eval $argv
  set -e HEROKU_DEBUG
end
