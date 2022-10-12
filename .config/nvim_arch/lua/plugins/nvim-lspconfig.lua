local keymap = vim.keymap.set

keymap('n', 'g[', vim.diagnostic.goto_prev)
keymap('n', 'g]', vim.diagnostic.goto_next)


require 'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }

}
