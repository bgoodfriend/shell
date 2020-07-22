set bg=dark
nmap <F12> :set invnumber<CR>
set tabstop=4
set shiftwidth=4
set expandtab
set paste

" PEP 8 compliant Python
set textwidth=79  " lines longer than 79 columns will be broken
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line

" autorun flake8 when exiting a *.py
" requires https://github.com/nvie/vim-flake8
autocmd BufWritePost *.py call Flake8()
