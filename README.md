# dotfiles

This directory includes my dotfiles.

## Requirements

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo using git.
```
git clone git@github.com:pucke-dev/dotfiles.git
cd dotfiles
```
then use stow to create symlinks.
```
stow --target ~ .
```
