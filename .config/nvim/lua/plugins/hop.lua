return {
    "phaazon/hop.nvim",
    opts = function()
        local keymap = vim.keymap.set
        keymap("n", "<leader>hw", "<cmd>HopWordMW<cr>")
        keymap("n", "<leader>h", "<cmd>HopChar2MW<cr>")
        keymap("n", "<leader>h2", "<cmd>HopChar2MW<cr>")
        keymap("n", "<leader>h1", "<cmd>HopChar1MW<cr>")
    end,
}
