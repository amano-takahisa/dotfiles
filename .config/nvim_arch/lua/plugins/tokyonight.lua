local plug_ok, plug = pcall(require, "tokyonight")
if not plug_ok then return end

plug.setup()
-- vim.cmd('colorscheme nightfox')
