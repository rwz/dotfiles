function debug
  set command (string escape -- $argv)
  env DEBUG='*' HEROKU_DEBUG=1 HEROKU_DEBUG_HEADERS=1 fish -c "$command"
end
