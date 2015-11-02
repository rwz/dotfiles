function cloud_show
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

  return 0
end

function cloud
  if count $argv > /dev/null
    set cloud $argv[1]
  else
    cloud_show
    return 0
  end

  set -e ION_HOST
  set -e ION_DOMAIN
  set -e HEROKU_HOST
  set -e HEROKU_API_URL
  set -e HEROKU_STATUS_HOST
  set -e USE_PUBLIC_IP
  set -e HEROKU_APPDOMAIN
  set -e HEROKU_SSL_VERIFY

  set -x HEROKU_CLOUD $cloud

  switch $cloud
    case default production prod
      set -gx HEROKU_CLOUD "production"
      set -gx HEROKU_APPDOMAIN "herokuapp.com"
      echo "Unset ION_HOST HEROKU_HOST HEROKU_API_URL HEROKU_STATUS_HOST USE_PUBLIC_IP"
    case ops
      set -gx ION_HOST "ion-ops.herokai.com"
      set -gx HEROKU_HOST "ops.herokai.com"
    case staging
      set -gx ION_HOST "ion-staging.herokai.com"
      set -gx HEROKU_HOST "staging.herokudev.com"
      set -gx HEROKU_APPDOMAIN "staging.herokuappdev.com"
    case eu
      set -gx HEROKU_CLOUD "eu-west-1-a"
      set -gx ION_HOST "ion-eu-west-1-a.herokai.com"
    case us-west-2
      set -gx ION_HOST "ion-us-west-2.herokai.com"
      set -gx HEROKU_HOST "us-west-2.herokudev.com"
    case "*"
      set -gx ION_HOST "ion-$cloud.herokuapp.com"
      set -gx HEROKU_HOST "$cloud.herokudev.com"
      set -gx HEROKU_STATUS_HOST "status-$cloud.herokuapp.com"
  end

  if test -n "$ION_HOST"
    set -gx ION_DOMAIN $ION_HOST
  end

  if test -n "$HEROKU_HOST"
    set -gx HEROKU_API_URL "https://api.$HEROKU_HOST"
  end

  cloud_show
end
