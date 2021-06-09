# sohooo's VIM config

This setup is based on various sources all around github. Huge credits go to these projects:

- [bling.vim](https://github.com/bling/dotvim)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- [mutewinter's dotvim](https://github.com/mutewinter/dot_vim)
- [skwp's dotfiles](https://github.com/skwp/dotfiles)


## Features

- nvim 0.5 telescope-based setup
- complete package with useful plugins, bindings and colorschemes
- fully portable; place this repo anywhere you want
- nicely structured and fine-tuned `vimrc` (`init.vim`) config for easy extension/modification
- enhanced markdown editing with folding, fenced code highlighting and TOC
- distraction-free writing mode with focus on current paragraph


## Installation

1. Put this repo in a place you like, for example: `git clone http://github.com/sohooo/nvim2.git ~/.dotvim`
2. Start Vim and install plugins: `vim -u ~/.dotvim/vimrc -c PlugInstall`
3. Bonus: create an alias to use your Vim installation, like: `alias v='nvim -u ~/.dotvim/vimrc'`; this way, we don't interfere with the system Vim installation.
4. Enjoy!


## Bindings

Here's a list of some useful keyboard bindings:

### Finding stuff with Telescope

* `,f` find_files
* `,g` git_files
* `,s` live_grep ("search")
* `,b` buffers
* `,h` help_tags
* `,t` todos
* `,<space>` find in current buffer

[Telescope bindings](https://github.com/nvim-telescope/telescope.nvim#mappings) to select/open files:

* `<c-np>`  movement
* `<c-t>`   open in tab
* `<c-v>`   open in vertical split
* `<c-x>`   open in horizontal split


### Movement and others

* `s`       vim-sneak; like 'f', but multiple lines; `sab`
* `,d`      toggle NerdTree
* `,u`      toggle UndoTree
* `,w`      toggle distraction-free writing
* `gcc`     toggle comment on/off
* `jj`      remap of ESC
* `F9`      toggle paste/nopaste
* `F10`     toggle number/nonumber
* `,tt`     change tabs


### Snippets

* `ctrl-p | ctrl-n`  cycle through elements
* `ctrl-j`           complete snippet


### Fugitive

* `:Gdiff`    show diff
* `:Gstatus`  toggle files with `-`


### Tabular

* `,a=`  align =
* `,a:`  align :


### Markdown

* `:Toc`  display table of contents
* `zm, zO, ...`  usual folding syntax
*  fenced code blocks


## Other Tips

### Statusbar Fonts
For an even prettier status bar, use one of the [powerline fonts](https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts).


### Distraction-free Writing
Distraction-free writing a la iAWriter is supported via [a plugin from LakTEK](http://laktek.com/2012/09/05/distraction-free-writing-with-vim/). Toggle the view with `,w`, and don't forget to disable the OSX native fullscreen view:

    defaults write org.vim.MacVim MMNativeFullScreen 0

You also need the [Cousine Font from Google](http://www.fontsquirrel.com/fonts/cousine) as a free alternative to Nitti Light.

