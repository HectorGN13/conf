execute pathogen#infect()
syntax on
filetype plugin indent on

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set t_Co=256

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_degrade=1
let g:solarized_contrast="high"
let g:solarized_visibility="low"
set background=dark
colorscheme solarized
" highlight Normal ctermbg=NONE guibg=Black
" highlight NonText ctermbg=NONE guibg=Black
" highlight ExtraWhiteSpace ctermbg=16 guibg=Black
" highlight rubyDefine ctermbg=NONE guibg=Black
" autocmd BufWinEnter * match ExtraWhiteSpace /\t/
set guifont=Liberation\ Mono\ for\ Powerline\ 13

set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8
set showcmd                     " display incomplete commands

" Whitespace
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)

" Joining lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j          " Delete comment char when joining commented lines
endif
set nojoinspaces                " Use only 1 space after "." when joining lines, not 2

" Indicator chars
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪
set list

" Avoid showing trailing whitespace when in insert mode
autocmd InsertEnter * :set listchars-=trail:•
autocmd InsertLeave * :set listchars+=trail:•

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set wrap
set wrapmargin=2
set textwidth=80
set colorcolumn=80
set autoindent
set smartindent
set smarttab

" Desactivo estas opciones por cuestiones de eficiencia:
" set relativenumber

set number
set cursorline
set scrolloff=3

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python setl softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" Treat JSON files like JavaScript
autocmd BufNewFile,BufRead *.json setf javascript

" Some file types use real tabs
autocmd FileType {make,gitconfig} set noexpandtab

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" toggle the current fold
nnoremap <Space> za

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" NOTICE: Really useful!

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Some useful keys for vimgrep
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Bash like keys for the command line
cnoremap <C-A>        <Home>
cnoremap <C-E>        <End>
cnoremap <C-K>        <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
"nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap tx  :tabclose<CR>
" Alternatively use
"nnoremap th :tabnext<CR>
"nnoremap tl :tabprev<CR>
nnoremap tn :tabnew<CR>

" Navigation using Alt-num on console
nnoremap <Esc>1 1gt
nnoremap <Esc>2 2gt
nnoremap <Esc>3 3gt
nnoremap <Esc>4 4gt
nnoremap <Esc>5 5gt
nnoremap <Esc>6 6gt
nnoremap <Esc>7 7gt
nnoremap <Esc>8 8gt
nnoremap <Esc>9 9gt
nnoremap <Esc>0 10gt

" Navigation using Alt-num on GUI
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt

let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<Down>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<c-tab>', '<Up>', '<C-k>']
" let g:SuperTabDefaultCompletionType = '<C-n>'
" let g:SuperTabCrMapping = 1

" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets = "<c-l>"

" Open TagBar
nmap <F8> :TagbarToggle<CR>

