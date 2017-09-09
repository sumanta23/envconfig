
" Auto reload
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
 " alternatively, pass a path where Vundle should install plugins
 "call vundle#begin('~/some/path/here')

 " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'
 Plugin 'tpope/vim-fugitive'
 Plugin 'davidhalter/jedi-vim'
 Plugin 'ctrlpvim/ctrlp.vim'
 Plugin 'tacahiroy/ctrlp-funky'
 Plugin 'scrooloose/syntastic'
 Plugin 'ervandew/supertab'
 Plugin 'godlygeek/tabular'
 Plugin 'altercation/vim-colors-solarized'
 Plugin 'bling/vim-airline'
 Plugin 'vim-airline/vim-airline-themes'
 Plugin 'anyakichi/vim-surround'
 Plugin 'majutsushi/tagbar'
 Plugin 'airblade/vim-gitgutter'
 Plugin 'bling/vim-bufferline'
 Plugin 'mileszs/ack.vim'
 Plugin 'MarcWeber/vim-addon-mw-utils'
 Plugin 'tomtom/tlib_vim'
 Plugin 'garbas/vim-snipmate'
 Plugin 'scrooloose/nerdcommenter'
 Plugin 'scrooloose/nerdTree'
 Plugin 'Yggdroot/indentLine'
 "Plugin 'kana/vim-smartinput'
 Plugin 'pangloss/vim-javascript'
 Plugin 'sjl/badwolf'
 Plugin 'jmcantrell/vim-virtualenv'

 Plugin 'artur-shaik/vim-javacomplete2'
 Plugin 'amix/open_file_under_cursor.vim'
 
 " Optional:
 Plugin 'honza/vim-snippets'

 " The following are examples of different formats supported.
 " Keep Plugin commands between vundle#begin/end.
 " plugin on GitHub repo
 "Plugin 'tpope/vim-fugitive'
 " plugin from http://vim-scripts.org/vim/scripts.html
 "Plugin 'L9'
 " Git plugin not hosted on GitHub
 "Plugin 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (i.e. when working on your own plugin)
 "Plugin 'file:///home/gmarik/path/to/plugin'
 " The sparkup vim script is in a subdirectory of this repo called vim.
 " Pass the path to set the runtimepath properly.
 "Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
 " Avoid a name conflict with L9
 "Plugin 'user/L9', {'name': 'newL9'}







 " All of your Plugins must be added before the following line
 call vundle#end()            " required


"
"java autocomplete does now work properly :)
"==================================================
autocmd FileType java setlocal omnifunc=javacomplete#Complete

"To enable smart (trying to guess import option) inserting class imports with F4, add:

nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)

imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

"To enable usual (will ask for import option) inserting class imports with F5, add:

nmap <F5> <Plug>(JavaComplete-Imports-Add)

imap <F5> <Plug>(JavaComplete-Imports-Add)

"To add all missing imports with F6:

nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)

imap <F6> <Plug>(JavaComplete-Imports-AddMissing)

"To remove all unused imports with F7:

nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)






"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on
filetype plugin indent on
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace


" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class,*.so,*.swp,*.zip

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

"dont show fooking tab bar on top
set showtabline=0

" vim folding settings
set foldenable
set foldmethod=indent
set foldnestmax=2
set foldlevel=1
set nofoldenable


" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set number
set relativenumber

" set intitially but prefer the default behaviour now
"colorscheme desert
"colorscheme badwolf
"let g:badwolf_darkgutter = 1
"set background=dark

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines



" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile



" Set to auto read when a file is changed from the outside
set autoread

"change swap file location
set directory=~/.vim/.vimtemp/swaps//
set backupdir=~/.vim/.vimtemp/backups//
set udf
set udir=~/.vim/.vimtemp/undo//

"change .viminfo file location"
set viminfo+=n~/.vim/.viminfo

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set guioptions-=m  "remove menu bar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif


"vim grep settings using silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"configure airline
set noshowmode
set cursorline
set laststatus=2
set ttimeoutlen=50
let g:airline_theme='badwolf'
let g:airline_section_b=""
let g:airline_section_warning=""
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#csv#enabled = 0
let g:airline#extensions#tabline#enabled = 0  "doesnt work
let g:airline_left_sep='›'  " Slightly fancier than '>'
let g:airline_right_sep='‹' " Slightly fancier than '<'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Fast quit
nmap <leader>q :q!<cr>
" Fast quit buffer
nmap <leader>x :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>



 " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>



" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.java :call DeleteTrailingWS()


" map toggle fold to zz
map zz za


" map ; to : save shift
nnoremap ; :


" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" command to switch buffers
nnoremap <leader>[   :bp<CR>
nnoremap <leader>]   :bn<CR>
inoremap <leader>[   <Esc>:bp<CR>i
inoremap <leader>]   <Esc>:bn<CR>i

" switch buffers back and forth
map <C-k> :bn<CR>
map <C-j> :bp<CR>


" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" splitting window
map <C-\> <C-W>s
map <C-_> <C-W>v


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>o :edit <c-r>=expand("%:p:h")<cr>/



" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
"set viminfo^=%




" cut copy paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa


" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>



" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()


" NERDTree conf"

map <C-n> :NERDTreeToggle<CR>
map <Leader>r :NERDTreeFind<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']


"configure ctrlp-funky.vim
nnoremap <leader>p :CtrlPFunky<Cr>
nnoremap <leader>f :CtrlPFunkyMulti<CR>

"configure ctrlp.vim
nnoremap <leader>m :CtrlPMixed<CR>


let g:ctrlp_max_files=0
let g:ctrlp_max_height = 15
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_user_command = 'find %s -type f' 

"ignore node_modules and git and unittests and Client
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|bin|dist|git|build|unittests)|(\.(swp|ico|git|svn))$'


"open gblame
nnoremap <leader>b :Gblame<CR>


"configure Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nnoremap <Leader>a :Tabularize /
vnoremap <Leader>a :Tabularize /

"added path find use :find filename
set path+=**


"configure Ctags
set tags=./tags;/,~/.vimtags

" type g<C-]> to get list  and C-t to come back
nnoremap <C-]> g<C-]>

"configure tagbar
nmap <F8>  :Tagbar<CR>

if has('gui_running')
    set guioptions-=T
    set background=dark
    colorscheme solarized
endif



" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" bind K to grep word under cursor

nnoremap <Leader>g :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
"nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
"vnoremap K y:Ack! "<C-R>""<CR>


" quickfix settings
augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END
