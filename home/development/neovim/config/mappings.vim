" Ctrl-s and Ctrl-w to save and close files
nnoremap <C-s> :w<CR>
nnoremap <C-w> :q<CR>

" Tab in general mode will move to text buffer
nnoremap <Tab> :bnext<CR>
" Shift-Tab will go back
nnoremap <S-Tab> :bprevious<CR>
" Control-i to open NERDTree
nnoremap <C-i> :NERDTreeFocus<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Shift-Tab to inverse tab
inoremap <S-Tab> <C-d>

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

" colorscheme-switcher
nnoremap <F8> :NextColorScheme<CR>
nnoremap <F7> :PrevColorScheme<CR>
