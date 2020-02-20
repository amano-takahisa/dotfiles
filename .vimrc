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

" 
Plug 'tpope/vim-obsession'

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

" Initialize plugin system
call plug#end()


"""""""""""""""""
" Encoding and Charactor
"""""""""""""""""
"文字コードをUFT-8に設定
set fenc=utf-8
" □や○文字が崩れる問題を解決
set ambiwidth=double


"""""""""""""""""
" Buffer files
"""""""""""""""""
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden


"""""""""""""""""
" Guide and status (out of edit area)
"""""""""""""""""
" 入力中のコマンドをステータスに表示する
set showcmd
" 行番号を表示
" ステータスラインを常に表示
set laststatus=2
" Customize status line
set statusline=%F%m%h%w\ %<[%Y]\ %=[%l/%L(%02v)]
" コマンドラインの補完
set wildmode=list:longest
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore


"""""""""""""""""
" Appearance in text area
"""""""""""""""""
" Colorscheme
colorscheme jellybeans
" シンタックスハイライトの有効化
syntax enable
set number
" Switch line numbers with F3
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
" 現在の行を強調表示
set cursorline
" Highlight column at 80 charactor
set colorcolumn=80
" 現在の行を強調表示（縦）
" set cursorcolumn
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch


"""""""""""""""""
" caret move
"""""""""""""""""
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


"""""""""""""""""
" Tab & indents charactor
"""""""""""""""""
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" Number of spaces in tab when editing
set softtabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" インデントはスマートインデント
set smartindent
" Make indent visible
let g:indent_guides_enable_on_vim_startup = 1

"""""""""""""""""
" Text format
"""""""""""""""""
" Insert CR with O without edit mode
" nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

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
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" Move cursor line to center after seach
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

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

