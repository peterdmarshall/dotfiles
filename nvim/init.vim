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

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

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
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
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
" disable_filename: if disable filename header for preview page, default: 0
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
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

if $TERM !=? 'xterm-256color'
	set termguicolors
endif

call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'RRethy/vim-illuminate' " Highlight the word under the cursor
  Plug 'tpope/vim-surround'    " Surrounding
  Plug 'fatih/vim-go'          " Go
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " TreeSitter
  Plug 'marko-cerovac/material.nvim' " Material Theme
  Plug 'airblade/vim-gitgutter'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
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
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use esc to remove highlight from search
nnoremap <silent> <esc> :noh<cr><esc>

" Use Tab and S-Tab to navigate search
cmap <Tab> <C-g>
cmap <S-Tab> <C-t>

" Treesitter Config
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'go', 'javascript', 'typescript', 'html', 'css', 'python', 'rust', 'lua', 'c', 'cpp' },
  highlight = { enable = true },
  indent = { enable = true }
}
EOF
