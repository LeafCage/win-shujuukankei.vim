let s:save_cpo = &cpo| set cpo&vim
"=============================================================================

function! Shujuu#Raise_all(vart) "{{{
  for winnr in range(1, winnr('$'))
    let shujuu = getwinvar(winnr, 'shujuu')
    if shujuu < g:shujuu_top
      continue
    endif
    let n = shujuu-a:vart
    let shujuu = n < g:shujuu_top ? g:shujuu_top : n
    call setwinvar(winnr, 'shujuu', shujuu)
  endfor
  redraw!
endfunction
"}}}

function! Shujuu#Raise(vart) "{{{
  let n = w:shujuu-a:vart
  let w:shujuu = n < g:shujuu_top ? g:shujuu_top : n > g:shujuu_bottom ? g:shujuu_bottom : n
endfunction
"}}}

function! Shujuu#Exchange() "{{{
  let otherwinnr = input('input otherwinnr (if you want to cancel, input '0'): ',)
  if otherwinnr = '0' || otherwinnr =~ '\d\+'
    return
  endif

  let otherwin_shujuu = getwinvar(otherwinnr, 'shujuu')
  if empty(otherwin_shujuu)
    return
  endif
  call setwinvar(otherwinnr, 'shujuu', w:shujuu)
  let w:shujuu = otherwin_shujuu
endfunction
"}}}


"=============================================================================
let &cpo = s:save_cpo| unlet s:save_cpo
