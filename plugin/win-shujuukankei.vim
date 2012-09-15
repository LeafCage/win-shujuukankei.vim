let s:save_cpo = &cpo| set cpo&vim
"=============================================================================

noremap <silent><Plug>(win-shujuukankei-Dokuritsu) :<C-u>call Shujuu#Dokuritsu(0)<CR>
noremap <silent><Plug>(win-shujuukankei-Gekokujo) :<C-u>call Shujuu#Dokuritsu(1)<CR>

noremap <silent><Plug>(win-shujuukankei-Raise_all) :<C-u>call Shujuu#Raise_all(1)<CR>
noremap <silent><Plug>(win-shujuukankei-Raise) :<C-u>call Shujuu#Raise(1)<CR>
noremap <silent><Plug>(win-shujuukankei-Lower) :<C-u>call Shujuu#Raise(-1)<CR>
noremap <silent><Plug>(win-shujuukankei-Exchange) :<C-u>call Shujuu#Exchange()<CR>

let g:shujuu_top = exists('g:shujuu_top') ? g:shujuu_top : 0
let g:shujuu_bottom = exists('g:shujuu_bottom') ? g:shujuu_bottom : 2

let s:mmr_LeavedShujuu = 1

aug win_shujuukankei
  au!
  au VimEnter * let w:shujuu = g:shujuu_top
  au CmdwinEnter * let w:shujuu = g:shujuu_bottom
  au WinLeave * let s:mmr_LeavedShujuu = w:shujuu
  au WinEnter * call s:WinEnter()
  au TabEnter * if !exists('w:shujuu')|let w:shujuu = g:shujuu_top|endif
aug END

function! s:WinEnter() "{{{
  if !exists('w:shujuu')
    let shujuu = s:mmr_LeavedShujuu + 1
    let w:shujuu = shujuu > g:shujuu_bottom ? g:shujuu_bottom : shujuu
  endif

  call s:__autoRaise()
endfunction
"}}}


function! s:__autoRaise() "{{{
  let highest = 127
  for winnr in range(1, winnr('$'))
    let ged_shujuu = getwinvar(winnr, 'shujuu')
    if ged_shujuu < g:shujuu_top
      continue
    endif
    let highest = highest > ged_shujuu ? ged_shujuu : highest
  endfor

  if highest <= g:shujuu_top
    return
  endif
  call Shujuu#Raise_all(highest-g:shujuu_top)
endfunction
"}}}






"=============================================================================
let &cpo = s:save_cpo| unlet s:save_cpo

