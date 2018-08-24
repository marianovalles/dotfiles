" Autoinstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins initialization start
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/indentpython.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"FZF mapping ftw!
map <leader>ff :Files<CR>
map <leader>fb :Buffers<CR>
map <leader>fa :Rg<Space>
map <C-F> :Rg<Space>
command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:50%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
" NERDTree on Ctrl-N
map <C-n> :NERDTreeFind<CR>

Plug 'davidhalter/jedi-vim', {'for': 'python'}
let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#completions_command = "<C-Space>"

Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
let g:neomake_open_list = 0
autocmd! BufWritePost * Neomake
let g:neomake_python_enabled_makers = ['flake8', 'python']


Plug 'janko-m/vim-test'
Plug '5long/pytest-vim-compiler'
noremap <leader>tn :TestNearest<CR>
noremap <leader>tf :TestFile<CR>
noremap <leader>tl :TestLast<CR>
" Use neovim strategy
"let test#strategy = "neovim"

Plug 'fisadev/vim-isort'
let g:vim_isort_python_version = 'python2'
Plug 'majutsushi/tagbar', {'for': 'python'}
Plug 'tmhedberg/SimpylFold'
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" ## Used in the past
" Plug 'kana/vim-textobj-user'
" Plug 'bps/vim-textobj-python'
"
" Plug 'elixir-lang/vim-elixir' -> elixir highlighting
" Plug 'oscarh/vimerl' -> erlang only
call plug#end()
