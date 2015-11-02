function heroku_cloud_prompt
  set -l prefix "☁ "
  set -l cloud $HEROKU_CLOUD

  if test "$cloud" != "production" -a -n "$cloud"
    set_color 0bf
    printf $prefix
    set_color normal
    printf $cloud
  end
end
