" Load all plugins in ~/.vim/bundle
execute pathogen#infect()

" It's not 1980 anymore, stop supporting VI
set nocompatible

" Prevent hidden buffer instead of annoying warning messages
set hidden
	
" Colors
syntax on                       " Color syntaxing
colorscheme onedark             " Color scheme, torte

" Spaces and Tabs
set tabstop=4                   " Visual space per tab
set softtabstop=4               " Space per tab while editing
set shiftwidth=4                " Space added in INSERT mode
set expandtab                   " Tab are space

set autoindent
"set smartindent

" UI
set title                       " Change the Terminal Title for the filename
set number                      " Show line number
set cursorline                  " Highlight the current line
set relativenumber              " Show relative line number from the current line

set list                        " Show invisible characters
set listchars=tab:▸\ ,eol:¬     " Replace the invisible characters with those

" Set colors for New Line and Tab character
hi NonText ctermfg=Black
hi SpecialKey ctermfg=Black

" Set colors for Folded block (Based on https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg)
hi Folded ctermfg=255 ctermbg=001

" Current Split status line
hi StatusLine ctermfg=255 ctermbg=001 cterm=NONE

" Searching
set incsearch                   " Search as character are entered
set ignorecase                  " Ignore case sensitivity on searches

" Search in subfolders (recursively)
set path+=**

" Display all matching files when we tab complete 
set wildmenu

" Show the current file in the status
set laststatus=2

" Show the column cursor
set cursorcolumn  
highlight CursorColumn guibg=lightblue ctermbg=236

" Folding based on indentation
set foldmethod=indent
set foldlevelstart=5

" Only display the cursorline in the active split window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
augroup END


" Commands
command! IP :call ShowPhpIP("O")
command! Ip :call ShowPhpIP("o")
command! Reload :so $MYVIMRC

" Plugins
" --------------------------------------------------------------------------------
filetype plugin indent on

" Key map
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"

" F2 = Toggle paste mode as formatted
" nnoremap <F2> :set paste!<CR>
set pastetoggle=<F2>


" F5 = Toggle visible characters/line numbers
nnoremap <F5> :set list!<CR> :set number!<CR> :set relativenumber!<CR>

" F4 = Duplicate the current line, and comment it
nnoremap <F4> yypI//<ESC>

nnoremap <F3> :normal I/*<ESC>A*/<ESC>

" Better SPLIT switching (Skip the W in the default way)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Focus on one split in another TAB
map <Leader>f :tabe %<CR>

" Bad Habits Removal
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

function! ShowPhpIP(position, ...)
  let ip = system('curl -s http://ipv4.myexternalip.com/raw | tr --delete "\n"')
  execute "normal! ".a:position."if( $_SERVER[\"REMOTE_ADDR\"] == \"".ip."\" ) {"
endfunction

" Always resize the splits when Vim is resized
autocmd VimResized * execute "normal! \<c-w>="

" Load a local .vimrc_local to allow local customization
try 
	source ~/.vimrc_local
catch
	" Nothing to see here
endtry 
