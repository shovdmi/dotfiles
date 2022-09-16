" Reload vimrc
"so $MYVIMRC

" If you are editting vimrc do:
"so %
"source %

"--------------------------------------------

"termencoding utf8
"scripencoding utf-8
set encoding=utf-8
"// see http://nvie.com/posts/how-i-boosted-my-vim/
"//

set nocompatible " use vim defaults


set tags=tags

"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"source $VIMRUNTIME/colors/c.vim
"behave mswin
"--------------------------------------------
" Indent
set tabstop=2
set softtabstop=0
set shiftwidth=2
set smarttab
set smartindent

"--------------------------------------------
"Highlight search
set hlsearch

"--------------------------------------------
set incsearch  " do incremental searching
set showmatch  " jump to matches when entering regexp
set ignorecase " ignore case when searching

"Smart casesensetive search
set smartcase
	"/copyright      " Case insensitive
	"/Copyright      " Case sensitive
	"/copyright\C    " Case sensitive
	"/Copyright\c    " Case insensitive
	
	":help /\c :help /\C :help 'smartcase'


"--------------------------------------------
" Show matches list on Ctrl-] ( ^] )
set cscopetag
"http://vim.1045645.n5.nabble.com/Ctrl-choices-td1180671.html




set scrolloff=3     " keep 3 lines when scrolling
set ai              " set auto-indenting on for programming

set showcmd         " display incomplete commands
set nobackup        " do not keep a backup file
set number          " show line numbers
set relativenumber  " relative number
set ruler           " show the current row and column

" Height of the command bar
set cmdheight=2




" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2




" Accessing the system clipboard
set clipboard=unnamedplus
"set clipboard=unnamed
" Under Windows, the * and + registers are equivalent. For X11 systems, though, they differ. For X11 systems, * is the selection, and + is the cut buffer (like clipboard).

"To turn off autoindent when you paste code, there's a special "paste" mode.
set paste


set visualbell t_vb= " turn off error beep/flash
"set novisualbell    " turn off visual bell

set backspace=indent,eol,start " make that backspace key work the way it should

syntax on          " turn syntax highlighting on by default
filetype on        " detect type of file
filetype indent on " load indent file for specific file type

	
"--------------------------------------------
if has('gui_running') || has('nvim')
  set guioptions-=T  " no toolbar
  "colorscheme elflord
  set lines=60 columns=108 linespace=0
  if has('gui_win32') || has('gui_win64') || has('win32') || has('win64')
    "set guifont=DejaVu_Sans_Mono:h10:cANSI
    "GuiFont DejaVu Sans Mono:h10
    "set guifont=JetBrains\ Mono\ Thin
    set guifont=JetBrains\ Mono\ ExtraLight:h10
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif
endif
"--------------------------------------------

" http://vimcasts.org/episodes/show-invisibles/
" Use the same symbols as TextMate for tabstops and EOLs
" Dot symbols: • · ∙ ␣  ˷
" eols : § ↲ ¬ ⇰  ⇢
" tabs : → ¤ ▸ \u25b8 \<Char-0x25B8>
" trail: ☻ \u221 ★  ␠
" extends:⟩,precedes:⟨
"set invlist
set list
set showbreak=↪
if has('gui_running') || has('nvim')
	set listchars=tab:\¤\ ,trail:\☻,extends:#,nbsp:.
else
  "THIS works fine in tty console:
	set listchars=tab:\▸\ ,eol:\↵,trail:\∙,extends:#,nbsp:.
endif
"Invisible character colors
set t_Co=256
highlight NonText guifg=#0000af
"#080808 "#FaDaD9
highlight SpecialKey guifg=#0000af
 "#080808 "#FaDaD9
	"	this is an example  
 "  this is an another example 

set tabstop=2
" Adds one tab when indenting after {- bracket (при создании новой строки после { скобки, добавляет только один ТАВ
set softtabstop=1

set cursorline  "highlight current line

set nobackup
set noswapfile


" disable incrementation of octal numbers
set nrformats=hex

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

"--------------------------------------------
"--------------------------------------------
" Free yourself from Ex forever
nnoremap Q <nop>

" make K more consistent with J (J = join, K = split)
nnoremap K i<CR><Esc>k$

" use :W to sudo-write the current buffer
" command! W w !sudo tee "%" > /dev/null
command! W w !sudo dd of=%

map  <C-S> :write<CR>
imap <C-S> <C-O>:write<CR>
cmap <C-S> <C-C>:write<CR>

"paste on Ctrl+Shift+v
map <C-S-V> "+p
imap <C-S-V> <C-R>+

"-------C/C++ ------------------------------
nmap <F7> :w !gcc -o a.out % && ./a.out && read<ENTER><ENTER>
imap <F7> <ESC>:w !gcc -o a.out % && ./a.out && read<ENTER><ENTER>i

"--------------------------------------------
" vim-airline
set laststatus=2


"--------------------------------------------


" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

"----------------------------------------

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

