local plug_ok, plug = pcall(require, "neogit")
if not plug_ok then return end

local lspconfig_util = require 'lspconfig.util'
local find_root = lspconfig_util.root_pattern '.git'
local keymap = vim.keymap.set

function OpenNeogit()
    local cwd = find_root(vim.fn.expand '%:p')
    if not cwd then
        cwd = vim.fn.getcwd()
    end
    print('open ' .. cwd .. ' repository')
    plug.open { cwd = cwd}
end

keymap('n', '<leader>gg', OpenNeogit)


plug.setup({})
