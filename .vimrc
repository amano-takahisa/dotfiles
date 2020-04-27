"""""""""""""""""
" Plugins
"""""""""""""""""
" Plugin manager
" https://github.com/junegunn/vim-plug
" installation
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
call plug#begin()
" Python autocompletion with VIM
Plug 'davidhalter/jedi-vim'

" Visible indent
Plug 'nathanaelkane/vim-indent-guides'

" Color scheme
Plug 'nanotech/jellybeans.vim'

" Python pep8 indent check
Plug 'Vimjas/vim-python-pep8-indent'

" Visible white space
Plug 'ntpeters/vim-better-whitespace'

" Aautomatic closing of quotes, parenthesis, brackets, etc
Plug 'Raimondi/delimitMate'

" Supertab is a vim plugin which allows you to use <Tab> for all your insert completion needs (:help ins-completion).
" Plug 'ervandew/supertab'

" autopep8 automatically formats Python code to conform to the PEP 8 style guide
Plug 'tell-k/vim-autopep8'

" a static syntax and style checker for Python source code
Plug 'nvie/vim-flake8'

" Displays a scrollbar with 'thumb' in curses-based vim
" Plug 'lornix/vim-scrollbar'

" Easy way to define your own |operator|
" Installed for rhysd/vim-operator-surround dependency
Plug 'kana/vim-operator-user'

" Complement of surrounding operator
Plug 'rhysd/vim-operator-surround'

" Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'plasticboy/vim-markdown'

" Browse the tags of the current file and get an overview of its structure
Plug 'majutsushi/tagbar'

" Diff two separate blocks of text.
Plug 'AndrewRadev/linediff.vim'

" Provides a much simpler way to use some motions in vim
Plug 'easymotion/vim-easymotion'

" Use different templates
Plug 'mattn/vim-sonictemplate'

" Initialize plugin system
call plug#end()


"""""""""""""""""
" Encoding and Charactor
"""""""""""""""""
" set charactor encoding UFT-8
" set fenc=utf-8
" double size charactor width
set ambiwidth=double


"""""""""""""""""
" Open - save - close
"""""""""""""""""
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
set nobackup
set noswapfile
set autoread
" Enable to open file even when buffer is open
set hidden


"""""""""""""""""
" Markdown
"""""""""""""""""
" Plugin setting: 'plasticboy/vim-markdown'
" Disable Folding
let g:vim_markdown_folding_disabled = 1
" Open TOC by default
function! s:Toc()
  if &filetype == 'markdown'
    :Toc
    set filetype=qf
    setl nofoldenable
    syntax on
  endif
endfunction
autocmd VimEnter *.m*  call s:Toc()
autocmd BufReadPost *.m* call s:Toc()
autocmd BufWinEnter *.m* call s:Toc()
" To change Toc left, ref https://github.com/plasticboy/vim-markdown/issues/166#issuecomment-172409388
let g:vim_markdown_conceal_code_blocks = 0

" Automatically change the current directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

"""""""""""""""""
" Mode
"""""""""""""""""
" exit from terminal mode
tnoremap <Esc><Esc> <C-\><C-n>

"""""""""""""""""
" Window
"""""""""""""""""
" Move from terminal window
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

"""""""""""""""""
" Guide and status (out of edit area)
"""""""""""""""""
set showcmd
" always show status line
set laststatus=2
" Customize status line
set statusline=%F%m%h%w\ %<[%Y]\ %=[%l/%L(%02v)]
" Complete command
set wildmode=list:longest

" Plugin setting: 'lornix/vim-scrollbar'
" let g:loaded_scrollbar=1

"""""""""""""""""
" Appearance in text area
"""""""""""""""""
" Colorscheme
colorscheme jellybeans
syntax enable
set number
" Switch line numbers with F3
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
" Highlight current line
set cursorline
" Highlight column at 80 charactor
set colorcolumn=80
" Highlight current column
" set cursorcolumn
" visualize beep
set visualbell
" Highlight [], (), {}
set showmatch
" cursor can move to one more left from $
set virtualedit=onemore
" Set wrap in diff
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

"""""""""""""""""
" caret move
"""""""""""""""""
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

"""""""""""""""""
" Cut and paste
"""""""""""""""""
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" '"*y' or '"+y' will copy text to xclip
" This enable copy text over ssh
vmap "+y :!xclip -f -sel clip
map "+p :r!xclip -o -sel clip

"""""""""""""""""
" brackets
"""""""""""""""""
" Plugin setting: 'rhysd/vim-operator-surround'
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)


"""""""""""""""""
" Tab & indents charactor
"""""""""""""""""
" Show tab charactors as ▸-
set list listchars=tab:\▸\-
" Insert spaces instead of tab
set expandtab
" Number of spaces for indent tabs
set tabstop=4
" Number of spaces in tab when editing
set softtabstop=4
" Tab width
set shiftwidth=4
set smartindent
" Make indent visible
let g:indent_guides_enable_on_vim_startup = 1

"""""""""""""""""
" Text format
"""""""""""""""""
" Insert CR with O without edit mode
" nnoremap O :<C-u>call append(expand('.'), '')<Cr>j
" Plugin setting: 'tell-k/vim-autopep8'
" Disable show diff window
let g:autopep8_disable_show_diff=1
" Plugin setting: 'mattn/vim-sonictemplate'
let g:sonictemplate_vim_template_dir = [
      \ '~/Templates'
      \]

"""""""""""""""""
" Tab lines
"""""""""""""""""
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            "let s .= ' ' . file . ' '
            let s .= file
            let s .= (i == t ? '%m' : '')
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=2
    highlight link TabNum Special
endif


"""""""""""""""""
" Search
"""""""""""""""""
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
" Highlight off with esc esc.
nnoremap <Esc> :nohlsearch<CR><Esc>
" Move cursor line to center after seach
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=1000
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction


"""""""""""""""""
" Mouse
"""""""""""""""""
if has('mouse')
    set mouse=a
endif


if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
        let &t_EI .= "\e[?2004l"
        let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

