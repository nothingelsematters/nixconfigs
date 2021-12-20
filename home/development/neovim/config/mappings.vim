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

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Code actions
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
