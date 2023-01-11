# rg.nvim
A tiny port of Ack.vim

## Installation
Installation via [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'alanjcfs/rg.nvim'
```

## How to Use

With ripgrep installed, you can use

```
:Rg "def show"
```

And it will open a quickfix window like `:grep`.

## Limitations

Currently, it can't handle single quote.

## Todos

* Fix single quotes
* Offer to install ripgrep via `homebrew` or other OS's package managers
