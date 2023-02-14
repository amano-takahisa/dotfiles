local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
    -- External package Installer
    {
        "williamboman/mason.nvim",
        event = "BufReadPre",
        config = function()
            require("plugins/mason")
        end,
    },

    -- Browse the file system and other tree like structures
    {
        "nvim-neo-tree/neo-tree.nvim",
        config = function()
            require("plugins/neo-tree")
        end,
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-tree/nvim-web-devicons"}, -- not strictly required, but recommended
            {"MunifTanjim/nui.nvim"},
        }
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        event = { "VimEnter" },
        config = function()
            require("plugins/telescope")
        end,
        dependencies = {
            {"nvim-telescope/telescope-live-grep-args.nvim"},
        },
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require"telescope".load_extension("frecency")
        end,
        dependencies = {
            {"kkharji/sqlite.lua"},
        }
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        config = function()
            require("plugins/lualine")
        end,
    },

    -- Language Server Protocol(LSP)
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre" },
        config = function()
            require("plugins/nvim-lspconfig")
        end,
        dependencies = {
            {
                "folke/neoconf.nvim",
                config = function()
                    require("plugins/neoconf")
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("plugins/mason-lspconfig")
                end,
            },
            { "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" },
        },
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VimEnter",
        config = function()
            require("plugins/null-ls")
        end,
        dependencies = {
            {"nvim-lua/plenary.nvim"},
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost" },
        config = function()
            require("plugins/nvim-treesitter")
        end,
    },

    -- adds indentation guides to all lines (including empty lines).
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins/indent-blankline")
        end,
    },

    -- ColorScheme
    {
        "EdenEast/nightfox.nvim",
        event = { "BufReadPre", "BufWinEnter" },
        config = function()
            require("plugins/nightfox")
        end,
    },


    -- Git
    {
        "TimUntersberger/neogit",
        event = "BufReadPre",
        config = function()
            require("plugins/neogit")
        end,
    },

    {
        "dinhhuy258/git.nvim",
        event = "BufReadPre",
        config = function()
            require("plugins/git")
        end,
    },
}


require("lazy").setup(plugins)
