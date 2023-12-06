set timeoutlen=1000
set ttimeoutlen=0

set number
set relativenumber

set scrolloff=5
set nowrap

set shiftwidth=2
set tabstop=2
set foldcolumn=1

set noshowmode
set laststatus=2
set wildmenu

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

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

Plug 'farmergreg/vim-lastplace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'

Plug 'sheerun/vim-polyglot'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

set termguicolors
colorscheme catppuccin_mocha

let g:lightline = { 'colorscheme': 'catppuccin_mocha' }

let g:highlightedyank_highlight_duration = 200

function! s:on_lsp_buffer_enabled() abort
  set foldcolumn=0
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>lr <plug>(lsp-rename)
  nmap <buffer> <leader>la <plug>(lsp-code-action)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
  
  let g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre * call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

nnoremap <silent> <Esc> :noh<CR>
nnoremap U <C-r>

nnoremap <leader>fe :Vexplore<CR>
nnoremap <leader>ff :FZF<CR>
