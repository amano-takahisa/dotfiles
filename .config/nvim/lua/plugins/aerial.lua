vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle! float<CR>")
vim.keymap.set("n", "<leader>an", "<cmd>AerialNavToggle<CR>")
return {
    "stevearc/aerial.nvim",
    opts = {
        float = {
            -- Controls border appearance. Passed to nvim_open_win
            border = "rounded",

            -- Determines location of floating window
            --   cursor - Opens float on top of the cursor
            --   editor - Opens float centered in the editor
            --   win    - Opens float centered in the window
            relative = "win",

            -- These control the height of the floating window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_height and max_height can be a list of mixed types.
            -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
            max_height = 0.9,
            height = nil,
            min_height = { 8, 0.1 },

            override = function(conf, source_winid)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                local padding = 1
                conf.zindex = 25
                conf.anchor = "NE"
                conf.row = padding
                conf.col = vim.api.nvim_win_get_width(source_winid) - padding
                return conf
            end,
        },
        nav = {
            -- Jump to symbol in source window when the cursor moves
            autojump = true,
            -- Show a preview of the code in the right column, when there are no child symbols
            preview = true,
        },
        -- When true, aerial will automatically close after jumping to a symbol
        close_on_select = false,
    },
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
