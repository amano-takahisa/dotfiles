if true then return {} end

-- #### magit for neovim ####

return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",     -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim",    -- optional
        "ibhagwan/fzf-lua",          -- optional
    },
    config = true
}
