
    " -- HTML Tags -- "
inoremap <C-l>   <esc>:call  search("[<][^>]*[>]")       <enter>a
inoremap <c-h>   <esc>:call  search("[<][^>]*[>]", "b")  <enter>a
inoremap <C-q>   <esc>:call  search("[<][^>]*[>]", "b")  <enter>i
inoremap <C-w>   <esc>:call  search("[<][^>]*\\zs[>]")   <enter>a
nnoremap <C-f>   <esc>vit

vnoremap <C-l>   /\v[<][^>]*[>]<enter>
vnoremap <c-h>   ?\v[<][^>]*[>]<enter>
vnoremap <C-q>   ?\v\v[<][^>]*[>]<enter>
vnoremap <C-w>   /\v[<][^>]*\\zs[>]<enter>


