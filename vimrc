
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

"code snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

"Plugin 'kana/vim-smartinput'

"vim editor beautify
Plugin 'bling/vim-bufferline'

"code navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'amix/open_file_under_cursor.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdTree'
Plugin 'majutsushi/tagbar'

"code editing
Plugin 'scrooloose/nerdcommenter'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'anyakichi/vim-surround'

"repository plugin
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"python
Plugin 'davidhalter/jedi-vim'
Plugin 'jmcantrell/vim-virtualenv'

"java
"Plugin 'artur-shaik/vim-javacomplete2'

"javascript
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'



" All of your Plugins must be added before the following line
call vundle#end()            " required



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

syntax on

" Enable filetype plugins
filetype plugin on
filetype indent on
filetype plugin indent on
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" system clipboard.
set clipboard=unnamed
set clipboard=unnamedplus
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class,*.so,*.swp,*.zip

"Always show current position
set ruler

" Height of the command bar
set showcmd
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
hi Search cterm=NONE ctermfg=RED ctermbg=NONE
hi Error cterm=NONE ctermfg=BLUE ctermbg=NONE
hi Folded cterm=NONE ctermfg=YELLOW ctermbg=NONE

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

set showmode

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

"dont show fooking tab bar on top
set showtabline=0

" vim folding settings
set foldenable
set foldmethod=indent
set foldnestmax=5
set foldlevel=10
set foldlevelstart=5
set nofoldenable


" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set number
set relativenumber

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

"added path find use :find filename
set path+=$PWD/**                      " Search recursively for file related tasks


" Set to auto read when a file is changed from the outside
set autoread

"change swap file location
set directory=~/.vim/.vimtemp/swaps//
set backupdir=~/.vim/.vimtemp/backups//
set udf
set udir=~/.vim/.vimtemp/undo//

"change .viminfo file location"
set viminfo+=n~/.vim/.viminfo

let g:ackprg = 'ag --nogroup --nocolor --column'

" quickfix settings
augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END

" Wrap the quickfix window
autocmd FileType qf setlocal wrap linebreak


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
set noshowmode
set cursorline
set ttimeoutlen=50


" Statusline

let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'VISUAL ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'INSERT ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=GREEN'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=003'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004'
  else
    exe 'hi! StatusLine ctermfg=001'
  endif

  return ''
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return 'RO'
  else
    return ''
endfunction


set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%3*\ [%n]                                " buffernr
set statusline+=%3*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
set statusline+=%*
set statusline+=%4*\ %=                                  " Space
set statusline+=%0*\ %y\                                 " FileType
set statusline+=%0*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%0*\ %3p%%\ \ %l\ :%3c\                 " Rownumber/total (%)

hi User1 ctermfg=007
hi User2 ctermfg=008 ctermbg=234
hi User3 ctermfg=YELLOW ctermbg=234
hi User4 ctermfg=007 ctermbg=234






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
"=> infect pathogen
""""""""""""""""""""""""""""""""""""""""""

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()




""""""""""""""""""""""""""""""""""""""""""""""""""""
"===> java autocomplete does now work properly :)
""""""""""""""""""""""""""""""""""""""""""""""""""""
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
map <leader>cb :1,1000 bd!<cr>

set timeoutlen=3000

 " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>



" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <g-j> mz:m+<cr>`z
nmap <g-k> mz:m-2<cr>`z
vmap <g-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <g-k> :m'<-2<cr>`>my`<mzgv`yo`z


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

nnoremap <Leader>ss V :FixWhitespace<CR>
vnoremap <Leader>ss :FixWhitespace<CR>
inoremap <Leader>ss <ESC>V :FixWhitespace<CR>i

map <Leader>ws :call DeleteTrailingWS()<CR>

"autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()
"autocmd BufWrite *.js :call StripTrailingWhitespace()
"autocmd BufWrite *.java :call DeleteTrailingWS()


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


" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" command to switch buffers
nnoremap <leader>[   :bp<CR>
nnoremap <leader>]   :bn<CR>
inoremap <leader>[   <Esc>:bp<CR>i
inoremap <leader>]   <Esc>:bn<CR>i

" switch buffers back and forth
map <leader>k :bn<CR>
map <leader>j :bp<CR>


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" splitting window
map <C-\> <C-W>v
map <C-_> <C-W>s


" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  "set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
"set viminfo^=%



" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
map <leader>cc :botright cope<cr>



" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>cm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"configure syntastics
let g:syntastic_enable_highlighting=0
let g:syntastic_enable_signs=1


" NERDTree conf"
map <C-n> :NERDTreeToggle<CR>
map <Leader>r :NERDTreeFind<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']



"configure ctrlp.vim
nnoremap <leader>m :CtrlPMixed<CR>

let g:ctrlp_max_files=0
let g:ctrlp_max_height = 25
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore', 'package.json']
"let g:ctrlp_user_command = 'find %s -type f' 
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|bin|dist|git|build|unittests)|(\.(swp|ico|git|svn))$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip


"open gblame
nnoremap <leader>gb :Gblame<CR>
map <leader>b :ls<CR>

"configure Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nnoremap <Leader>a :Tabularize /
vnoremap <Leader>a :Tabularize /

"configure macro
map <Leader>@ :'<,'>norm! @

"configure Ctags
set tags=./tags;/,~/.vimtags

" type g<C-]> to get list  and C-t to come back
nnoremap <C-]> g<C-]>

"configure tagbar
nmap <F8>  :Tagbar<CR>


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" binding to grep word under cursor
nnoremap <Leader>g :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

" random leader settings
nnoremap <Leader>vim :e ~/.vimrc<CR>
nnoremap <Leader>sh :e ~/.bash_aliases<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>ec :e ~/code/
