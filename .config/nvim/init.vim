" neovim settings
"""""""""""""""""
" Plugins
"""""""""""""""""
" Plugin manager
" https://github.com/junegunn/vim-plug
" installation
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Python autocompletion with VIM
" Plug 'davidhalter/jedi-vim'

" Make your Vim/Neovim as smart as VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" Markdown Preview for (Neo)vim
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Automated bullet lists
Plug 'dkarter/bullets.vim'

" Browse the tags of the current file and get an overview of its structure
Plug 'preservim/tagbar'

" Diff two separate blocks of text.
Plug 'AndrewRadev/linediff.vim'

" Provides a much simpler way to use some motions in vim
Plug 'easymotion/vim-easymotion'

" Use different templates
" Plug 'mattn/vim-sonictemplate'

" save session
" Plug 'tpope/vim-obsession'

" a file system explorer for the Vim editor
Plug 'preservim/nerdtree'

" Supports plugins to show icons.
Plug 'ryanoasis/vim-devicons'

" Linter and acts as a Vim Language Server Protocol client.
" Plug 'dense-analysis/ale'

" scrollbar for neovim(nightly)
" Plug 'Xuyuanp/scrollbar.nvim'

" Vim plugin for preview.
" Plug 'previm/previm'

" Open URI with your favorite browser from your most favorite editor.
" Plug 'tyru/open-browser.vim'

" Semshi provides semantic highlighting for Python in Neovim.
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Gutentags is a plugin that takes care of the much needed management of tags
" files in Vim. It will (re)generate tag files as you work while staying
" completely out of your way. It will even do its best to keep those tag files
" out of your way too. It has no dependencies and just works.
Plug 'ludovicchabant/vim-gutentags'

" the premier Vim plugin for Git.
Plug 'tpope/vim-fugitive'

" nice statusline at the bottom of each vim window
Plug 'vim-airline/vim-airline'

" Things you can do with fzf and Vim.
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'


" Initialize plugin system
call plug#end()

"""""""""""""""""
" Encoding and Charactor
"""""""""""""""""
" set encoding=UFT-8
" set fenc=utf-8
" double size charactor width
" set ambiwidth=double

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

" Plugin setting: 'tpope/vim-obsession'
" set -g @resurrect-strategy-nvim 'session'


"""""""""""""""""
" file manager
"""""""""""""""""

" set file icons
" Plugin setting: 'ryanoasis/vim-devicons'
" let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
" アイコン入力方法 : `[Ctrl+V]` > `[u]` > `e905`
let g:NERDTreeExtensionHighlightColor = {}
" let g:NERDTreeExtensionHighlightColor['vue'] = '42B983'`
" autocmd FileType nerdtree setlocal nolist
" let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Plugin setting: 'preservim/nerdtree'
" Open NERDTree
map <C-n> :NERDTreeToggle<CR>

" show hidden file by default
let NERDTreeShowHidden=1

" file filters
let NERDTreeIgnore = ['^__pycache__$', '.*\.egg-info$', '\.mypy_cache']

"""""""""""""""""
" Markdown
"""""""""""""""""
" Plugin setting: 'previm/previm'
" let g:previm_open_cmd = 'firefox'

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
" autocmd VimEnter *.m*  call s:Toc()
" autocmd BufReadPost *.m* call s:Toc()
" autocmd BufWinEnter *.m* call s:Toc()
" To change Toc left, ref https://github.com/plasticboy/vim-markdown/issues/166#issuecomment-172409388
let g:vim_markdown_conceal_code_blocks = 0

" Automatically change the current directory
" autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" for markdown preview
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 1

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = '8727'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

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
" Buffer
"""""""""""""""""
" switch buffers
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
" close buffer without close windows
" https://stackoverflow.com/a/4468491/
nnoremap <C-c> :bp<bar>bd #<CR>

"""""""""""""""""
" Guide and status (out of edit area)
"""""""""""""""""
set showcmd
" always show status line
" set laststatus=2
" set statusline=%F%m%h%w\ %<[%Y]\ %=[%l/%L(%02v)]
" Customize status line
" ref: https://vi.stackexchange.com/questions/27880/pathshorten-all-but-containing-directory/27881#27881
" function! CondensedPath() abort
"     if expand(':h') == '/'
"         return '/' . expand('%:t')
"     else
"         return pathshorten(expand('%:h')) . '/' . expand('%:t')
"     endif
" endfunction
" set statusline=%{CondensedPath()}%m%h%w\ %<[%Y]\ %=[%l/%L(%02v)]

" Plugin setting: 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

" Complete command
set wildmode=list:longest


"""""""""""""""""
" Appearance in text area
"""""""""""""""""
" Colorscheme
colorscheme jellybeans
syntax enable
set number
set relativenumber

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
" add aggressive option (--aggressive)
let g:autopep8_aggressive=2

" Plugin setting: 'mattn/vim-sonictemplate'
" let g:sonictemplate_vim_template_dir = [
"       \ '~/Templates'
"       \]

" Plugin setting: 'dense-analysis/ale'
" set flake8 as linter
" let g:ale_linters = {
"     \ 'python': ['autopep8'],
"     \ }
" let g:ale_linters = {
" \ 'python': ['mypy', 'black', 'autopep8']
" \ }


" Plugin setting: 'dkarter/bullets.vim'
" let g:bullets_mapping_leader = '<M-b>'
let g:bullets_mapping_leader = ''
" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]
let g:bullets_checkbox_markers = ' .oX'
" Example:
" - [o] parent bullet  [ <- `o` indicates 66% - 99% of children are checked ]
"   - [ ] child bullet
"   - [.] child bullet [ <- partial completions don't count as complete ]
"     - [ ] sub-child bullet [ <- 1/4 of children checked so parent is `.` ]
"     - [ ] sub-child bullet
"     - [ ] sub-child bullet
"     - [X] sub-child bullet
"   - [X] child bullet
"   - [X] child bullet

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
" Auto completion
"""""""""""""""""
"" Plugin setting: neoclide/coc.nvim
"" https://github.com/neoclide/coc.nvim#example-vim-configuration
"" TextEdit might fail if hidden is not set.
"set hidden
"
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif
set signcolumn=no
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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

"""""""""""""""""
" Tags
"""""""""""""""""
" Plugin setting: ludovicchabant/vim-gutentags
" https://github.com/ludovicchabant/vim-gutentags/issues/178#issuecomment-575693926
" fix error messages when edit git commit messages
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
