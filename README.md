# dotfiles

The goal of this dotfiles setup is to provide a fully portable shell with all
cool things with a single entry point. That means that it won't crap all over
your home directory with a bunch of dot-dirs and symlinks like other dotfile
ditributions.

## Installation

Clone this repo somewhere:

```sh
git clone git@github.com:rwz/dotfiles.git muh-dotfiles
```

Change your shell to shell from dotfiles:

```sh
sudo chsh -s /path/to/muh-dotfiles/shell yourusername
```

And you're done.

## Uninstall

Change your shell to whatever it was before:

```sh
chsh -s /bin/bash
```

## Requirements

The setup implies that you're running OSX with fish shell installed and the
shell is available at `/usr/bin/local/fish`.
