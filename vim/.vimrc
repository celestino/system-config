" REQUIRED
" extra/vim-runtime 7.4.884-1
" community/vim-airline 0.7-2
" community/vim-nerdtree 4.2.0-4 (vim-plugins)
" community/vim-supertab 2.1-1 (vim-plugins)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme desert
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set nowrap "Dont Wrap lines
set number "enable line numbers
set hlsearch " highlight search terms
set incsearch " show search matches as you type
set cursorline " show highlighted cursor line

" set highlight cursor colors
hi CursorLine   cterm=NONE ctermbg=Black ctermfg=white
hi CursorColumn cterm=NONE ctermbg=Black ctermfg=white

" set tagbar selected item, and search items colors
hi Search ctermbg=Black ctermfg=White

" Enable mouse use in all modes
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

filetype plugin on "enablefile type plugin

" enable nerdtree on vim start
au vimenter * NERDTree

" colored statusline mode depending
au InsertEnter * hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=1

" display tabline on top
set showtabline=2

" display always the statusline
set statusline=2

" default the statusline to green when entering Vim
hi statuslin ctermfg=8 ctermbg=15

set statusline=%#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#
set statusline+=%#StatusLineNC#\ %t\ %#StatusLine#       "tail of the filename
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" set autocomple menu color
hi Pmenu ctermbg=DarkGrey ctermfg=White
hi PmenuSel ctermfg=Black ctermbg=White

" set phpcomplete as auto complete handler for php file types
au FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * :call DeleteTrailingWS()

" gitgutter settings
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 100
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '!+'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '--'
let g:gitgutter_sign_modified_removed = '!-'

" gitgutter colors
hi GitGutterAdd cterm=bold ctermfg=Green          " an added line
hi GitGutterChange cterm=bold ctermfg=Yellow       " a changed line
hi GitGutterDelete cterm=bold ctermfg=Red       " at least one removed line
hi GitGutterChangeDelete cterm=bold ctermfg=Magenta  " a changed line followed by at least one removed line
hi SignColumn ctermbg=107

" nerdtree tabs settings
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_focus_on_files = 1

" set default tabline colors
hi TabLineFill ctermfg=DarkGrey ctermbg=DarkGrey
hi TabLine ctermfg=Black ctermbg=White
hi TabLineSel ctermfg=White ctermbg=Red

" set directory and files colors
hi Title ctermfg=White ctermbg=none
hi Directory ctermfg=cyan ctermbg=none

" set matching paren signs color
hi MatchParen cterm=none ctermbg=Red ctermfg=White

" tagbar toggle map
nmap <F9> :TagbarToggle<CR>

" nerdtree toggle map
nmap <F8> :NERDTreeToggle<CR>

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_min_count = 0






