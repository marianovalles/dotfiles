" Mappings
"=========

" No arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

let mapleader="\\"

function! EnableHighlightAlign()
  echo virtcol('.')
  execute "set colorcolumn=+1," . virtcol('.')
endfunction

noremap <leader>p :echo expand('%:p')<cr>
nnoremap <leader>h :call EnableHighlightAlign()<cr>
"SimplyFold mapping
nnoremap <space> za
" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <leader>w :w<CR>
" Parse json file using python
map <leader>j  :%!python -m json.tool<CR>
map s :tabprev<CR>
map S :tabnext<CR>
" Open a new tab with content
map <leader>T :tabnew %<cr>
map <leader>B :Buffers<cr>
" Moving between splits
nnoremap <Backspace> <C-w>w
nnoremap <S-Backspace> <C-w>
nnoremap <leader>W <C-w>v<C-w>l
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
" Esc is a fast jk in insert mode
inoremap jk <Esc>
" Editing .vimrc with ease
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
