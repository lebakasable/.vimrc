syntax on
set encoding=utf-8
set termguicolors

set timeoutlen=1000
set ttimeoutlen=0
set updatetime=300
set signcolumn=yes
set clipboard=unnamedplus

set number
set relativenumber

set laststatus=2
set scrolloff=5
set nowrap

set shiftwidth=2
set tabstop=2

set noshowmode
set wildmenu

set incsearch
set hlsearch
set cursorline

set fillchars=eob:\ 
set fillchars+=vert:\│

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set undodir=~/.vim/undo
set undofile

let mapleader = ' '

call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

Plug 'farmergreg/vim-lastplace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mcchrish/nnn.vim'

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Exafunction/codeium.vim'

call plug#end()

colorscheme dracula

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

let g:highlightedyank_highlight_duration = 200

nnoremap <silent> <Esc> :noh<CR>
nnoremap U <C-r>

nnoremap <leader>fe :NnnExplorer<CR>
nnoremap <leader>fp :NnnPicker<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fb :Buffers<CR>

nmap <Tab>   :bn<CR>
nmap <S-Tab> :bp<CR>
nnoremap <leader>x :bd<CR>

nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <leader>gi :Git init<CR>
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>ga :Git add<CR>
nnoremap <leader>gc :Git commit<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)

nmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 OR     :call CocActionAsync('runCommand', 'editor.action.organizeImport')

highlight CocSearch ctermfg=blue
highlight CocErrorSign ctermfg=red
highlight CocWarningSign ctermfg=yellow
highlight CocInfoSign ctermfg=green
highlight CocInlayHint ctermfg=darkgrey
highlight CocNotificationProgress ctermfg=magenta
highlight CocNotificationError ctermfg=red
highlight CocNotificationWarning ctermfg=yellow
highlight CocNotificationInfo ctermfg=green
