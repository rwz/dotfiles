PATH=$DOTFILES_ROOT/bin:$PATH

for file in git heroku npm theme rvm nvm
do
  source $DOTFILES_ROOT/zsh/$file.sh
done

export EDITOR=vim

# syntax highlighting
source $DOTFILES_ROOT/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt appendhistory
setopt autocd
setopt extendedglob
setopt histignoredups
setopt nonomatch
setopt prompt_subst
setopt interactivecomments

set -o emacs

# tree
t() {
  level=${1:-2}
  tree -L $level
}

# external editor support
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# completion
autoload -U compinit; compinit

# set cd autocompletion to commonly visited directories
cdpath=(~ ~/Projects)

# remove duplicates in $PATH
typeset -aU path

# history
SAVEHIST=1000
HISTFILE=$DOTFILES_ROOT/zsh/history
