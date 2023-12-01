autocmd InsertLeave * call Disable()
function! Disable() abort
    call system('fcitx5-remote -c')
endfunction
