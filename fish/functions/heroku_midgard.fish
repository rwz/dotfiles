function heroku_midgard
  set -xg HEROKU_HOST "https://midgard.heroku.com"
  set -xg HEROKU_SSL_VERIFY "disable"
  eval $argv
  set -e HEROKU_HOST
  set -e HEROKU_SSL_VERIFY
end
