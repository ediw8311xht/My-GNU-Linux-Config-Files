                     
"<==========================================================================>
"<==----------------======================================----------------==>
"<==-----  ||||-----======================================-----  ||||-----==>
"<==-----  ||||-----==__________________________________==-----  ||||-----==>
"<==-  ||||||||||||-==                                  ==-  ||||||||||||-==>
"<==-  ||||||||||||-== Vim Config -> Maximilian Ballard ==-  ||||||||||||-==>
"<==-----  ||||-----==__________________________________==-----  ||||-----==>
"<==-----  ||||-----==                                  ==-----  ||||-----==>
"<==-----  ||||-----======================================-----  ||||-----==>
"<==-----  ||||-----======================================-----  ||||-----==>
"<==----------------======================================----------------==>
"<==========================================================================>
"<==========================================================================>

"<--------- FUNCTIONS ------------------------------------------------------>
fu! CorrectColors()
    hi StatusLine    cterm=NONE ctermbg=NONE ctermfg=160  gui=NONE    guibg=#000000 guifg=#00DD00
    hi FoldColumn    cterm=NONE ctermbg=NONE ctermfg=NONE gui=ITALIC  guibg=NONE    guifg=#00ff00 
    hi Folded        cterm=NONE ctermbg=NONE ctermfg=NONE gui=ITALIC  guibg=NONE    guifg=#999999
    hi CursorLine    cterm=BOLD ctermfg=NONE ctermbg=18   gui=BOLD    guibg=NONE    guifg=NONE
    hi CursorLineNr  cterm=BOLD ctermfg=NONE ctermbg=18   gui=NONE    guibg=NONE    guifg=#FFFF00
    hi SignColumn    cterm=NONE ctermbg=NONE ctermfg=NONE gui=ITALIC  guibg=NONE    guifg=#000000
    hi LineNr        cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE    guibg=#000000 guifg=#AAAAAA
    hi LineNrAbove   cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE    guibg=#000000 guifg=#00AAFF
    hi TabLine                                            gui=NONE    guibg=NONE    guifg=NONE
    hi TabLineSel                                         gui=NONE    guibg=#000000 guifg=#00FF44
    hi MarkSignNumHL                                      gui=NONE    guibg=none    guifg=NONE
    hi MarkSignVirtTextHL                                 gui=NONE    guibg=NONE    guifg=#00FF00
endfu

fu! L(keys, command, silent="0")
    if a:silent ==? '1' 
        execute 'sil nn <leader>'.a:keys.' '.a:command
    else
        execute 'nn <leader>'.a:keys.' '.a:command
    end
endfu

fu! CyBac(nextprevious)
    let i = 0 | let current_background = synIDattr(hlID("Normal"), "bg")  
    if current_background == ""
        let current_background="NONE"| "CATCH NO BACKGROUND (Transparency)
    endif
    let lenny = len(g:myBg)
    for _ in g:myBg
        if current_background ==? _ 
            let j = (i + (a:nextprevious)) % lenny
            execute "highlight Normal guibg=" . g:myBg[j]
            execute "highlight Normal guifg=" . g:myFg[j]
            echo j . ' / ' . lenny | syntax on | return
        endif
    let i += 1 | endfor
endfu

fu! CyCol(nextprevious)
    let i = 0 | let current_scheme = g:colors_name
    let lenny = len(g:myScheme)
    for _ in g:myScheme
        if current_scheme ==? _
            let j = (i + (a:nextprevious)) % lenny
            echo g:myScheme[j] . ' - ' . j '/' . (lenny - 1)
            execute "colorscheme " g:myScheme[j]
            execute g:mySpec[j]
            syntax on
        return | endif
    let i += 1 | endfor
endfu

fu! Tog(c1, c2, r1, r2)
    if a:c1 == a:c2 
    execute a:r1 | return | endif
    execute a:r2
endfu

