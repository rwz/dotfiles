function samldecode
  echo $argv | base64 --decode | xmllint --format --recover -
end
