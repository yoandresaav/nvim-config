source ~/.config/nvim/.plugg.vim

set nocompatible
set showmatch
set ignorecase
set mouse=v
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
set relativenumber
set wildmode=longest,list
set list
set listchars=tab:>-
set cc=80
filetype plugin indent on
syntax on
set mouse=a
set clipboard=unnamedplus
filetype plugin on
filetype indent on
set cursorline
set ttyfast
set noswapfile

call plug#begin("~/.config/nvim/plugged")

Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
Plug 'dracula/vim'
Plug 'overcache/NeoSolarized'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sainnhe/sonokai'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" comments for jsx,tsx
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" Javascript syntax
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'

" Configure TABS
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Match tags
Plug 'leafOfTree/vim-matchtag'

Plug 'Darazaki/indent-o-matic'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" ident
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'tpope/vim-fugitive' " git 
Plug 'lewis6991/gitsigns.nvim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


Plug 'Pocco81/true-zen.nvim'
Plug 'Pocco81/auto-save.nvim'

call plug#end()


let mapleader = " "

set termguicolors
colorscheme sonokai

augroup reactgroup
    autocmd!
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
    autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
augroup END

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
" fast
let g:airline_extensions = [] 


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1


nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

"/lo:8000/app/candidat Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Config Telescope seach ignore folders
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".venv", ".env", "static", "yarn.lock"}
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  }}
EOF


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '

lua << EOF
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config =  {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      }
   }
  },
  autotag = {
      enable = true,
  }
}
EOF

" Find word under the cursor
command! -bang -nargs=* RgExact
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nmap <Leader>G :execute 'RgExact ' . expand('<cword>') <Cr>

" Highlight cursor line underneath the cursor vertically.
set statusline=
set statusline+=\ %M
set statusline+=\ %F
set statusline+=\ %{FugitiveStatusline()}
set laststatus=2

" Config Fugitive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

" Config Telescope seach ignore folders
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".venv", ".env", "static", "yarn.lock"}
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  }}
EOF


" Goto buffer in position...
nmap <silent> <leader>1 <Cmd>BufferGoto 1<CR>
nmap <silent> <leader>2 <Cmd>BufferGoto 2<CR>
nmap <silent> <leader>3 <Cmd>BufferGoto 3<CR>
nmap <silent> <leader>4 <Cmd>BufferGoto 4<CR>
nmap <silent> <leader>5 <Cmd>BufferGoto 5<CR>
nmap <silent> <leader>6 <Cmd>BufferGoto 6<CR>
nmap <silent> <leader>7 <Cmd>BufferGoto 7<CR>
nmap <silent> <leader>8 <Cmd>BufferGoto 8<CR>
nmap <silent> <leader>9 <Cmd>BufferGoto 9<CR>
nmap <silent> <leader>0 <Cmd>BufferLast<CR>

" Lua config git decorator https://github.com/lewis6991/gitsigns.nvim
lua << EOF
require('gitsigns').setup()
EOF

lua << EOF
	require("true-zen").setup {}
    require("auto-save").setup {}
EOF


