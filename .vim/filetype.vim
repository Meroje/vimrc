if exists("did_load_filetypes")
  finish
endif

augroup ft_kubehelm
    autocmd!
    autocmd BufNewFile,BufRead $HOME/.kube/config,$HOME/.kube/*.config set ft=yaml
    autocmd BufNewFile,BufRead */templates/*.yaml,*/templates/*.tpl set ft=yaml.gotexttmpl
augroup END

" Python formatting
augroup ft_python
    autocmd!
    autocmd FileType python set cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufWritePre *.py :%s/\s\+$//e
    set foldmethod=indent
augroup END

" HTML formatting
augroup ft_html
    autocmd!
    autocmd FileType html set shiftwidth=2
    autocmd FileType html set softtabstop=2
augroup END

" Golang
augroup ft_golang
    autocmd!
    autocmd FileType go set shiftwidth=4
    autocmd FileType go set softtabstop=4
    autocmd FileType go set tabstop=4
augroup END

" Markdown formatting
augroup ft_markdown
    autocmd!
    autocmd Filetype markdown setlocal spell spelllang=en_us
augroup END

" Plain text formatting
augroup ft_text
    autocmd!
    autocmd Filetype text setlocal spell spelllang=en_us
augroup END

" YAML formatting
augroup ft_yaml
    autocmd!
    autocmd BufRead,BufNewFile *.yaml.gotmpl set filetype=yaml.gotexttmpl
    autocmd BufNewFile,BufRead *.yaml.example set filetype=yaml
    autocmd BufNewFile,BufRead *.yml set filetype=yaml
    autocmd FileType yaml set shiftwidth=2
    autocmd FileType yaml set softtabstop=2
augroup END

" JSON formatting
augroup ft_json
    autocmd!
    autocmd FileType json set shiftwidth=2
    autocmd FileType json set softtabstop=2
augroup END

augroup ft_jsx
    autocmd!
    autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" terraform
augroup ft_terraform
    autocmd!
    autocmd FileType terraform set shiftwidth=2
    autocmd FileType terraform set softtabstop=2
    autocmd Filetype terraform nmap <silent> <buffer> F :ALEFix<CR>:TerraformFmt<CR>
augroup END

" shell
augroup ft_shell
    autocmd!

    " For terraform shell templates
    autocmd BufRead,BufNewFile *.sh.tpl set filetype=sh

    " For ERB templates
    autocmd BufRead,BufNewFile *.sh.erb set filetype=sh

    " Should match shfmt in ale
    autocmd FileType sh set shiftwidth=2
    autocmd FileType sh set softtabstop=2
augroup END

" makefiles
augroup ft_makefile
    autocmd!
    autocmd FileType make set noexpandtab
    autocmd FileType make set tabstop=4
    autocmd FileType make set shiftwidth=4
augroup END

