syntax on

"--- Formatting"
set background=dark "Apply the color set for dark screens"
set clipboard=unnamedplus "Enable the clipboard between Vim/Neovim and other applications"
set completeopt=noinsert,menuone,noselect "Modifies the auto-complete menu to behave more like an IDE"
set cursorline "Highlights the current line in the editor"
set hidden "Hide unused buffers"
set inccommand=split "Show replacements in a split screen before applying it to the file"
set number "Shows line numbers"
set relativenumber "Shows line numbers starting from the current one"
set splitbelow splitright "Change split and vsplit to always split below and to the right"
set title "Show the file title"
set ttimeoutlen=0 "Time in milliseconds to run commands"
set wildmenu "Shows a more advanced menu for auto-completion suggestions"

set expandtab "Transforms tabs into spaces"
set shiftwidth=2 "Number of spaces for indentation"
set tabstop=2 "Number of spaces for tabs"

filetype plugin indent on

"--- Search"
set smartcase
set ignorecase
set hlsearch
set incsearch
set wildmode=longest,list,full
set wildmenu
set wildignore=*.o,*~

"--- Files"
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set autoread

set encoding=UTF-8
set cmdheight=2
set updatetime=300

set t_Co=256 "Enable 256 colors on the terminal"

if $TERM !=? 'xterm-256color'
	set termguicolors
endif

call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'RRethy/vim-illuminate' " Highlight the word under the cursor
  Plug 'tpope/vim-surround'    " Surrounding
  Plug 'github/copilot.vim'    " Github Copilot
  Plug 'fatih/vim-go'          " Go
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " TreeSitter
  Plug 'marko-cerovac/material.nvim' " Material Theme
call plug#end()

let g:material_style = "palenight"
colorscheme material
set termguicolors
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

""" COC Config
" Map <tab> to trigger completion and navigate to the next line
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

command! -nargs=0 Prettier :call CocAction("runCommand", "prettier.formatFile")

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Treesitter Config
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'go', 'javascript', 'typescript', 'html', 'css', 'python', 'rust', 'lua', 'c', 'cpp' },
  highlight = { enable = true },
  indent = { enable = true }
}
EOF
