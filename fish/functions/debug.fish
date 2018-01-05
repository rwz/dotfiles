function debug
  set command (string escape -- $argv)
  env DEBUG='*' fish -c "$command"
end
