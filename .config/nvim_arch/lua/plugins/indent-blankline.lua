local plug_ok, plug = pcall(require, "indent_blankline")
-- if not plug_ok then return end

vim.opt.list = true
vim.opt.listchars:append 'space:.'

plug.setup {
    space_char_blankline = ' ',
    show_current_context = true,
    show_current_context_start = true
}

