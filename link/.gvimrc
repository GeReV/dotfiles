set go-=T " Hide toolbar
set go-=r " Hide right scrollbar
set go-=L " Hide left scrollbar

" Use the Solarized Dark theme
set background=dark
colorscheme solarized
" Use 14pt Monaco
set guifont=Monaco:h14
" Don’t blink cursor in normal mode
set guicursor=n:blinkon0
" Better line-height
set linespace=8

if has('win32')
  " My favorite font!
  " set guifont=M+_1m_for_Powerline:h12

  " Alt-[, ]: Buffer Navigation
  nmap <M-[> :bprev<CR>
  nmap <M-]> :bnext<CR>
  vmap <M-[> <Esc>:bprev<CR>
  vmap <M-]> <Esc>:bnext<CR>
  vmap <M-cr> <Esc>:set invfu<cr>gv
else
  let s:uname = system("echo -n \"$(uname -s)\"")
  if s:uname == "Linux"
    set guifont=Iosevka\ Term\ 12
  else " OSX
    " My favorite font!
    " set guifont=M+\ 1m\ regular\ Nerd\ Font\ Complete:h16

    " Cmd-[, ]: Buffer Navigation
    nmap <D-[> :bprev<CR>
    nmap <D-]> :bnext<CR>
    vmap <D-[> <Esc>:bprev<CR>
    vmap <D-]> <Esc>:bnext<CR>

    " Cmd-T: New buffer
    macm File.New\ Tab key=<nop>
    nmap <D-t> :enew<CR>
    vmap <D-t> <Esc>:enew<CR>

    " Cmd-Enter: Toggle Fullscreen
    nmap <d-cr> :set invfu<cr>
    vmap <d-cr> <Esc>:set invfu<cr>gv
  endif
endif
