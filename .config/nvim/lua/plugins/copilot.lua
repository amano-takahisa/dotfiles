return {
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_filetypes = {
                gitcommit = true,
                markdown = true,
                yaml = true,
            }
        end,
    },
}
