"""""""""""" mappings
" Escape
imap jk <Esc>

" Redo
nnoremap R <C-R>

" move vertically by visual line (allows you to move past wrapped line)
nnoremap j gj
noremap k gk

" highlight last inserted text
nnoremap gV `[v`]

""""""""""""""""" copy/paste on mac
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-c> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>       "+gP
map <S-Insert>      "+gP

cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+

""""""""""""""""" search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highligh
nnoremap <leader><space> :nohlsearch<CR>
:set ignorecase smartcase " Vim will perform case-sensitive searches if the query contains uppercase letters; defaults to case-insensitive


"""""""""" formatting
set tabstop=2
set expandtab       " tabs are spaces
set shiftwidth=2    " > key is 2 spaces
set autoindent      " take indent from prior line
filetype plugin indent on      " load filetype-specific indent files

""""""""""""" visual
set number
set showmatch           " highlight matching [{()}]
syntax enable           " enable syntax processing
"set cursorline         " highlight current line

"""""""" Other useful things
" :help keycodes " Shows key maps