fu! Cy(checkarr, cvar, doarr, nextprevious)
    let lenny = len(a:checkarr)
    let i = 0
    while i < lenny
        if a:checkarr[i] ==? a:cvar
            let j = (i + (a:nextprevious)) % lenny
            execute a:doarr[j]
        return | endif
        let i += 1
    endwhile
endfu

"<--------- MY VARS -------------------------------------------------------->
let jam="hi FoldColumn gui=bold guibg=NONE guifg=#00ff00"
let GreatJammy=':call CorrectColors()'
let g:myScheme = [ 'pop-punk', 'eldar', 'elflord', 'delek', 'morning', 'blue', 'cyberpunk-neon', 'peachpuff', 'industry' ]
let g:mySpec   = [        ".",     jam,       ".",     ".",       ".",    ".",       GreatJammy,         '.',         '.']

let g:myBg     = [ "#000000", "#333333", "#111111", "#220000", "#002200", "#000022", "#002244" ]
let g:myFg     = [       ".",       ".",       ".",       ".",       ".",       ".", "#aaaaaa" ]

let g:myBg+=["NONE"] | let g:myFg+=[   "."]

let g:python3_host_prog="/usr/bin/python"
"<--------- LET/SET -------------------------------------------------------->
filetype off
set runtimepath+=/usr/local/share/lilypond/current/vim/
set runtimepath+=$LILYPOND_HOME
filetype plugin on
filetype plugin indent on
syntax on
"set colorcolumn=80
set magic
set termguicolors
set splitright
set t_Co=256
set nocompatible
set modelines=0
set signcolumn=yes:1
set nu
set rnu
set ruler
set hidden
set updatetime=200
set nowrap
set textwidth=0
set formatoptions=tcqrn1
set clipboard=unnamedplus
set autoindent
set backup
set undofile
set undolevels=10000000
set undoreload=1000000
set dir=~/.mynvim/swapfiles
set backupdir=~/.mynvim/backupfiles
set undodir=~/.mynvim/undo_dir
set timeout 
set timeoutlen=700
set ttimeoutlen=0
set wildmode=longest,list,full
set foldcolumn=auto
set showmode
set virtualedit=none
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
"set nomore

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
let g:html_dynamic_folds = 1
let g:coc_start_at_startup = v:true
let g:coc_enable_at_startup = v:false
let g:mapleader = ","
let mapleader = ","
let maplocalleader = ","

"<--------- PLUGINS -------------------------------------------------------->
call plug#begin()
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"treesitter, self explanatory
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"show-all-matching-tags-vim
Plug 'andymass/vim-matchup'
"autoclose html tags
Plug 'alvan/vim-closetag'
"autorename html tags
Plug 'AndrewRadev/tagalong.vim'
"syntax-for-lf
Plug 'VebbNix/lf-vim'
"Plug 'neovim/nvim-lspconfig'
"syntax-for-i3
Plug 'PotatoesMaster/i3-vim-syntax'
"auto-save-restore-view :) --best plugin
Plug 'https://github.com/vim-scripts/restore_view.vim'
"realtime-html-editor
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
"showmarks
Plug 'chentoast/marks.nvim'
"lilypondstuff--music-score-creation
Plug 'martineausimon/nvim-lilypond-suite'
"req for lilypond, cool ui stuff
Plug 'MunifTanjim/nui.nvim'
"just for fun record stats about programming
Plug 'wakatime/vim-wakatime'
" fzf finder
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

"<--------_G-VAR_<leader>f_from-:-lf
lua require('base')
let g:lf_map_keys = 0
let g:html_mode   = 1
let g:is_bash     = 1
"-----------------CLOSETAG
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

"<--------- COLOR SCHEME STUFF --------------------------------------------->
colorscheme pop-punk
:call CorrectColors()

""<--------- COCSTUFF ------------------------------------------------------->
hi ColorColumn cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#333333 guifg=NONE

