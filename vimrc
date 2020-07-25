" 设置相对行号
set nu
set rnu

" 自动读取
set autoread

" 删除键无法删除
set backspace=2

" 定义快捷键的前缀，即<Leader>
let mapleader="'"

" 开启文件类型侦测
filetype on
" 根据文件类型加载对应的插件
filetype plugin on

filetype plugin indent on

" 行首和行尾
nnoremap <C-A> 0
nnoremap <C-S> $
" 将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 保存当前窗口内容
nmap <Leader>w :w<CR>
" 保存所有窗口内容
nmap <Leader>W :wa<CR>
" 保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

nmap <C-B> <C-I>
nmap <Leader>c zz<CR>15<C-E>

" 辅助信息
" 显示光标当前的位置
" set ruler
set cursorline
" 禁止光标的闪烁
" set guicursor+=a:blinkon0

" 搜索高亮配置
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

" ctrl+M 取消高亮
nnoremap <C-M> :set nohlsearch<cr>

" 缩进
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

set smartindent

autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" 禁止折行
" set nowrap

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
" set ignorecase
" vim 自身命令行模式智能补全
set wildmenu

" split vsplit 设置
set splitright
set splitbelow

" vim-plug环境设置
call plug#begin('~/.vim/plugged')
" coc.nvim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'

" golang
Plug 'fatih/vim-go'

" fzf
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

" 括号 引号自动补全
Plug 'jiangmiao/auto-pairs'

" vim-typora
Plug 'wookayin/vim-typora'
" ansible
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

" exchange
Plug 'tommcdo/vim-exchange'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'airblade/vim-gitgutter' 
" buffer
Plug 'moll/vim-bbye'

Plug 'morhetz/gruvbox'

Plug 'voldikss/vim-floaterm'

Plug 'mhinz/vim-startify'

Plug 'voldikss/vim-translator'
" 插件列表结束
call plug#end()

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" vim-startify
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_bookmarks = [ 
            \ {'o': '~/go/src/yunion.io/x/onecloud'}, 
            \ {'s': '~/code/go/yunion/onecloud-service-operator'},
            \ {'n': '~/Documents/NoteBook'},
            \ ]
let g:startify_session_persistence = 1
let NERDTreeHijackNetrw = 0

let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]


" defx.vim
" let g:maplocalleader=';'
nnoremap <silent> <Leader>1
\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <Leader>v
\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
	\ 'columns': 'indent:git:icons:filename',
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'root_marker': '≡ ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions,.idea'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
	\   . ',_output,.github,.circleci'
	\ })

autocmd FileType defx call s:defx_mappings()
function! s:defx_mappings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ? 
                \ defx#do_action('open_or_close_tree') : 
                \ defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> c
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> s
                \ defx#do_action('multi',[['drop','split']])
    nnoremap <silent><buffer><expr> v
                \ defx#do_action('multi',[['drop','vsplit']])
    nnoremap <silent><buffer><expr> nd
                \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> nf
                \ defx#do_action('new_file')
"    nnoremap <silent><buffer><expr> M
"                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> d
                \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
                \ defx#do_action('rename')
   nnoremap <silent><buffer><expr> yy
               \ defx#do_action('yank_path')
"    nnoremap <silent><buffer><expr> .
"                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <C-r>
                \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')
endfunction

" coc-smartf
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap ; <Plug>(coc-smartf-repeat)
" nmap , <Plug>(coc-smartf-repeat-opposite)
augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#228B22
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end

" vim-translator
nmap <silent> <Leader>t <Plug>TranslateW
vmap <silent> <Leader>t <Plug>TranslateWV

let g:translator_default_engines = ['haici', 'google']

" floaterm
nnoremap   <silent>   <Leader>4    :FloatermNew<CR>
tnoremap   <silent>   <Leader>4    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <Leader>3   :FloatermToggle<CR>
tnoremap   <silent>   <Leader>3   <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_gitcommit = "split"

" gitgutter 设置
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)

" markdown 设置
let g:vim_markdown_folding_disabled = 1
let g:vmt_auto_update_on_save = 0

" multiple cursors 设置
nnoremap <silent> <c-q> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <c-q> :MultipleCursorsFind <C-R>/<CR>

" commentary
autocmd FileType python,shell,yaml setlocal commentstring=#\ %s

" 主题设置
syntax on
syntax enable
set bg=dark
" colorscheme Tomorrow-Night
set termguicolors
autocmd vimenter * colorscheme gruvbox

let g:gruvbox_vert_split = 'bg0'
let g:gruvbox_sign_column = 'bg0'

" fzf配置
map <Leader>p :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>f :Rg <C-R><C-W><CR>
let g:coc_fzf_preview = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <Leader>d  :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <Leader>2  :<C-u>CocFzfList outline<CR>

" coc-bookmark
nmap <Leader>mn <Plug>(coc-bookmark-toggle)
nnoremap <silent> <Leader>ml :<C-u>CocList bookmark<CR>

" statusline
" always display statusline
set laststatus=2
" [: literal
" %n: buffer number
" ]: literal
" \<Space>: a space
" %<: Truncate the field at the beginning if too long
" %f: Path to the file in the buffer, as typed or relative to current directory.
" %h: Help buffer flag, text is "[help]".
" %m: Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
set statusline=%f%m%=%p%%

" coc-snippet 配置
" imap <C-t> <Plug>(coc-snippets-expand)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<tab>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-b>'

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

let g:coc_snippet_next = '<tab>'

" go-vim 配置
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_gopls_enabled = 0
let g:go_highlight_variable_declarations = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
set autowrite

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"      \ pumvisible() ? "\<C-n>" :

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent> <c-t> <c-o>:call CocActionAsync('showSignatureHelp')<CR>
nnoremap <silent> <c-t> :call CocActionAsync('showSignatureHelp')<CR>

" Use K to show documentation in preview window
nnoremap <silent> gs :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" " nmap <leader>qf  <Plug>(coc-fix-current)

" " Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

