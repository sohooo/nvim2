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
- enhanced markdown editing with folding, fenced code hightighting and TOC
- distraction-free writing mode with focus on current paragraph
- trailing whitespace on save are automatically removed
- regex commands (like search/replace) with live preview
- smart text objects: select text, then use `.` to enlage selection
- collab editing with [instant](https://github.com/jbyuki/instant.nvim)
- [which-key](https://github.com/folke/which-key.nvim): displays a popup with possible keybindings of the command you started typing


## Installation

1. Put this repo in a place you like, for example: `git clone http://github.com/sohooo/nvim2.git ~/.dotvim`
2. Start Vim and install plugins: `vim -u ~/.dotvim/vimrc -c PlugInstall`
3. Bonus: create an alias to use your Vim installation, like: `alias v='nvim -u ~/.dotvim/vimrc'`; this way, we don't interfere with the system Vim installation.
4. Enjoy!


## Bindings

Here's a list of some useful keyboard bindings. To get an overview and search trough them, use the `:Telescope keymaps` command.


### Finding stuff with Telescope

* `<space> f` find_files
* `<space> g` git_files
* `<space> s` live_grep ("search")
* `<space> b` buffers
* `<space> ta` tags
* `<space> th` help_tags
* `<space> to` todos
* `<leader><space>` find in current buffer

[Telescope bindings](https://github.com/nvim-telescope/telescope.nvim#mappings) to select/open files (same for nvim-tree):

* `<c-n|p>` movement
* `<c-t>`   open in tab
* `<c-v>`   open in vertical split
* `<c-x>`   open in horizontal split


### lsp(saga) Helpers

* `gh`   find element
* `K`    show docs
* `gr`   rename element
* `gd`   preview definition
* `gs`   show signatur help
* `<space> h`   show line diagnostics
* `,s`   fix **s**tyle (format) current file


### Movement and others

* `tab, S-tab` switch buffers
* `s`       [lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim);  like 'f', but multiple lines; `sab`
* `,a =`    align line/selection
* `,d`      toggle nvim-tree; [bindings](https://github.com/kyazdani42/nvim-tree.lua#keybindings)
* `,u`      toggle UndoTree
* `,tr`     toggle Trouble diagnostics
* `,w`      toggle distraction-free writing
* `gcc`     toggle comment on/off
* `kj`      remap of ESC
* `<space> l` clear search highlight
* `F9`      toggle paste/nopaste
* `F10`     toggle number/nonumber
* `,te`     toggle terminal
* `,tt`     open Vista nvim_lsp symbols
* `:GitBlameToggle`  show git blame info


### Snippets

* `ctrl-p | ctrl-n`  cycle through elements
* `ctrl-j`           complete snippet


### Fugitive

Browse the git histroy with style. [Docs](https://github.com/tpope/vim-fugitive), [screencast](http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/).

* `:Gdiff`    show diff
* `:Gstatus`  toggle files with `-`
* `:Glog -- %` load all commits which touched current file to quickfix list
* `:Glog --grep=findme` search for 'findme' in all ancestral commit messages
* `:Glog -Sfindme` search for 'findme' in the diff


## Workflows

### Search and Replace

Search and replace is like nothing you've ever experienced, thanks to `Telescope` and `quickfix-reflector`. Ok, let's say you want to replace the function `foo` with `bar` in some files in the project. Watch this:

- search for string: `<space> s` to open Telescope live_grep, then enter `foo`
- put those results into the quickfix list with `<ctrl> q` ([watch this](https://www.youtube.com/watch?v=IoyW8XYGqjM) if you have no idea what the quickfix list is)
- now, edit the contents in the quickfix list! optionally remove lines you don't want to replace, then some kind of: `:s/foo/bar/g`. We even get a preview of our replacement.
- if we're happy, `:w`rite the changes


### Markdown

* `:Toc`  display table of contents
* `zm, zO, ...`  usual folding syntax
*  fenced code blocks


### Distraction-free Writing

Distraction-free writing a la iAWriter is supported via [a plugin from LakTEK](http://laktek.com/2012/09/05/distraction-free-writing-with-vim/). Toggle the view with `,w`, and don't forget to disable the OSX native fullscreen view:

    defaults write org.vim.MacVim MMNativeFullScreen 0

You could also use [Cousine Font from Google](http://www.fontsquirrel.com/fonts/cousine) as a free alternative to Nitti Light, if that's your thing.



## Misc

### Fonts
For all the icons to show correctly, please use one of the [Nerd Fonts](https://www.nerdfonts.com).

