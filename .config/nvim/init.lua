require("config.keymap")
require("config.options")
require("config.lazy")

local imeScriptPath = vim.fn.expand("~/.config/nvim/ime.vim")
if vim.fn.filereadable(imeScriptPath) == 1 then
    -- show message
    vim.cmd("source " .. imeScriptPath)
end

-- remove keymap which conflicts with activation of IME
vim.keymap.set("i", "<C-Space>", "<Nop>")
