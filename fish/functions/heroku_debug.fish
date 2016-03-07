function heroku_debug
  set -xg HEROKU_DEBUG 1
  set -xg HEROKU_DEBUG_HEADERS 1
  eval $argv
  set -e HEROKU_DEBUG
  set -e HEROKU_DEBUG_HEADERS
end
