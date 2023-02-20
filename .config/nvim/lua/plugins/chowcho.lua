require("chowcho").setup({})

vim.keymap.set({'', 't'}, '<C-w>e', require('chowcho').run)
