set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set inccommand=nosplit
set undodir=$HOME/.vim/local/undo.nvim/

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua"}, -- one of "all", or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}

require("nvim-treesitter.install").prefer_git = true
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua << EOF
require'lspconfig'.gopls.setup{}
EOF
