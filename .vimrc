" Load all plugins in ~/.vim/bundle
execute pathogen#infect()

set nocompatible

" Prevent hidden buffer instead of annoying warning messages
set hidden
	
" Colors
syntax on                       " Color syntaxing
colorscheme onedark             " Color scheme, torte

" Spaces and Tabs
set tabstop=2                   " Visual space per tab
set softtabstop=2               " Space per tab while editing
set shiftwidth=2                " Space added in INSERT mode
set noexpandtab                 " Tab are space
set autoindent

" UI
set number                      " Show line number
set cursorline                  " Highlight the current line

set list                        " Show invisible characters
set listchars=tab:▸\ ,eol:¬     " Replace the invisible characters with those

" Set colors for New Line and Tab character
hi NonText ctermfg=Black
hi SpecialKey ctermfg=Black

" Searching
set incsearch                   " Search as character are entered
set ignorecase                  " Ignore case sensitivity on searches

" Plugins
" --------------------------------------------------------------------------------
filetype plugin indent on

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor
	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Key map
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"

nnoremap <Leader>f :CtrlP<CR>

" Space + g = Search for the word under the cursor and show the QuickFix List
nnoremap <Leader>g :grep! "\b<cword>\b"<CR>:cw<CR>
" Auto close the QuickFix List when selecting an entry
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" Bad Habits Removal
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" Load a local .vimrc_local to allow local customization
try 
	source ~/.vimrc_local
catch
	" Nothing to see here
endtry 

