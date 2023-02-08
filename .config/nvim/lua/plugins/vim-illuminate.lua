local illuminate_augroup = vim.api.nvim_create_augroup("illuminate_augroup", {
    clear = false
})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    -- command = "hi illuminatedWordText gui=bold guibg=#4f536d",
    command = "hi illuminatedWordText gui=bold guibg=#000000",
    group = illuminate_augroup
})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    -- command = "hi illuminatedWordRead gui=bold guibg=read",
    command = "hi illuminatedWordRead gui=bold guibg=#000000",
    group = illuminate_augroup
})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    -- command = "hi illuminatedWordWrite gui=bold guibg=blue",
    command = "hi illuminatedWordWrite gui=bold,underline guibg=#000000",
    group = illuminate_augroup
})
