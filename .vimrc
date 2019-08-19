
set nocompatible              

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

" set no backup file
set nobackup
set noswapfile


"call plug#end() to update &runtimepath and initialize plugin system
" Automatically executes filetype plugin indent on and syntax enable. 
"You can revert the settings after the call. e.g. filetype indent off, 
"syntax off, etc.

filetype plugin indent on
syntax enable
syntax on
set hidden

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" some random plugins
Plug 'nixon/vim-vmath'
Plug 'habbis/dragvisuals'
" colorschemes
Plug 'sjl/badwolf'
Plug 'dracula/vim'
Plug 'reedes/vim-colors-pencil'
"
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
" Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'ekalinin/Dockerfile.vim'
Plug 'Townk/vim-autoclose'
Plug 'mayanksuman/vim-notes-markdown'


" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

"Initialize plugin system
call plug#end()



 colorscheme dracula

" set spelling in vim
set nospell
set spelllang=en_us

"(or whatever keys you prefer to remap these actions to)  

" Here begins my config of vim·
"====[ Make the 81st column stand out ]====================
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>


    " EITHER blink the line containing the match...
    function! HLNext (blinktime)
        set invcursorline
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        set invcursorline
        redraw
    endfunction

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list

" ++ sum up number  with only the vmath plugin
     vmap <expr>  ++  VMATH_YankAndAnalyse()
     nmap         ++  vip++




    " remap of leader and other keys
   nnoremap <SPACE> <Nop>
   nnoremap <SPACE> :

    " Quickly edit/reload the vimrc file
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>


"====[ Swap v and CTRL-V, because Block mode is more useful that Visual mode "]======

    nnoremap    v   <C-V>
    nnoremap <C-V>     v

    vnoremap    v   <C-V>
    vnoremap <C-V>     v

" this is for the plugin lightline.vim
" set noshowmode
" set laststatus=2

" this is for the plugings vim-colors-pencil and goyo
function! s:goyo_enter()
       colorscheme pencil
    endfunction

     function! s:goyo_leave()
         colorscheme dracula
	 " badwolf
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" to install the plugin youcompleteMe go to the folder
" cd ~.vim/plugged/YouCompleteMe (vim) or 
" cd ~/.local/share/nvim/site/plugged/YouCompleteMe (neovim) :)
" ./install.py
"
" change the mapleader from \ to ,
let mapleader=","

" if using grip for (github markdown)
let vim_markdown_preview_github=1

" this if for vim-markdown-preview
let vim_markdown_preview_hotkey='<C-m>'

let vim_markdown_preview_browser='Google Chrome'

" shortcut for opening nerdtree
map <C-n> :NERDTreeToggle<CR>

" for vim-easymotion
map <Leader> <Plug>(easymotion-prefix)


