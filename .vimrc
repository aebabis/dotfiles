" SETTINGS
let g:mapleader=' '
let g:maplocalleader='\\'

set expandtab   " tabs to spaces
set tabstop=2
set shiftwidth=2

set splitright  " splits appear to the right
set splitbelow  " or below


" KEYMAPPINGS
" Fast window switching
nmap <C-h>  <C-w>h
nmap <C-j>  <C-w>j
nmap <C-k>  <C-w>k
nmap <C-l>  <C-w>l

tnoremap      <ESC>  <C-\><C-n>
tmap <silent> <C-h>  <ESC><C-w>h
tmap <silent> <C-j>  <ESC><C-w>j
tmap <silent> <C-k>  <ESC><C-w>k
tmap <silent> <C-l>  <ESC><C-w>l

" Fast window spliting
nnoremap <silent> <C-v>  :vnew<CR>
nnoremap <silent> <C-d>  :new<CR>

" ADDITIONAL FILETYPE RECOGNITION
au BufReadPost *.tmux.conf set syntax=tmux

