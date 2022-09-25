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

end)