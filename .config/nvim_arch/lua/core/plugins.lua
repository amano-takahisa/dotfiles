-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A File Explorer For Neovim Written In Lua
  use {
  'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
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


  use 'williamboman/nvim-lsp-installer'
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
    -- All the lua functions I don't want to write twice.
    use "nvim-lua/plenary.nvim"

    use {
  'nvim-telescope/telescope.nvim',  branch = '0.1.x',
-- or                            , tag = '0.1.0',
  requires = { {'nvim-lua/plenary.nvim'} }
}
end)
