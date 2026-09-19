let g:mapleader = "\<Space>"
let g:maplocalleader = ','

set tabstop=2
set shiftwidth=2
set expandtab
set whichwrap=h,l
set cursorline
"set mouse=n
set hlsearch
set wrap
set linebreak


highlight Visual cterm=reverse


"vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.config/vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



" List your plugins here
call plug#begin('~/.config/vim/plugged')

"linter
Plug 'dense-analysis/ale'

Plug 'hedyhli/outline.nvim'

"colorscheme
"Plug 'EdenEast/nightfox.nvim'
"Plug 'fxn/vim-monochrome'
Plug 'fcpg/vim-fahrenheit'
highlight Comment guifg=#FFFFFF


Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"vim-sensible
"Plug 'tpope/vim-sensible'


"bullets-vim
Plug 'bullets-vim/bullets.vim'
let g:bullets_set_mappings = 0
let g:bullets_custom_mappings = [
  \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
  \ ['inoremap', '<C-cr>', '<cr>'],
  \
  \ ['nmap', 'o', '<Plug>(bullets-newline)'],
  \
  \ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
  \ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
  \
  \ ['nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'],
  \
  \ ['imap', '<Tab>', '<Plug>(bullets-demote)'],
  \ ['nmap', '>>', '<Plug>(bullets-demote)'],
  \ ['vmap', '>', '<Plug>(bullets-demote)'],
  \ ['imap', '<Esc><Tab>', '<Plug>(bullets-promote)'],
  \ ['nmap', '<<', '<Plug>(bullets-promote)'],
  \ ['vmap', '<', '<Plug>(bullets-promote)'],
  \ ]


"nerdtree
Plug 'preservim/nerdtree'
nnoremap ` :NERDTreeToggle<CR>

"vim-which-key
"Plug 'liuchengxu/vim-which-key'
"set timeoutlen=500
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"lsp
Plug 'neovim/nvim-lspconfig'
call plug#end()
lua require("outline").setup()
"lua require('lspconfig').pylsp.setup({})
"vim.lsp.config.pylsp.setup({})
"vim.lsp.config.enable('clangd')

"autocmd FileType nerdtree map <buffer> <CR> <CR>:NERDTreeClose<CR>
let g:NERDTreeQuitOnOpen=1

"completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

"coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"colorscheme carbonfox
"highlight Normal ctermbg=none guibg=#000000
"colorscheme monochrome
colorscheme fahrenheit

nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <Tab> :Outline<cr>
nnoremap <silent> <leader>n :noh<cr>

nnoremap <leader>tn :tabnew 
nnoremap <silent> <leader>tq :tabclose<cr>

nnoremap <silent> <leader>an :ALENextWrap<cr>