set guicursor=n:block90,i:ver20
set cul
set nocuc
"<--------- MAPPINGS ------------------------------------------------------->
"nn <leader>stupidv :%s/\t/    /g<esc>
"list keybindings with :help index
"list user keybindings with :map
"nn <leader>. :NERDTreeToggle<esc>
cal L('<leader>', ' <C-^>')
cal L( 'a',  ':cal Tog(g:coc_enabled, 0, ":CocEnable", ":CocDisable")<esc>')
cal L( 'b',  ':ls<CR>:b<Space>')
cal L( 'c',  ':set nocursorline!<esc>')
cal L( 'e',  ':set cursorcolumn!<esc>')
cal L( 'f',  ':set wrap!<esc>')
cal L( 'h',  ':cal Tog(&ls, 0, "set ru \| set ls=2", "set noru \| set ls=0")<esc>')
cal L( 'j',  ':cal CyCol(+1)<CR>')
cal L( 'J',  ':cal CyCol(-1)<CR>')
cal L( 'n',  ':cnext<esc>')
cal L( 's',  ':%so "${HOME}/.config/nvim/init.vim"<esc>')
cal L( 'w',  ':w<esc>')
cal L( 'x',  ':!%:p<esc>')
cal L( 'y',  ':hi Normal guibg=Transparent<esc>')
cal L( 'z',  'z')
cal L( 'l',  ':cal CyBac(+1)<CR>')
cal L( 'L',  ':cal CyBac(-1)<CR>')
cal L( 'B',  ':Buffers<esc>')
cal L( 'D',  ':Bracey<esc>')
cal L( 'H',  ':vert helpgrep ')
cal L( 'N',  ':cprevious<esc>')
cal L( 'M',  ':messages<esc>')
cal L( ';',  ':ls<CR>:b<Space>')
cal L( '.',  'q:')
cal L( '/',  ':Explore<CR>')
cal L( 'op', 'q:<C-p><esc>Iput =execute("<esc>A")<esc>A<C-c>')
cal L( 'oc', 'q:iput =execute("")<esc>A<C-c>')
cal L( 'ox', ':put   =execute("<C-r>0")<esc>')
cal L( 'vv', ':cal Cy(["none", "all", "block"], &ve, ["set ve=all \| echo &ve", "set ve=block \| echo &ve", "set ve=none \| echo &ve"], 0)<esc>')
cal L( 'tt', ':tabnew<esc>')
cal L( 'tn', ':tabmove +1<esc>')
cal L( 'tp', ':tabmove -1<esc>')
cal L( 'tb', ':tabmove -1<esc>')
cal L( 'tm', ':tabmove')
cal L( 'tf', ':tabfirst<esc>')
cal L( 'tl', ':tablast<esc>')
cal L( 'tN', ':tabmove +1<esc>')
cal L( 'tB', ':tabmove -1<esc>')
cal L( 'vm', ':put =eval("<C-r>0")')
cal L( 'vq', ':put =eval("<C-r>0")<esc>')
cal L( 'vz', 'i<C-r>"')
cal L( 'vf', '?<C-r>"<enter>')
cal L( 'out', 'q:iput =execute("<C-r>0")<esc>A<C-c>')
cal L( 'tcc', ':tabclose<esc>')
cal L( 'var', ':let maxvar ="<C-r>1<C-r>0"')
cal L( '<C-w>line', ':cal Tog(&cc, 0, "set cc=80", "set cc=0")<esc>')
no <leader>zaf gg/<C-r>0<esc>jVnkzf
vn <leader>x c<esc>l:execute "normal! i" . eval('<C-r>"')<esc>
nn <C-p> <C-i>
nn HEALTH :checkhealth<esc>
vn im :s/\%V[ \t]*//<esc>| "REMOVE TABS ON VISUAL SELECTION
vn <Space> zf
sil nn <silent><esc> :noh<esc>
sil nn       <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nn / /\v\c
nn <lt> :tabprevious<esc>
nn > :tabnext<esc>
nn x "xx
nn \ `
im jk <esc>
"nn dd "Ddd
"nn  D "DD
"nn cc "Ccc
"nn  C "CC
"nn C "Cd
"map <leader> :Lf<CR>
" Take last command line command to use to output to neovim
" BELOW 4 lines do that riff on that
set cedit=\<C-c>
"<--------- STATUS LINE ---------------------------------------------------->
set statusline=\ %F\ \|
set statusline+=\%l\(%L\)\|%v\ 
set statusline+=%m\ 
set statusline+=%=\ [%n]\ 
set statusline+=%=\ %L\ l,\ 
set statusline+=%{wordcount().words}\ w\ 

autocmd BufNewFile,BufRead *.sh                     set syntax=zsh
autocmd BufNewFile,BufRead ~/.config/polybar/config setfiletype dosini
autocmd BufNewFile,BufRead ~/.config/i3/*           setfiletype i3

"map <C-b> nn <leader>bb :buffers<cr>:b<space> 
"nn <leader><leader> :<backspace>
"nn <leader>ap :let @+="<C-r>1<C-r>0"
"1+2                   
"vn <leader>vq q:o<C-c>put =execute(' <C-R>0')
"vn <leader>dc :put =execute('dc <C-r>0')<esc>

"nn <leader>mq :put =execute('echo <c-r>0')<esc>
"vn <leader>c c<esc>l:execute "normal! i" . execute("!<C-r>"")<esc>
"<--------- EXTRA ---------------------------------------------------------->
"augroup bashiez
"    au!
"    autocmd BufNewFile,BufRead *.sh set syntax=zsh
"augroup END
"<--------- INFO ----------------------------------------------------------->
"   %<"                             _-_is expanded to the name of the current buffer.

"   :help key-notation              _-_for list of keys and their names.
"   :only                           _-_make split only one. 
"   :let                            _-_list all options and their values. 
"   :put =Execute("map")            _-_output of command into nvim.  
"<-------------------------------------------------------------------------->


"hi default link CocErrorVirtualText         CocErrorSign
"hi default link CocWarningVirtualText       CocErrorSign
"hi default link CocInfoVirtualText          CocErrorSign
"hi default link CocHintVirtualText          CocErrorSign
"hi default link CocErrorHighlight           CocErrorSign
"hi default link CocWarningHighlight         CocErrorSign
"hi default link CocInfoHighlight            CocErrorSign
"hi default link CocHintHighlight            CocErrorSign
"hi default link CocErrorFloat               CocErrorSign
"hi default link CocWarningFloat             CocErrorSign
"hi default link CocInfoFloat                CocErrorSign
"hi default link CocHintFloat                CocErrorSign
"hi default link CocCursorRange              CocErrorSign
"hi default link CocHoverRange               CocErrorSign
"hi MatchParen          cterm=NONE ctermbg=NONE ctermfg=NONE gui=reverse    
"hi cursorcolumn        gui=bold,italic,reverse
"hi Normal              cterm=NONE ctermbg=17   ctermfg=NONE gui=NONE    guibg=NONE    guifg=#ffffff
"hi Visual              cterm=NONE ctermbg=NONE ctermfg=16   gui=NONE guibg=#333333 guifg=#00ff00
"hi NonText             cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE    guifg=NONE
"hi CocSearch           cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi CocMenuSel          cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi CocErrorHighlight   cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi CocErrorSign        cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi CocWarningSign      cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi CocInfoSign         cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi CocHintSign         cterm=NONE ctermbg=NONE ctermfg=NONE gui=NONE guibg=#FF0000 guifg=#000000
"hi htmlTag                                                  gui=reverse guifg=#90b0d1 guibg=#000033
"hi htmlSpecialTagName                                       gui=reverse
"hi html gui=reverse
"hi htmlTagName                                              gui=NONE guifg=#90b0d1 guibg=#000033
"hi htmlEndTag                                               gui=NONE guifg=#000000 guibg=#ffffff
"
