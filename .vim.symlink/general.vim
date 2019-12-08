let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" ## General settings
filetype plugin indent on
" Use Vim defaults instead of 100% vi compatibility
set nocompatible
" Use one single pastebuffer in Shell and OS
set cb=unnamedplus
syntax on
set ff=unix

" Shows $ when in cw
set cpoptions+=$
set number
set autoindent
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=250
set cursorline
" Directories for swp files
set directory=~/.vimbackup
" Enhance command-line completion
set wildmenu
" Show all matches and complete till longest common
set wildmode=longest:full,full
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
" Enough mem, no swapping
set noswapfile
" Search incrementally and highlight
set incsearch
set hlsearch
" Ignore some common files
set wildignore=*.o,*~,*.beam,*.swf,*.mp3,*.jpg,*.png,*ebin,*.git

" Autocommands
"==============
autocmd BufEnter,FocusGained * checktime
au BufNewFile,BufRead *.json set ft=javascript

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
"   " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Execute clear whitespace on save
au BufWritePre Gemfile,Rakefile,*.{py,scala,ex,exs,java,js,rb,ru,html,erl,erb} :call Preserve("%s/\\s\\+$//e")
"Gitcommit message max 72 chars
au Filetype gitcommit setlocal spell textwidth=72

" Highlight trailing whitespaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
