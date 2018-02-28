" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
" https://github.com/junegunn/vim-plug {
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'

Plug 'vim-airline/vim-airline'
  Plug 'morhetz/gruvbox'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe', { 'on': [], 'do': './install.py' }
Plug '/usr/local/opt/fzf', { 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

Plug 'sheerun/vim-polyglot'

Plug 'fatih/vim-go', { 'for': ['go'] }

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }

" Initialize plugin system
call plug#end()

augroup load_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('YouCompleteMe')
                     \| autocmd! load_ycm
augroup END
" }

" General settings {
set timeoutlen=1000 ttimeoutlen=0 " Esc delay

set mouse       =a         " Mouse support

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set tabstop     =4         " Tab character is 4 spaces wide.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set gdefault               " the /g flag on :s substitutions by default

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set foldenable             " auto fold code

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set number                 " Line number for current line
set relativenumber         " Relative to current line
" }

" Theme {
set background  =dark
colorscheme gruvbox
let g:airline_theme ='gruvbox'
let g:airline_powerline_fonts =1
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
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap/
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
" }

" Fix cursor shape in insert mode {
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif
" }

" ripgrep replacement for :grep {
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
set grepprg=rg\ --vimgrep
" }

" Syntastic {
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }
" ALE (async syntastic) {
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:airline#extensions#ale#enabled = 1

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_linter_aliases = {'jsx': 'css'}
" }

" GitGutter
let g:gitgutter_grep_command = 'rg'

" Better line joining (J)
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" Use local vimrc if available {
if filereadable(expand("\~/.vimrc.local"))
  source \~/.vimrc.local
endif
" }
