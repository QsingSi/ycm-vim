syntax on
set smartindent
set number
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
colorschem monokai

set nocompatible              " be iMproved, required

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Chiel92/vim-autoformat'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'kien/rainbow_parentheses.vim'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"Plugin 'davidhalter/jedi-vim'
"Plugin 'ervandew/supertab'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:ycm_global_ycm_extra_conf = '/root/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_python_binary_path = '/usr/bin/python3'
" let g:ycm_server_log_level = 'info'
let g:ycm_cache_omnifunc = 0
let g:ycm_confirm_extra_conf= 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_semantic_triggers = {
            \ 'java': ['.']
            \}
set completeopt-=preview
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_semantic_triggers =  {
            \ 'java': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }

nnoremap <F3> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0


let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" 不加入这行, 防止黑色括号出现, 很难识别
" \ ['black',       'SeaGreen3'],
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
  return "\<Right>"
 else
  return a:char
 endif
endf
    
function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
  return "\<CR>}"
 else
  return "\<Esc>j0f}a"
 endif
endf
          
function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
  return a:char
 elseif line[col - 1] == a:char
  return "\<Right>"
 else
  return a:char.a:char."\<Esc>i"
 endif
endf
