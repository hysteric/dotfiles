"Ghislain's vimrc

set nocompatible                	" use vim defaults
set number                      	" show line numbers
set incsearch ignorecase hlsearch	" incremental searches
set ruler                       	" show ruler
set antialias                   	" antialias fonts (only in GUI)
set background=dark             	" set color scheme for dark backgrounds
" set cursorline                  	" highlight current line
set fsync                       	" force disk sync when saving
set showmatch                   	" show matching brackets
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P        " Status line format
set laststatus=2                	" always show status line
set tabstop=4                   	" tabs are 4 spaces wide
set shiftwidth=4                	" number of spaces for indentation
set visualbell                  	" use visual bell
set wrap                        	" wrap long lines
set title                       	" update terminal title
set ttyfast                     	" fast terminal
set whichwrap=b,s,h,l,<,>,[,]   	" moves span line wraps
set expandtab						" Replace tab with spaces
set autoindent
set wildchar=<Tab>					" Expand the command line using tab
set foldmethod=marker
set backspace=indent,eol,start
set mouse=a 						" Enable mouse
set showcmd
set completeopt=menuone,longest
set notitle

" Press space to clear search highlighting
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

filetype plugin indent on			" syntax based indenting
syntax on                       	" syntax highlighting

if has("autocmd")
	" Helpfiles
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

	" Vim files
	au FileType vim set omnifunc=vim

	" Shell files
	au FileType sh set omnifunc=sh
endif

if has('gui_running')
	set guioptions-=T  " no toolbar
endif

execute pathogen#infect()

" Keyboard mappings
map <F1> :help<CR>
map <F2> :NERDTreeToggle<CR>
map <F3> :previous<CR>
map <F4> :next<CR>
map <C-u> :source ~/.vimrc<CR>
imap <Tab> <C-P>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

let g:SuperTabDefaultCompletionType = ""
