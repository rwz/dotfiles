function gcopr
  git fetch origin refs/pull/$argv[1]/head; and git checkout -b pr-$argv[1] FETCH_HEAD
end
