return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        direction = "float",
    },
    keys = {
        { "<F4>", "<cmd>execute  v:count . \"ToggleTerm dir='%:p:h'\"<CR>", desc = "Open terminal" },
    },
}
