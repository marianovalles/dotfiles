" @Author: Mariano Vallés (zucaritas(at)gmail.com)
" Some other from wmalik@gmail.com .vimrc
" Some stuff comes from hukl/dotfile

" Pathogen stuff
runtime bundle/vim-pathogen/autoload/pathogen.vim
exec pathogen#infect()
exec pathogen#helptags()

" Essentials
syntax on
" Use Vim defaults instead of 100% vi compatibility
set nocompatible
" No folding
set nofoldenable
" Shows $ when in cw
set cpoptions+=$
set number
" Two spaces as identation
set tabstop=2
" Spaces as tab
set expandtab

set softtabstop=2
" Number of spaces as tab
set shiftwidth=2
" Get autoindent on <cr>, 'o' and 'O'
set autoindent
" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·


" Enable loading plugin files for specific filetypes
filetype plugin on
" Load identation files (if any) for a filetype
filetype indent on

" hukl file config {
" make uses real tabs
au FileType make set noexpandtab

" Erlang uses 4 spaces (not used now)
" au FileType erlang set softtabstop=4 tabstop=4 shiftwidth=4

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()
"
"}

" Directories for swp files
set backupdir=~/.vimbackup
set directory=~/.vimbackup

" Use source code (TODO: Install 'Source Code Pro' automagically)
set guifont=Source\ Code\ Pro\ SemiBold:h18
" Set leader to ,
let mapleader=","
" Enhance command-line completion
set wildmenu
" Show all matches and complete till longest common
set wildmode=list:longest
" No sounds please
set vb t_vb=".
" Highlight the screen with the cursor
set cursorline
" Improve redrawing
set ttyfast
" Show current line & column of the cursor
set ruler
" Allow backspacing over [indent, eol, start]
set backspace=indent,eol,start
" Always have a status line on last window
set laststatus=2
" No wrapping on long lines
set nowrap
" One column to scroll horizontal
set sidescroll=1
" Break lines at 80 chars
set textwidth=80

"this is to store all sw* files in /tmp
set directory=/tmp
" Ignore cases in patterns
set ignorecase
" When pattern has uppercase ignore ignorecase
set smartcase
" Jump to matching bracket when inserting first
set showmatch
" Colorize column 80
set colorcolumn=80


colorscheme Tomorrow-Night

" For disabling the macvim toolbar
if has("gui_running")
    set mouse=a
    set guioptions=egmrt
    set guioptions-=m
endif

" Search incrementally and highlight
set incsearch
set hlsearch
" Ignore some common files
set wildignore=*.o,*~,*.beam,*.swf,*.mp3,*.jpg,*.png,*ebin
if filereadable(".vimrc.project")
    so .vimrc.project
endif


" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
" ctrlp custom ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.eunit$',
  \ 'file': '\.exe$\|\.so$\|\.dll\|\.beam$\|\.DS_Store$'
  \ }

" Map Ctrl+l to clear highlighted searches
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Highlight characters behind the 80 chars margin
:au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)



" From http://vimcasts.org/episodes/tidying-whitespace/
" Preserves/Saves the state, executes a command, and returns to the saved state
" Modified from http://vimbits.com/bits/231
" Remove trailing whitespace on save
function! Preserve(command)
    " Save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" Execute clear whitespace on save
autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
" Nerdtree toggle, dah!?
map <C-n> :NERDTreeToggle<CR>
" Open a new tab with content
map <leader>t :tabnew %<cr>


" Moving between splits
nnoremap <Backspace> <C-w>w
nnoremap <S-Backspace> <C-w>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W

" Esc is a fast jk in insert mode
inoremap jk <Esc>
" Editing .vimrc with ease
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
