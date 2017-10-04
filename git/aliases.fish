alias gcp "git cherry-pick"
alias gaa "git add ."
alias gap "git add -p"
alias gnap "git add -N .; and git add -p"
alias glp "git log -p"
alias glg "git log --graph --oneline --decorate --color --all"
alias gb "git branch"
alias gc "git commit -v"
alias gca "git commit -a -v"
alias gcl "git clean -f -d"
alias gd "git diff"
alias gdc "git diff --cached"
alias gdh "git diff HEAD"
alias gl "git pull"
alias glod "git log --oneline --decorate"
alias gp "git push"
alias gst "git status"
alias gr "git rebase"
alias grc "git rebase --continue"
alias gra "git rebase --abort"
alias gco "git checkout"
alias reset-authors "git commit --amend --reset-author -C HEAD"

# git config pull.default = current :(

function gpr --argument-names origin branch
  test -n "$origin"; or set origin 'origin'
  test -n "$branch"; or set branch (git rev-parse --abbrev-ref HEAD)
  git pull --rebase $origin $branch
end
