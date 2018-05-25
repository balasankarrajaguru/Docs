
if &term == "xterm" || &term == "ansi"
    set t_ti=7[r[?47h 
    set t_te=[?47l8
endif

if match($TERM, "screen")!=-1
  set term=xterm
endif

set showmode
set sw=4
set tags=$SRC_HOME/tags
set notitle

" Only do this part when compiled with support for autocommands.
if has("autocmd")
 if v:version > 600
   " Enable file type detection.
   " Use the default filetype settings, so that mail gets 'tw' set to 72,
   " 'cindent' is on in C files, etc.
   " Also load indent files, to automatically do language-dependent indenting.
 endif

 " For all text files set 'textwidth' to 78 characters.
 autocmd FileType text setlocal textwidth=78
 autocmd BufNewFile,BufRead *.txt setlocal textwidth=78
 autocmd BufNewFile,BufRead *.txt set et

 " DDL/ODL/errmsg files should follow c plugins
  autocmd BufNewFile,BufRead *.dd setf c
 autocmd BufNewFile,BufRead *.odl setf c
 autocmd BufNewFile,BufRead *.errmsg setf c
endif " has("autocmd")


" Ctrl+w opens a split window
" nmap <C-w> :sp

"Toggle show/hide of the Tlist window
map <leader>tt :TlistToggle<cr>

"Toggle line numbers on and off
map gn :set invnu<cr>

filetype plugin on
syntax enable
"Split windows vertically
map <leader>v <C-W>v
"horizantally
map <leader>s <C-W>s

"Move between windows
map <leader>w <C-W>w

nnoremap <silent> <F12> :Tlist<CR>

"Copied from Net 
set showmode
set sw=4
set tags=$SB/src/tags
set notitle
set nu
set nonumber
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set ignorecase      " ignore case when searching 
set title           " show title in console title bar
set ttyfast         " smoother changes
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files


set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif



set backspace=indent,eol,start
set showmatch
                                                                                                                                          

setlocal noautoindent
setlocal nocindent
setlocal nosmartindent
setlocal indentexpr=

"""""""""""""""""""""""""""""""""""""""""""""             

" All my files should have textwidth of 80
set textwidth=80

set sw=4

"
" Format code the Juniper way
"
set softtabstop=4
set shiftwidth=4
set tabstop=8
set ai
set cinoptions=(0
set textwidth=78
set paste
" source ~/cscope_maps.vim
set laststatus=2
"set statusline+=col:\ %c,\
"set rulerformat=%-14.(%l,%c%V%)\ %P
set rulerformat=%l,%v
"set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,bytval=0x%B,%n%Y%)\%P
set ruler

syntax on
colorscheme desert
hi Comment ctermfg=grey

" first, enable status line always
"set laststatus=2
nmap <F8> :TagbarToggle<CR>

" Fix keycodes
map ^[[1~ <Home>
map ^[[4~ <End>
imap ^[[1~ <Home>
imap ^[[4~ <End>

"set t_Co=256
"set background=dark
"colorscheme mustang
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE

"set insertmode


"http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


"JAPI FILES


" Protocol Buffers - Google's data interchange format
" Copyright 2008 Google Inc.  All rights reserved.
" https://developers.google.com/protocol-buffers/
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are
" met:
"
"     * Redistributions of source code must retain the above copyright
" notice, this list of conditions and the following disclaimer.
"     * Redistributions in binary form must reproduce the above
" copyright notice, this list of conditions and the following disclaimer
" in the documentation and/or other materials provided with the
" distribution.
"     * Neither the name of Google Inc. nor the names of its
" contributors may be used to endorse or promote products derived from
" this software without specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
" "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
" LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
" A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
" OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
" SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
" LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
" DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
" THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
" OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

" This is the Vim syntax file for Google Protocol Buffers.
"
" Usage:
"
" 1. cp proto.vim ~/.vim/syntax/
" 2. Add the following to ~/.vimrc:
"
" augroup filetype
"   au! BufRead,BufNewFile *.proto setfiletype proto
" augroup end
"
" Or just create a new file called ~/.vim/ftdetect/proto.vim with the
" previous lines on it.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

syn keyword pbTodo       contained TODO FIXME XXX
syn cluster pbCommentGrp contains=pbTodo

syn keyword pbSyntax     syntax import option
syn keyword pbStructure  package message group oneof
syn keyword pbRepeat     optional required repeated
syn keyword pbDefault    default
syn keyword pbExtend     extend extensions to max reserved
syn keyword pbRPC        service rpc returns

syn keyword pbType      int32 int64 uint32 uint64 sint32 sint64
syn keyword pbType      fixed32 fixed64 sfixed32 sfixed64
syn keyword pbType      float double bool string bytes
syn keyword pbTypedef   enum
syn keyword pbBool      true false

syn match   pbInt     /-\?\<\d\+\>/
syn match   pbInt     /\<0[xX]\x+\>/
syn match   pbFloat   /\<-\?\d*\(\.\d*\)\?/
syn region  pbComment start="\/\*" end="\*\/" contains=@pbCommentGrp
syn region  pbComment start="//" skip="\\$" end="$" keepend contains=@pbCommentGrp
syn region  pbString  start=/"/ skip=/\\./ end=/"/
syn region  pbString  start=/'/ skip=/\\./ end=/'/

if version >= 508 || !exists("did_proto_syn_inits")
  if version < 508
    let did_proto_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pbTodo         Todo

  HiLink pbSyntax       Include
  HiLink pbStructure    Structure
  HiLink pbRepeat       Repeat
  HiLink pbDefault      Keyword
  HiLink pbExtend       Keyword
  HiLink pbRPC          Keyword
  HiLink pbType         Type
  HiLink pbTypedef      Typedef
  HiLink pbBool         Boolean

  HiLink pbInt          Number
  HiLink pbFloat        Float
  HiLink pbComment      Comment
  HiLink pbString       String

  delcommand HiLink
endif

let b:current_syntax = "japi"


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
"let c_space_errors = 1
"let c_no_trail_space_error = 1
"set colorcolumn=100
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
