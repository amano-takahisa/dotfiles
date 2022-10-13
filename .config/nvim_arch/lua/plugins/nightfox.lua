local plug_ok, _ = pcall(require, "nightfox")
if not plug_ok then return end

-- set color scheme
-- vim.cmd('colorscheme duskfox')
vim.cmd('colorscheme nightfox')
