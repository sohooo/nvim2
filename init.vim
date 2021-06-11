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
  set numberwidth=5      " width of line numbers
  set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
  set fillchars=diff:⣿,vert:│
  " set showbreak=↪
  "
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
  nmap <silent> <leader>s :set spell!<CR>
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

  " remap escape; this rox
  imap jj <Esc>
  " Make line completion easier
  imap <C-l> <C-x><C-l>

  " keep the cursor in place while joining limes
  nnoremap J mzJ`z
  " keep search matches in the middle of the window.
  nnoremap n nzzzv
  nnoremap N Nzzzv
  " same when jumping around
  nnoremap g; g;zz
  nnoremap g, g,zz

  " remove current search highlighting
  nnoremap <space>l :noh<cr>

  " toggle paste mode on/off
  map <F9> :set paste!<cr>:set paste?<cr>
  " toggle line numbers
  map <F10> :set number!<cr>:set number?<cr>

  " display help with 'K'
  au BufReadPost *.rb set keywordprg=ri
  au BufReadPost *.pp set keywordprg=puppet\ describe

  " easy tab switching
  nmap tt :tabnext<cr>
  map  tt :tabnext<cr>
  nmap <C-t> :tabnew<cr>
  imap <C-t> <Esc>:tabnew<cr>

  " same indent behaviour in visual mode
  vmap > >gv
  vmap < <gv
  " make Y behave like other capitals
  map Y y$

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

  " Find files using Telescope command-line sugar.
	nnoremap <leader>f <cmd>Telescope find_files<cr>
	nnoremap <leader>g <cmd>Telescope git_files<cr>
  nnoremap <leader>s <cmd>Telescope live_grep<cr>
  nnoremap <leader>b <cmd>Telescope buffers<cr>
  nnoremap <leader>h <cmd>Telescope help_tags<cr>
  nnoremap <leader>t <cmd>TodoTelescope<cr>
  nnoremap <leader><space> <cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top<cr>
" }}}

" LSP setup {{{
	" Pictograms for lsp completion items
	" Plug 'onsails/lspkind-nvim'

	" Quickstart configurations for the Nvim LSP client
	Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim' "{{{
    nnoremap <silent>gh :Lspsaga lsp_finder<CR>
    nnoremap <silent>K :Lspsaga hover_doc<CR>
    nnoremap <silent>gr :Lspsaga rename<CR>
    nnoremap <silent>gd :Lspsaga preview_definition<CR>
    nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>

    nnoremap <silent><leader>ca :Lspsaga code_action<CR>
    vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
    nnoremap <silent>gs :Lspsaga signature_help<CR>
  "}}}
" }}}

" language {{{
  Plug 'sheerun/vim-polyglot'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
"}}}

" autocompletion, snippets {{{
	Plug 'rafamadriz/friendly-snippets'
	Plug 'hrsh7th/vim-vsnip' "{{{
		" bindings: ctrl-p|n to select; (s-)tab to jump
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
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Nvim Treesitter configurations and abstraction layer
  Plug 'JoosepAlviste/nvim-ts-context-commentstring' "Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
  Plug 'romgrk/nvim-treesitter-context' "Show code context
  Plug 'windwp/nvim-autopairs' "autopairs for neovim written by lua
  Plug 'tversteeg/registers.nvim' "NeoVim plugin to preview the contents of the registers
  Plug 'justinmk/vim-sneak' "The missing motion for Vim 👟
  Plug 'tpope/vim-surround' "quoting/parenthesizing made simple
  Plug 'tpope/vim-repeat' "enable repeating supported plugin maps with .
  Plug 'tpope/vim-endwise' "wisely add end in ruby, endfunction/endif/more in vim script, etc
  Plug 'tpope/vim-jdaddy' "JSON manipulation and pretty printing
  Plug 'tpope/vim-fugitive' "A Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-commentary' "comment stuff out
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
    nmap <leader>t :TroubleToggle<cr>
  "}}}
"}}}

" view, layout {{{
  Plug 'jeffkreeftmeijer/vim-numbertoggle' "Toggles between hybrid and absolute line numbers automatically
  Plug 'christoomey/vim-tmux-navigator' "Seamless navigation between tmux panes and vim splits

  Plug 'sindrets/diffview.nvim', { 'on': 'DiffviewOpen' } "{{{
    "Single tabpage interface to easily cycle through diffs for all modified files for any git rev.
    nnoremap <leader>c :DiffviewOpen<CR>
  "}}}

  Plug 'kyazdani42/nvim-tree.lua', { 'on': 'NvimTreeToggle' } "{{{
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
  Plug 'airblade/vim-gitgutter'
  " Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons' "lua fork of vim-web-devicons for neovim; no hook for nerdtree
  Plug 'p00f/nvim-ts-rainbow' "🌈 Rainbow parentheses for neovim using tree-sitter
  Plug 'kshenoy/vim-signature' "Plugin to toggle, display and navigate marks
  Plug 'folke/lsp-colors.nvim'

  Plug 'vim-airline/vim-airline' "{{{
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='iceberg'
    let g:airline_powerline_fonts=1
    if !exists('g:airline_powerline_fonts')
      " Use the default set of separators with a few customizations
      let g:airline_left_sep='›'  " Slightly fancier than '>'
      let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif
  "}}}

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

" disabled for now {{{
  " Plug 'dstein64/nvim-scrollview' "A Neovim plugin that displays interactive scrollbars.
  " Plug 'npxbr/glow.nvim' "A markdown preview directly in your neovim.
  " Plug 'nvim-telescope/telescope-project.nvim'
  " Plug 'fhill2/telescope-ultisnips.nvim'
  " Plug 'romgrk/barbar.nvim' "A neovim tabline plugin.
  " Plug 'kdheepak/lazygit.nvim' "Plugin for calling lazygit from within neovim.
  " Plug 'windwp/nvim-spectre' "Find the enemy and replace them with dark power.
  " Plug 'nacro90/numb.nvim' "Peek lines just when you intend
  " Plug 'kevinhwang91/nvim-hlslens' "Hlsearch Lens for Neovim
  " Plug 'chaoren/vim-wordmotion' "More useful word motions for Vim
  " Plug 'tpope/vim-abolish' "abolish.vim: easily search for, substitute, and abbreviate multiple variants of a word
  " Plug 'tpope/vim-capslock' "capslock.vim: Software caps lock
  " Plug 'airblade/vim-rooter' "Changes Vim working directory to project root.
  " Plug 'tpope/vim-dispatch' "Asynchronous build and test dispatcher
  " Plug 'karb94/neoscroll.nvim' "Smooth scrolling neovim plugin written in lua
  " Plug 'lambdalisue/suda.vim' "🥪 An alternative sudo.vim for Vim and Neovim, limited support sudo in Windows
  " Plug 'numtostr/FTerm.nvim' "🔥 No-nonsense floating terminal written in lua 🔥
  " Plug 'wfxr/minimap.vim' "📡 Blazing fast minimap / scrollbar for vim, powered by code-minimap written in Rust.
  " Plug 'ludovicchabant/vim-gutentags' "A Vim plugin that manages your tag files
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
" }}}

" disctraction-free writing {{{
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
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
  }
}

require('nvim-autopairs').setup()
require('todo-comments').setup {
  signs = true
}

require("trouble").setup {
  -- settings without a patched font or icons
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  icons = true, -- requires nvim-web-devicons
  signs = {
      -- icons / text used for a diagnostic
      error = "error",
      warning = "warn",
      hint = "hint",
      information = "info"
  },
  use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- ruby/solargraph
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#solargraph
require('lspconfig').solargraph.setup {
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

-- disable diagnostics
--vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
-- hide diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = false,
    signs = true,
  }
)

-- require('lspsaga').init_lsp_saga()
require('lspsaga').init_lsp_saga {
    -- override ugly vim.lsp arrow icon
    error_sign = '', -- 
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
}

EOF
" }}}

" color settings {{{
  set background=dark

  " conditionally set colorscheme
  if s:is_unix && !s:is_macvim
    if $TERM == 'xterm-256color'
      colorscheme iceberg
      " colorscheme hybrid
      " colorscheme hybrid_material
    else
      let g:CSApprox_verbose_level=0
      colorscheme slate
    endif
  else
    colorscheme iceberg
  endif

  " colorize lsp diag messages
  highlight LspDiagnosticsDefaultError ctermfg=red guifg=red
  highlight LspDiagnosticsDefaultWarning ctermfg=yellow guifg=red
  highlight LspDiagnosticsDefaultInformation ctermfg=blue guifg=red
  highlight LspDiagnosticsDefaultHint ctermfg=grey guifg=red
" }}}
"
  " autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
  " autocmd CursorHold * :Lspsaga show_line_diagnostics
  " autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()

" whitespace handling {{{
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  " autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  " ### http://vim.wikia.com/wiki/Remove_unwanted_spaces
  function! StripTrailingWhitespace() abort
    if !&binary && &filetype != 'diff'
      let l:winview = winsaveview()
      silent! %s/\s\+$//e
      call winrestview(l:winview)
    endif
  endfunction

  " #### Strip on save
  augroup strip_on_save
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
  augroup end
" }}}

" enjoy.
