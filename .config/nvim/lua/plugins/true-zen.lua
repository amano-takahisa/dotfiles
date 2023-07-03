require("true-zen").setup({})

-- shortcut key
local keymap = vim.keymap.set
keymap('n', '<c-w>z', '<cmd>TZFocus<cr>')
