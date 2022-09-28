-- local alias
local opts = { noremap = true, silent = true}
local keymap = vim.keymap.set

-- Usage: keymap(<MODE>, <KEY1>, <KEY2>, opts) changes KEY2 to KEY1.
-- Modes:
--   'n' : normal mode
--   'i' : insert mode
--   'v' : visual mode
--   'x' : visual block mode
--   't' : terminal mode
--   'c' : command mode


-- Plugin: nvim-tree
-- Toggle tree window
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)


-- Mode
--   Exit from terminal mode with Exc Esc.
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', opts)


-- Buffer
--   Switch buffers
keymap('n', '<C-j>', ':bnext<CR>', opts)
keymap('n', '<C-k>', ':bprevious<CR>', opts)

--   Close a buffer without closing a window
keymap('n', '<C-c>', ':bprevious<bar>bdelete #<CR>', opts)


-- Appearance
--   Toggle line number
keymap('n', '<F3>', ':<C-u>setlocal relativenumber!<CR>')


-- Caret move
keymap('n', 'j', 'gj')
keymap('n', 'gj', 'j')
keymap('n', 'k', 'gk')
keymap('n', 'gk', 'k')


