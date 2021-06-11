# sohooo's VIM config

This setup is based on various sources all around github. Huge credits go to these projects:

- [lspsaga](https://github.com/glepnir/lspsaga.nvim)
- [telescope](https://github.com/nvim-telescope/telescope.nvim)

## Features

- nvim 0.5 telescope-based setup
- complete package with useful plugins, bindings and colorschemes
- fully portable; place this repo anywhere you want
- modern telescope and lspsaga setup
- nicely structured and fine-tuned `vimrc` (`init.vim`) config for easy extension/modification
- enhanced markdown editing with folding, fenced code highlighting and TOC
- distraction-free writing mode with focus on current paragraph


## Installation

1. Put this repo in a place you like, for example: `git clone http://github.com/sohooo/nvim2.git ~/.dotvim`
2. Start Vim and install plugins: `vim -u ~/.dotvim/vimrc -c PlugInstall`
3. Bonus: create an alias to use your Vim installation, like: `alias v='nvim -u ~/.dotvim/vimrc'`; this way, we don't interfere with the system Vim installation.
4. Enjoy!


## Bindings

Here's a list of some useful keyboard bindings. To get an overview and search trough them, use `:Telescope keymaps`


### Finding stuff with Telescope

* `<space> f` find_files
* `<space> g` git_files
* `<space> s` live_grep ("search")
* `<space> b` buffers
* `<space> ta` tags
* `<space> th` help_tags
* `<space> to` todos
* `<leader><space>` find in current buffer

[Telescope bindings](https://github.com/nvim-telescope/telescope.nvim#mappings) to select/open files:

* `<c-n|p>` movement
* `<c-t>`   open in tab
* `<c-v>`   open in vertical split
* `<c-x>`   open in horizontal split


### lspsaga Helpers

* `gh`   find element
* `K`    show docs
* `gr`   rename element
* `gd`   preview definition
* `gs`   show signatur help
* `<space> h`   show line diagnostics


### Movement and others

* `s`       vim-sneak; like 'f', but multiple lines; `sab`
* `,d`      toggle nvim-tree; [bindings](https://github.com/kyazdani42/nvim-tree.lua#keybindings)
* `,u`      toggle UndoTree
* `,tr`     toggle Trouble diagnostics
* `,c`      toggle DiffView
* `,w`      toggle distraction-free writing
* `gcc`     toggle comment on/off
* `jk`      remap of ESC
* `<space> h` clear search highlight
* `F9`      toggle paste/nopaste
* `F10`     toggle number/nonumber
* `,te`     open terminal
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

- automatically removes trailing whitespace on save
- smart text objects: select text, then use `.` to enlage selection

### Statusbar Fonts
For an even prettier status bar, use one of the [powerline fonts](https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts).


### Distraction-free Writing
Distraction-free writing a la iAWriter is supported via [a plugin from LakTEK](http://laktek.com/2012/09/05/distraction-free-writing-with-vim/). Toggle the view with `,w`, and don't forget to disable the OSX native fullscreen view:

    defaults write org.vim.MacVim MMNativeFullScreen 0

You also need the [Cousine Font from Google](http://www.fontsquirrel.com/fonts/cousine) as a free alternative to Nitti Light.

