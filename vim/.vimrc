" VUNDLE



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
"  Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"  Plugin 'L9'
" Git plugin not hosted on GitHub
"  Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"  Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"  Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"  Plugin 'ascenator/L9', {'name': 'newL9'}

"##################################################
" Plugins
"##################################################
Plugin 'arrufat/vala.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'lervag/vimtex'
Plugin 'nickhutchinson/vim-cmake-syntax'
Plugin 'tikhomirov/vim-glsl'
Plugin 'beyondmarc/opengl.vim'
Plugin 'Eraden/glfw.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mkitt/tabline.vim'
Plugin 'dpelle/vim-LanguageTool'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'majutsushi/tagbar'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'godlygeek/tabular'
Plugin 'altercation/vim-colors-solarized'
Plugin 'junegunn/goyo.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" END OF VUNDLE

" Auto start
" au VimEnter * NERDTree

"**************************************************
" PREFERENCES
"**************************************************
set completeopt-=preview
set encoding=utf-8
set number
set relativenumber
" set wrap
set textwidth=80
set tabstop=4 shiftwidth=4 expandtab
set autoindent
set nofoldenable
set colorcolumn=81
set cursorline
set backspace=indent,eol,start
set hlsearch
syntax on
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:tex_conceal = ""
au BufNewFile,BufRead *.html set filetype=htmldjango
au BufNewFile,BufRead *.tex  set nowrap
au BufNewFile,BufRead *.tex  set noautoindent
au BufNewFile,BufRead *.tex  set nosmartindent
:colorscheme tokyo-metro
":highlight ErrorMsg ctermfg=5* ctermbg=1
":highlight YcmWarningSection ctermfg=1* ctermbg=3*
":highlight YcmErrorSection ctermfg=6* ctermbg=1*

"**************************************************
" KEY MAPPINGS
"**************************************************

inoremap <A-r> <Esc>

" Scroll faster

" Remap
nnoremap <PageUp>   k;
nnoremap <PageDown> j;

" Normal mode
nnoremap <S-j>      10j
nnoremap <S-k>      10k
vnoremap <S-Down>   10j
nnoremap <S-Up>     10k

" Visual mode
vnoremap <S-j>      10j
vnoremap <S-k>      10k
vnoremap <S-Down>   10j
vnoremap <S-Up>     10k

" NERDTree
nnoremap <C-n>   :NERDTree<CR>

"Tab navigation"
" nnoremap th  :tabfirst<CR>
" nnoremap tj  :tabprev<CR>
" nnoremap tk  :tabnext<CR>
" nnoremap tl  :tablast<CR>
" nnoremap tt  :tabedit<Space>
" nnoremap tn  :tabnext<Space>
" nnoremap tm  :tabm<Space>
" nnoremap td  :tabclose<CR>
" nnoremap ts  :Tabsplit<Space>

" NERD Tree
nnoremap NT  :NERDTreeToggle<CR>

"Buftabs navigation and shortcuts"
nnoremap <F1>  :bprev<CR>
nnoremap <F2>  :bnext<CR>

" vimtex "
nnoremap vc   :VimtexCompile<CR>
nnoremap vs   :VimtexCompileSelected<CR>
nnoremap vr   :VimtexErrors<CR>

" Vim smooth scrolls "
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" tagbar "
nmap <F8> :TagbarToggle<CR>

" Goyo "
nmap YY :Goyo<CR>

"***************************************************
" YouCompleteMe
"*******g*******************************************
let g:ycm_server_python_interpreter = "/usr/bin/python"
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Let YCM read tags from ctags files
" let g:ycm_collect_identifiers_from_tags_files = 1

" Default 1, just ensure
" let g:ycm_use_ultisnips_completer = 1

" Completion for programming language's keywords
" let g:ycm_seed_identifiers_with_syntax = 1

" Completion in comments
let g:ycm_complete_in_comments = 1

" Completion in strings
let g:ycm_complete_in_strings = 1

" Vimtex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_max_diagnostics_to_display = 1000

"**************************************************
" vimtex
"**************************************************
let g:vimtex_view_general_viewer = "okular"
let g:vimtex_compiler_progname = "nvr"

"**************************************************
" vim-LanguageTool
"**************************************************
let g:languagetool_jar='$HOME/.vim/bundle/vim-LanguageTool/LanguageTool-3.9/languagetool-commandline.jar'
set spelllang='en_us'
hi LanguageToolSpellingError guisp=red  gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=red  term=underline cterm=none

"**************************************************
" vim-airline
"**************************************************
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

"**************************************************
" vim-airline-themes
"**************************************************
let g:airline_powerline_fonts = 0
let g:airline_theme='deus'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.linenr = 'L'
let g:airline_symbols.whitespace = 'Ξ'

"**************************************************
" tabline
"**************************************************
let g:tablineclosebutton = 1

"**************************************************
" jedi-vim
"**************************************************
let g:jedi#documentation_command = "<C-k>"

"**************************************************
" tagbar
"**************************************************
let g:tagbar_ctag_bin=''

"**************************************************
" vim-markdown-preview
"**************************************************
let vim_markdown_preview_perl=1

"**************************************************
" vim-markdown-preview
"**************************************************
let g:notes_directories = ['~/Documents/vim-notes']

"**************************************************
" vim-latex (latex-suite)
"**************************************************
" let g:tex_flavor='latex'

"**************************************************
" sumlime monokai colorscheme
"**************************************************
let g:sublimemonokai_term_italic = 1

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set relativenumber
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()

