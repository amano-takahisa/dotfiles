local keymap = vim.keymap.set

keymap('n', 'g]', vim.diagnostic.goto_prev)
keymap('n', 'g]', vim.diagnostic.goto_next)
