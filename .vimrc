" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
" https://github.com/junegunn/vim-plug {
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'   " Recent files start page
Plug 'tpope/vim-vinegar'    " Better netrw
Plug 'wincent/terminus'     " iTerm2 integration

Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'

" Nerdtree: file browser
Plug 'scrooloose/nerdtree'
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden =1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.pyc$', '\.git', '__pycache__']
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" Nerdcommenter: quick commenting
Plug 'scrooloose/nerdcommenter'
let NERDCreateDefaultMappings=0

Plug 'junegunn/fzf.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

Plug 'dense-analysis/ale'
Plug 'zplugin/zplugin-vim-syntax'
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['htmldjango']

Plug 'fatih/vim-go', { 'for': ['go'], 'do': ':GoInstallBinaries' }
let g:go_fmt_command = "goimports"
let g:go_highlight_string_spellcheck = 1
let g:go_updatetime = 1000
let g:go_term_mode = "split"
let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
"let g:go_fmt_experimental = 1
"let g:go_fmt_fail_silently = 1

Plug 'prettier/vim-prettier', {
\   'do': 'npm install',
\   'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown']
\}

" coc - autocomplete
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
let g:coc_config_home="$HOME/.vim"
"" Use tab to finish completion and go to next word
function! s:check_back_space() abort
  let char_before = col('.') - 1
  return !char_before || getline('.')[char_before - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
"" Navigate to the suggesetion before
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"" Enter suggestion
inoremap <expr> <Cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Cr>"
"" Close autocomplete dialog
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <silent><expr> <c-Tab> coc#refresh()

Plug 'mattn/webapi-vim'
Plug 'https://git.sr.ht/~willdurand/srht.vim'

if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'nvim-treesitter/playground'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'

  " dependencies
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'
endif

" Initialize plugin system
call plug#end()
" }

" General settings {
set timeoutlen=1000 ttimeoutlen=0 " Esc delay

set mouse       =a         " Mouse support

set autoindent             " Indent according to previous line.
set smartindent
set expandtab              " Use spaces instead of tabs.
set tabstop     =4         " Tab character is 4 spaces wide.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set gdefault               " the /g flag on :s substitutions by default

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set title                  " change the terminal's title
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set showmatch              " Show matching parenthesis
set smartcase              " ignore case if all lowercase

" Folding
set foldenable             " auto fold code
set foldnestmax=1
set foldmethod=syntax
set foldlevel=10

set wildmenu               " Enhanced completions
set wildmode    =list:full

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

set autowrite              " Save file when running :make

set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
set colorcolumn =80,120    " Colored vertical line
set number                 " Line number for current line
set relativenumber         " Relative to current line
set ruler                  " always show current position

" Set color for regular vim
if !has('nvim')
    set term=xterm-256color
endif
scriptencoding utf-8
set encoding=utf-8
set t_Co=256
set termencoding=utf-8
set viewoptions=cursor,curdir,folds " limit what views save

"" save folds
augroup save_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END
" }

" Theme {
set termguicolors          " 24 bit colors
set background  =dark
augroup MyTheme
    autocmd!
    autocmd ColorScheme gruvbox let g:airline_theme ='gruvbox'
augroup END
if index(getcompletion('', 'color'), 'gruvbox') >= 0
    colorscheme gruvbox
endif
" }

" Pretty symbols {
set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif
" }

" Put all temporary files under the same directory. {
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupext   =-vimbackup
set backupskip  =
set updatecount =100
set undofile
set backupdir   =$HOME/.vim/local/backup/
set directory   =$HOME/.vim/local/swap/
set undodir     =$HOME/.vim/local/undo/
set viewdir     =$HOME/.vim/local/view/
if !has('nvim')
  set viminfo     ='100,n$HOME/.vim/local/info/viminfo
endif
" }

" ripgrep replacement for :grep {
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
set grepprg=rg\ --vimgrep
" }

" ALE (Asynchronous Lint Engine) {
let g:ale_completion_enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:ale_sh_shfmt_options = '-s -i 2 -ci'

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'go':         ['gofmt', 'goimports'],
\   'php':        ['php_cs_fixer'],
\   'json':       ['jq'],
\   'jsx':        ['stylelint', 'eslint'],
\   'terraform':  ['tflint', 'terraform_lsp'],
\   'dockerfile': ['hadolint'],
\   'sh':         ['shfmt', 'shellcheck'],
\   'markdown':   ['alex', 'mdl', 'vale'],
\   'python':     ['black'],
\   '*':          ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linter_aliases = {
\   'jsx': 'css'
\}
" }

" GitGutter
let g:gitgutter_grep_command = 'rg'

" Better line joining (J), removes comment markers
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" YCM (You Complete Me) {
augroup load_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('YouCompleteMe')
                     \| autocmd! load_ycm
augroup END
" }

let g:terraform_fmt_on_save=1
let g:vim_json_syntax_conceal = 0

"" Keymappings {
let mapleader=","

"" Clear highlighting
map <silent><F12> :source $MYVIMRC<CR>
"" Browse
map <silent> - :NERDTreeToggle<CR>
"" Comment out a line or block
nmap # <Plug>NERDCommenterToggle
xmap # <Plug>NERDCommenterToggle

" Golang
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-imports)<Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap @ <Plug>(go-def)
"au FileType go map <silent><F9> :write<CR>:GoImports<CR>:GoTest<CR>
au FileType go nmap <silent>! :w<CR>:split <bar> terminal go run %<CR>
"}

"" Custom Buf macros {
au BufNewFile,BufRead *.yml.j2,*.yaml.j2 setf yaml.ansible
au BufNewFile,BufRead *.tmpl.j2 setf gotexttmpl
"}

" Use local vimrc if available {
if filereadable(expand("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
" }
