-- set log
-- to see logs, `:LspLog`
-- vim.lsp.set_log_level("debug")

-- core
require('core.plugins')
-- require('core.disable_builtin')
require('core.options')
-- require('core.autocmds')
require('core.keymaps')

-- plugin settings
require('plugins.neo-tree')
require('plugins.lualine')
require('plugins.nvim-treesitter')
require('plugins.indent-blankline')
require('plugins.mason')
require('plugins.mason-lspconfig')
require('plugins.nvim-lspconfig')
require('plugins.nvim-cmp')
require('plugins.telescope')
require('plugins.nightfox')
require('plugins.tokyonight')
require('plugins.neogit')
require('plugins.null-ls')
require('plugins.symbols-outline')
require('plugins.vim-illuminate')
require('plugins.git')