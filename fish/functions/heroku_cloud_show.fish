function heroku_cloud_show
  if test -n "$HEROKU_CLOUD"; echo "HEROKU_CLOUD => $HEROKU_CLOUD"; end
  if test -n "$ION_HOST";  echo "ION_HOST => $ION_HOST"; end
  if test -n "$HEROKU_HOST"; echo "HEROKU_HOST => $HEROKU_HOST"; end
  if test -n "$HEROKU_API_URL"; echo "HEROKU_API_URL => $HEROKU_API_URL"; end
  if test -n "$HEROKU_STATUS_HOST"; echo "HEROKU_STATUS_HOST => $HEROKU_STATUS_HOST"; end
  if test -n "$USE_PUBLIC_IP"; echo "USE_PUBLIC_IP => $USE_PUBLIC_IP"; end
  if test -n "$HEROKU_APPDOMAIN"; echo "HEROKU_APPDOMAIN => $HEROKU_APPDOMAIN"; end

  if test (echo "$ION_HOST" | grep -o 'herokuapp\.com$')
    echo "
Heroku CLI creds are no longer updated automatically.
Please run \"ion-client creds:update\" for new devclouds.
    "
  end
end
