-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- All the lua functions I don't want to write twice.
    use "nvim-lua/plenary.nvim"

    -- File tree
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- adds indentation guides to all lines (including empty lines).
    use 'lukas-reineke/indent-blankline.nvim'

    -- Treeshitter configuration and abstruction layer for NeoVim
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Treeshitter context
    use 'nvim-treesitter/nvim-treesitter-context'

    -- color scheme
    use 'EdenEast/nightfox.nvim'


    use  "williamboman/mason.nvim" 
    use "williamboman/mason-lspconfig.nvim"
    use 'neovim/nvim-lspconfig'

    use ({
        "hrsh7th/nvim-cmp",
        -- config = [[require('config.cmp')]], -- may very based on config
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            -- "L3MON4D3/LuaSnip", -- may very based on config
            "onsails/lspkind-nvim",
        }
    })

    use {
        'nvim-telescope/telescope.nvim',  branch = '0.1.x',
        -- or                            , tag = '0.1.0',
        requires = { 
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
        },
        config = function()
    require("telescope").load_extension("live_grep_args")
  end
    }
    use {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require"telescope".load_extension("frecency")
        end,
        requires = {"kkharji/sqlite.lua"}
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'simrat39/symbols-outline.nvim' }
end)

