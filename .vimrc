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
" 現在の行を強調表示
set cursorline
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

