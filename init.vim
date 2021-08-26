" =========================================
" Who:   Sven Sporer <<||>> sohooo
" Where: https://github.com/sohooo/nvim2
" =========================================
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
"
" intro and credits {{{
"
" Yet another refresh of my dotfiles, with a focus on neovim 0.5 and above.
" It is designed to be fully portable. This vimrc can be placed anywhere.
"
" Usage
" -----
"
" 0) clone this repo and put it where you want (doesnt have to be
" ~/.config/nvim)
" 1) install all plugins:
"     nvim -u init.vim
"     :PlugInstall
" 2) create alias for nice use:
"     alias v='mvim /path/to/init.vim'
" 3) happy VIMing!
"
"
" Links
" -----
"
" This config can be found at: https://github.com/sohooo/nvim2
" The setup is also heavily inspired by the following:
"   - https://github.com/sohooo/dotvim2
"   - Vim Configs: folke
"   - Youtube: ThePrimeagen
"
" }}}

" environment & Plug {{{
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set clean, default 'runtimepath' (without ~/.vim folders)
  let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

  " what is the name of the directory containing this file?
  " The usage is: vim -u /path/to/portable/vim/.vimrc
  let s:portable = expand('<sfile>:p:h')

  " add the directory to 'runtimepath'
  " various paths
  let g:mods   = s:portable . '/mods'       " local modifications
  let g:readme = s:portable . '/README.md'  " README.md of this project
  let g:vimrc  = expand('<sfile>')          " this vimrc

  let &runtimepath = printf('%s,%s,%s/after,%s/bundle/plug.vim', s:portable, &runtimepath, s:portable, s:portable)

  " Plugins managed by vim-plug: https://github.com/junegunn/vim-plug
  " Tell vim-plug where to put plugins: /path_of_this_file/bundle
  call plug#begin(printf('%s/bundle', s:portable))

  " load local ./mods
  Plug printf('%s/logfile', g:mods)
" }}}

" detect OS {{{
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
  let s:is_macvim = has('gui_macvim')
  let s:is_unix   = has('unix')
" }}}

" common options {{{
  set guicursor
  set ruler              " Ruler on
  set number             " Line numbers on
  set relativenumber     " line no relative to position
  set laststatus=2       " Always show the statusline
  set cmdheight=1        " height of commandbar
  set notitle            " set terminal's title
  set scrolloff=8        " show 8 lines of context around cursor
  set showmode           " display mode you're in
  set wrap               " turn on line wrapping
  set inccommand=split   " show regular expression previews
  set numberwidth=4      " width of line numbers
  set signcolumn=auto:3  " space for lsp & git signs
  set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
  set fillchars=diff:⣿,vert:│
  set wildignore+=*.pyc,*.cache,*.min.*,*/.git/**/*,*/node_modules/**/*,*.swp,*.bak
  " set showbreak=↪

  set nobackup
  set noswapfile

  " if has('conceal')
  "   set conceallevel=1
  "   set listchars+=conceal:Δ
  " endif

  if s:is_macvim
    " set guifont=Sauce\ Code\ Powerline:h13
    set guifont=FiraCode-Regular:h14
    " set guifont=Sauce\ Code\ Powerline\ Light:h13
    "set guifont=Hasklig-Regular:h14
    set macligatures
    " set transparency=1

    " Dash.app integration
    Plug 'rizzatti/dash.vim'

    " copy with syntax highlighting: CopyRTF
    Plug 'zerowidth/vim-copy-as-rtf'

    " Hide Toolbar in MacVim
    if has("gui_running")
      set guioptions=egmrt
    endif

  elseif s:is_windows
     " Windows
    set guifont=Consolas:h10:cANSI
    set guioptions-=T " disable: include Toolbar
    set guioptions-=m " disable: Menu bar is present
    set guioptions-=r " disable: right-hand scrollbar always present

    " Set height and width on Windows
    set lines=60
    set columns=120

    " Windows has a nasty habit of launching gVim in the wrong working directory
    cd ~
  endif

  syntax enable
  set t_ti=
  set t_te=
  "set t_Co=256           " number of supported colors
  set autoread           " Automatically reload changes if detected
  set wildmenu           " Turn on WiLd menu
  set hidden             " Change buffer - without saving
  set history=768        " Number of things to remember in history.
  set cf                 " Enable error files & error jumping.
  set clipboard+=unnamed " Yanks go on clipboard instead.
  set autowrite          " Writes on make/shell commands
  set timeoutlen=2500    " Time to wait for a command (after leader for example)
  set foldlevel=0        " enable folding
  set foldlevelstart=99  " Open all folds on start
  set formatoptions=crql
  set updatetime=50

  set ignorecase         " Case insensitive search
  set smartcase          " Non-case sensitive search
  set incsearch
  set hlsearch

  set showmatch          " Show matching brackets.
  set matchtime=2        " How many tenths of a second to blink

  set noerrorbells
  set visualbell         " disables beep in macvim
  set t_vb=

  set mousehide  " Hide mouse after chars typed
  set mouse=a    " Mouse in all modes

  " nvim-compe complete options
  set completeopt=menuone,noselect
  "set complete=.,w,b,u,U

  set tabstop=2
  set backspace=2   " Delete everything with backspace
  set shiftwidth=2  " Tabs under smart indent
  set cindent
  set autoindent
  set smarttab
  set expandtab
