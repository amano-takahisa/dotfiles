local plug_ok, plug = pcall(require, "telescope")
if not plug_ok then return end
--
-- shortcut key
local keymap = vim.keymap.set
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')


plug.setup { 
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!{**/.git/*,**/.cache/*}" },
        }
    },
    extensions = {
        frecency = {
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/cache/*"},
            disable_devicons = false,
            workspaces = {
                ["dotfiles"] = vim.fn.expand("$HOME/dotfiles"),
                ["documents"] = vim.fn.expand("$HOME/Documents"),
                ["mantle-utils"] = vim.fn.expand("$HOME/git/mantle-utils"),
                ["mantle-workflow"] = vim.fn.expand("$HOME/git/mantle-workflow"),
            }
        }
    },
}
