call plug#begin('~/.vim/plugged')
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'w0ng/vim-hybrid'
Plug 'Yggdroot/indentLine'
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic', { 'for': 'ruby' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'leafgarland/typescript-vim'
call plug#end()

set t_Co=256
colorscheme hybrid
highlight CursorLineNr ctermfg=grey

syntax on
set number
set cursorline

inoremap <silent> jj <ESC>

" performance
set synmaxcol=200

" ctags
set tags+=.git/tags
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

" tab
set expandtab
set tabstop=2
set shiftwidth=2

" backspace
set backspace=indent,eol,start

" copy yanked text to clipboard
set clipboard+=unnamed

" indentLine
let g:indentLine_color_term = 239
let g:indentLine_char = '¦' "use ¦, ┆ or │

" mouse
"set mouse=a

"easymotion
"let g:EasyMotion_leader_key = ';'
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf;'
nmap <Space> <Plug>(easymotion-s2)

"syntastic
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_ruby_checkers = ['rubocop']