" }}}

" bindings {{{
  let mapleader=","
  "nmap <silent> <leader>s :set spell!<CR>
  nmap <silent> <leader>vim :e <sfile><CR>
  nmap <leader>r :syntax sync fromstart<cr>:redraw!<cr>

  " jenkins pipeline linting for .groovy files
  au FileType groovy nmap <leader>l :!ssh -l $GIT_AUTHOR_NAME -p 58888 JENKINS_HOST declarative-linter < %<cr>

  " puppet syntax linting
  au FileType puppet nmap <leader>l :!puppet-lint %<cr>

  " window movement
  nmap <silent> <C-h> :wincmd h<CR>
  nmap <silent> <C-j> :wincmd j<CR>
  nmap <silent> <C-k> :wincmd k<CR>
  nmap <silent> <C-l> :wincmd l<CR>

  " fixes common typos
  command W w
  command Wq wq
  command Wqa wqa
  command Q q
  command Qa qa
  map <F1> <Esc>
  imap <F1> <Esc>

  " for the lazy: remap escape
  inoremap kj <Esc>
  inoremap jk <Esc>
  " Make line completion easier
  inoremap <C-l> <C-x><C-l>

  " switch buffers with tab
  nnoremap <tab>   :bnext<cr>
  nnoremap <S-tab> :bprevious<cr>

  " thx prime: https://youtu.be/hSHATqh8svM
  " make Y behave like other capitals
  nnoremap Y yg_
  " keep the cursor in place while joining limes
  nnoremap J mzJ`z
  " keep search matches in the middle of the window.
  nnoremap n nzzzv
  nnoremap N Nzzzv
  " same when jumping around
  nnoremap g; g;zz
  nnoremap g, g,zz
  " undo breakpoints
  " inoremap , ,<c-g>u
  " inoremap . .<c-g>u
  " inoremap ! !<c-g>u
  " inoremap ? ?<c-g>u
  " inoremap [ [<c-g>u
  " move lines with +|-
  " vnoremap - :m '>+1<cr>gv=gv
  " vnoremap + :m '<-2<cr>gv=gv

  " change word with cn or cN; go next with '.'
  nnoremap cn *``cgn
  nnoremap cN *``cgN

  " close those windows
  nnoremap cl :pclose \| lclose \| cclose<cr>

  " remove current search highlighting
  nnoremap <space>l :nohlsearch<cr>

  " terminal
  " Getting out of the terminal insert mode.
  tnoremap <Esc><Esc> <C-\><C-n>
  " nnoremap <leader>te :sp<Cr>:terminal<Cr>a  " classic terminal
  " termwrapper plugin
  nnoremap <leader>te :Ttoggle<cr>

  " toggle paste mode on/off
  map <F9> :set paste!<cr>:set paste?<cr>
  " toggle line numbers
  map <F10> :set number!<cr>:set number?<cr>

  " display help with 'K'
  au BufReadPost *.rb set keywordprg=ri
  au BufReadPost *.pp set keywordprg=puppet\ describe

  " filetypes
  au BufRead,BufNewFile *.pp setfiletype puppet

  " easy tab switching
  nmap tt :tabnext<cr>
  map  tt :tabnext<cr>
  nmap <C-t> :tabnew<cr>
  imap <C-t> <Esc>:tabnew<cr>

  " same indent behaviour in visual mode
  vmap > >gv
  vmap < <gv

  " improve up/down movement on wrapped lines
  nnoremap j gj
  nnoremap k gk

  " show README to help with bindings
  nmap <silent><leader>h   :exe ":tabnew ". g:readme<cr>
  nmap <silent><leader>vim :exe ":tabnew ". g:vimrc<cr>
"}}}

" telescope {{{
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-symbols.nvim'

  " Find files using Telescope command-line sugar.
	nnoremap <space>f <cmd>Telescope find_files<cr>
	nnoremap <space>g <cmd>Telescope git_files<cr>
  nnoremap <space>s <cmd>Telescope live_grep<cr>
  nnoremap <space>b <cmd>Telescope buffers<cr>
  nnoremap <space>th <cmd>Telescope help_tags<cr>
  nnoremap <space>ta <cmd>Telescope tags<cr>
  nnoremap <space>to <cmd>TodoTelescope<cr>
  nnoremap <space>td <cmd>Telescope lsp_workspace_diagnostics<cr>
  "nnoremap <leader><space> <cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>
  nnoremap <leader><space> <cmd>Telescope current_buffer_fuzzy_find<cr>
" }}}

" LSP setup {{{
	" Pictograms for lsp completion items
	Plug 'onsails/lspkind-nvim'
	Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim' "{{{
    nnoremap <silent> gh    <cmd>Lspsaga lsp_finder<CR>
    nnoremap <silent> K     <cmd>Lspsaga hover_doc<CR>
    nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
    nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
    nnoremap <silent> gr    <cmd>Lspsaga rename<CR>
    nnoremap <silent> gd    <cmd>Lspsaga preview_definition<CR>
    nnoremap <space>  e     <cmd>Lspsaga show_line_diagnostics<CR>
    nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
    xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
    nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>

    " scroll hover doc or scroll in definition preview
    nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
    nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>


    " also lsp, but not lspsaga
    " nnoremap <space> e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
    nnoremap <leader>s gggqG \| <cmd>lua vim.lsp.buf.formatting()<cr>
  "}}}
" }}}

" language {{{
  Plug 'sheerun/vim-polyglot'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'hail2u/vim-css3-syntax'
"}}}

" autocompletion, snippets {{{
	Plug 'rafamadriz/friendly-snippets'
  Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'hrsh7th/vim-vsnip' "{{{
		" bindings: ctrl-p|n to select, ctrl-j|l to expand; (s-)tab to jump
		" Expand
		imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
		smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

		" Expand or jump
		imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
		smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

		" Jump forward or backward
		imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
		smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
		imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
		smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
	"}}}

  " bindings: ctrl-p|n navigation
	Plug 'hrsh7th/nvim-compe' "{{{
		let g:compe = {}
		let g:compe.enabled = v:true
		let g:compe.autocomplete = v:true
		let g:compe.debug = v:false
		let g:compe.min_length = 1
		let g:compe.preselect = 'enable'
		let g:compe.throttle_time = 80
		let g:compe.source_timeout = 200
		let g:compe.incomplete_delay = 400
		let g:compe.max_abbr_width = 100
		let g:compe.max_kind_width = 100
		let g:compe.max_menu_width = 100
		let g:compe.documentation = v:true

		let g:compe.source = {}
		let g:compe.source.path = v:true
		let g:compe.source.buffer = v:true
		let g:compe.source.calc = v:true
		let g:compe.source.nvim_lsp = v:true
		let g:compe.source.nvim_lua = v:true
		let g:compe.source.vsnip = v:true
		"let g:compe.source.ultisnips = v:true

		inoremap <silent><expr> <C-Space> compe#complete()
		"inoremap <silent><expr> <CR>      compe#confirm('<CR>')
		inoremap <silent><expr> <C-e>     compe#close('<C-e>')
		inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
		inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
  "}}}
"}}}

" editing tools {{{

  "Nvim Treesitter configurations and abstraction layer
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'romgrk/nvim-treesitter-context'
  Plug 'RRethy/nvim-treesitter-textsubjects'

  Plug 'ggandor/lightspeed.nvim' "vim-sneak alternative

  Plug 'jbyuki/instant.nvim' "{{{
    "collaborative editing in Neovim using built-in capabilities
    let g:instant_username = "sohooo"
  " }}}

  Plug 'stefandtw/quickfix-reflector.vim' " Change code right in the quickfix window

  Plug 'windwp/nvim-autopairs' "autopairs for neovim written by lua
  Plug 'tversteeg/registers.nvim' "NeoVim plugin to preview the contents of the registers

  Plug 'tpope/vim-surround' "quoting/parenthesizing made simple
  Plug 'tpope/vim-repeat' "enable repeating supported plugin maps with .
  Plug 'tpope/vim-endwise' "wisely add end in ruby, endfunction/endif/more in vim script, etc
  Plug 'tpope/vim-jdaddy' "JSON manipulation and pretty printing
  Plug 'tpope/vim-fugitive' "A Git wrapper so awesome, it should be illegal

  Plug 'b3nj5m1n/kommentary'

  Plug 'rhysd/committia.vim' "A Vim plugin for more pleasant editing on commit messages
  Plug 'mhinz/vim-startify' "🔗 The fancy start screen for Vim.
  Plug 'folke/todo-comments.nvim' "Highlight, list and search todo comments in your projects
  Plug 'andrewradev/splitjoin.vim' "gS (split), gJ (join) code blocks
  Plug 'sickill/vim-pasta' "pasting with indentation adjusted to destination context
  Plug 'AndrewRadev/tagalong.vim' " Change an HTML(ish) opening tag and take the closing one along as well
  Plug 'andymass/vim-matchup' "even better % 👊 navigate and highlight matching words 👊 modern matchit and matchparen replacement
  Plug 'junegunn/vim-easy-align' "{{{
    "A Vim alignment plugin 🌻; bindings:
    nmap <leader>a <Plug>(EasyAlign)
    xmap <leader>a <Plug>(EasyAlign)
  "}}}
  "
  Plug 'folke/trouble.nvim' "{{{
    "A pretty diagnostics, references, telescope results, quickfix and location list
    nmap <leader>tr :TroubleToggle<cr>
  "}}}

  Plug 'folke/which-key.nvim'

  Plug 'liuchengxu/vista.vim', { 'on': 'Vista' } "{{{
    " Viewer & Finder for LSP symbols and tags
    let g:vista#renderer#enable_icon = 0
    nnoremap <leader>tt :Vista nvim_lsp<cr>
  "}}}
"}}}

" addons, layout {{{
  Plug 'oberblastmeister/termwrapper.nvim' "{{{
    " let g:test#custom_strategies = {'termwrapper': function('TermWrapperStrategy')}
    " let g:test#strategy = 'termwrapper'
  "}}}

  " FIXME: nvim update required
  " Plug 'kevinhwang91/nvim-hlslens' "{{{
  "   noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
  "         \<Cmd>lua require('hlslens').start()<CR>
  "   noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
  "         \<Cmd>lua require('hlslens').start()<CR>
  "   noremap * *<Cmd>lua require('hlslens').start()<CR>
  "   noremap # #<Cmd>lua require('hlslens').start()<CR>
  "   noremap g* g*<Cmd>lua require('hlslens').start()<CR>
  "   noremap g# g#<Cmd>lua require('hlslens').start()<CR>
  " "}}}

  Plug 'TimUntersberger/neogit' "{{{
    noremap <leader>c <Cmd>Neogit<CR>
  "}}}

  Plug 'christoomey/vim-tmux-navigator' "Seamless navigation between tmux panes and vim splits

	Plug 'kyazdani42/nvim-tree.lua' "{{{
    let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
    let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
    let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
    let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
    let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
    let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
    let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree

    let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

    let g:nvim_tree_icons = {
    \ 'folder': {
    \   'arrow_open': "▾",
    \   'arrow_closed': "▸",
    \   'default': "▸",
    \   'open': "▾",
    \   'empty': "▸",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

    nnoremap <leader>d :NvimTreeToggle<CR>
  "}}}

  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } "{{{
    let g:undotree_SplitLocation='botright'
    let g:undotree_SetFocusWhenToggle=1
    nnoremap <leader>u :UndotreeToggle<CR>
  "}}}

  Plug 'janko-m/vim-test' "{{{
    nmap <leader>tn :TestNearest<CR>
    nmap <leader>tf :TestFile<CR>
    nmap <leader>ts :TestSuite<CR>
    nmap <leader>tl :TestLast<CR>
    nmap <leader>tg :TestVisit<CR>

    let test#ruby#rspec#executable = './rspec'
    let test#ruby#cucumber#executable = './cucumber'
  "}}}
"}}}

" visuals {{{
  Plug 'RRethy/vim-illuminate'
  Plug 'lewis6991/gitsigns.nvim'
  " Plug 'ryanoasis/vim-devicons'
  " Plug 'kyazdani42/nvim-web-devicons' "lua fork of vim-web-devicons for neovim; no hook for nerdtree
  Plug 'p00f/nvim-ts-rainbow' "🌈 Rainbow parentheses for neovim using tree-sitter
  Plug 'kshenoy/vim-signature' "Plugin to toggle, display and navigate marks
  Plug 'folke/lsp-colors.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim' "{{{
    let g:indent_blankline_use_treesitter = v:true
  "}}}


  Plug 'f-person/git-blame.nvim', { 'on': 'GitBlameToggle' } " {{{
    let g:gitblame_enabled = 0
    let g:gitblame_message_template = ' <author> • <date> • <summary>'
  " }}}

  Plug 'hoob3rt/lualine.nvim'
  Plug 'kdheepak/tabline.nvim'

  Plug 'camspiers/lens.vim' "{{{
    " let g:lens#disabled = 1
    let g:lens#animate = 0
    let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
    " let g:lens#height_resize_max = 20
    " let g:lens#height_resize_min = 5
    " let g:lens#width_resize_max = 80
    " let g:lens#width_resize_min = 20
  "}}}

"}}}

" colorschemes {{{
  Plug 'cocopon/iceberg.vim'                          " iceberg
  Plug 'w0ng/vim-hybrid'                              " hybrid
  Plug 'jacoborus/tender.vim'                         " tender
  Plug 'gosukiwi/vim-atom-dark'                       " atom-dark-256
  Plug 'danilo-augusto/vim-afterglow'
  Plug 'kristijanhusak/vim-hybrid-material'           " hybrid_material
  Plug 'sainnhe/gruvbox-material'
  Plug 'sainnhe/sonokai'
  Plug 'marko-cerovac/material.nvim'

  Plug 'shaunsingh/moonlight.nvim' " {{{
    " let g:moonlight_italic_comments = true
    " let g:moonlight_italic_keywords = true
    " let g:moonlight_italic_functions = true
    " let g:moonlight_italic_variables = false
    " let g:moonlight_contrast = true
    " let g:moonlight_borders = false
    " let g:moonlight_disable_background = false
  "}}}

  " FIXME: error on load?
  " Plug 'shaunsingh/nord.nvim'

  " require termguicolors
  " Plug 'folke/tokyonight.nvim'
" }}}

" distraction-free writing {{{
  nmap <leader>w :Goyo<CR>
  Plug 'junegunn/goyo.vim' "{{{
    function! s:goyo_enter()
      silent !tmux set status off
      set noshowmode
      set noshowcmd
      set scrolloff=999
      Limelight
    endfunction

    function! s:goyo_leave()
      silent !tmux set status on
      set showmode
      set showcmd
      set scrolloff=8
      Limelight!
    endfunction

    autocmd! User GoyoEnter
    autocmd! User GoyoLeave
    autocmd  User GoyoEnter nested call <SID>goyo_enter()
    autocmd  User GoyoLeave nested call <SID>goyo_leave()
  "}}}
  Plug 'junegunn/limelight.vim' "{{{
    let g:limelight_default_coefficient = 0.7
  "}}}
" }}}

call plug#end()
filetype plugin indent on
syntax enable

" lua config {{{
lua << EOF

require('nvim-treesitter.configs').setup {
  -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  ensure_installed = { -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    "bash",
    "css",
    "go",
    "html",
    "json",
    "lua",
    "php",
    "python",
    "ruby",
    "rust",
    "toml",
    "yaml",
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
    }
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
  }
}

require('nvim-autopairs').setup()

require('which-key').setup {}

require('telescope').setup {
  color_devicons = false,
}

require('todo-comments').setup {
  signs = false
}

require("trouble").setup {
  -- settings without a patched font or icons
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  icons = false, -- requires nvim-web-devicons
  signs = {
      -- icons / text used for a diagnostic
      error = "error",
      warning = "warn",
      hint = "hint",
      information = "info"
  },
  use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- LSP settings
-- https://github.com/neovim/nvim-lspconfig
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- jump back w/ <c-o>
  --buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '<c-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<c-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

-- map buffer local keybindings when the language server attaches
-- ruby/solargraph
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#solargraph
require'lspconfig'.solargraph.setup {
  on_attach = on_attach,
  settings = {
    solargraph = {
      autoformat = true,
      formatting = true,
      definitions = true,
      hover = true,
      logLevel = "warn",
      rename = true,
      symbols = true,
    }
  }
}
--require'lspconfig'.bashls.setup{}
--require'lspconfig'.sorbet.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    --virtual_text = false,
    virtual_text = {
      spacing = 4,
      severity_limit = 'Warning',
    },
    underline = false,
    signs = true, -- signs customized below
  }
)

-- automatically show lsp popup on hover
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

-- require('lspsaga').init_lsp_saga()
require('lspsaga').init_lsp_saga {
    error_sign = "✯",
    warn_sign = "◆",
    hint_sign = "○",
    infor_sign = "◇",

    -- override ugly vim.lsp arrow icon
    --error_sign = '', -- 
    --warn_sign = '',
    --hint_sign = '',
    --infor_sign = '',

    -- non-patched font variant
    --error_sign = "ⓧ",
    --warn_sign = "⚠",
    --hint_sign = "ⓘ",
    --infor_sign = "ⓘ",
}

doc_scroll_up = function(default_key)
  if require('lspsaga.hover').has_saga_hover() then
    require('lspsaga.hover').smart_scroll_hover(-1)
  else
    local key = vim.api.nvim_replace_termcodes(default_key,true,false,true)
    vim.fn.nvim_feedkeys(key,'n',true)
  end
end

require('lspkind').init({})

require('termwrapper').setup {
  -- these are all of the defaults
  open_autoinsert = true, -- autoinsert when opening
  toggle_autoinsert = true, -- autoinsert when toggling
  autoclose = true, -- autoclose, (no [Process exited 0])
  winenter_autoinsert = false, -- autoinsert when entering the window
  default_window_command = "belowright 13split", -- the default window command to run when none is specified,
  -- opens a window in the bottom
  open_new_toggle = true, -- open a new terminal if the toggle target does not exist
  log = 1, -- 1 = warning, 2 = info, 3 = debug
}

require('neogit').setup{
  mappings = {
    -- modify status buffer mappings
    status = {
      ["o"] = "Toggle",
      ["<space>"] = "Toggle",
    }
  }
}

require('lightspeed').setup {
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  highlight_unique_chars = false,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 5,
  full_inclusive_prefix_key = '<c-x>',
  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil,
}

require('gitsigns').setup()

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'nord',  -- moonlight
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    --lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'hostname'},
    --lualine_y = {'diagnostics'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    --lualine_a = {},
    --lualine_b = {},
    --lualine_c = { require'tabline'.tabline_buffers },
    --lualine_x = { require'tabline'.tabline_tabs },
    --lualine_y = {},
    --lualine_z = {},
  },
  extensions = {}
}
require'tabline'.setup {
  -- Defaults configuration options
  enable = true,
  options = {
  -- If lualine is installed tabline will use separators configured in lualine by default.
  -- These options can be used to override those settings.
  --section_separators = {'', ''},
  section_separators = {'', ''},
  component_separators = {'', ''},
  max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
  always_show_tabs = false, -- by default, this shows tabs only when there are more than one tab or if the first tab is named
  }
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
	{ key = "s", cb = tree_cb("vsplit") },
	{ key = "i", cb = tree_cb("split") },
	{ key = "t", cb = tree_cb("tabnew") },
  { key = "?", cb = tree_cb("toggle_help") },

}

EOF
" }}}

" color settings {{{
  set background=dark
  colorscheme iceberg

  " colorize lsp diag messages
  highlight LspDiagnosticsDefaultError ctermfg=red guifg=red
  highlight LspDiagnosticsDefaultWarning ctermfg=yellow guifg=red
  highlight LspDiagnosticsDefaultInformation ctermfg=blue guifg=red
  highlight LspDiagnosticsDefaultHint ctermfg=grey guifg=red
" }}}

" utils {{{
  " automatically show diagnostics on cursor pos.
  " autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
  " autocmd CursorHold * :Lspsaga show_line_diagnostics
  " autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()

  " whitespace handling
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  " autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  " http://vim.wikia.com/wiki/Remove_unwanted_spaces
  function! StripTrailingWhitespace() abort
    if !&binary && &filetype != 'diff'
      let l:winview = winsaveview()
      silent! %s/\s\+$//e
      call winrestview(l:winview)
    endif
  endfunction

  " indent guides
  hi IndentGuidesOdd  ctermbg=black
  hi IndentGuidesEven ctermbg=darkgrey
  hi IndentGuidesOdd guibg=darkgrey ctermbg=234
  hi IndentGuidesEven guibg=darkgrey ctermbg=235

  " a list of groups can be found at `:help nvim_tree_highlight`
  highlight NvimTreeFolderIcon ctermfg=blue

  " strip on save
  augroup strip_on_save
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
  augroup end

  " augroup numbertoggle
  "   autocmd!
  "   autocmd BufEnter * set nu   rnu
  "   autocmd BufLeave * set nonu nornu
  "   " autocmd BufEnter,FocusGained,InsertLeave * set nu rnu
  "   " autocmd BufLeave,FocusLost,InsertEnter   * set nonu nornu
  " augroup END
" }}}

