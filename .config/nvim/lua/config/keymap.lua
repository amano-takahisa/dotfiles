local keymap = vim.keymap.set

-- Leader key
keymap("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Mode
--   Exit from terminal mode with Exc Esc.
keymap("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Buffer
--   Switch buffers
keymap("n", "<C-j>", ":bnext<CR>")
keymap("n", "<C-k>", ":bprevious<CR>")

--   Close a buffer without closing a window
keymap("n", "<C-c>", ":bprevious<bar>bdelete #<CR>")

-- Appearance
--   Toggle line number
keymap("n", "<F3>", ":<C-u>setlocal relativenumber!<CR>")

-- Caret move
keymap("n", "j", "gj")
keymap("n", "gj", "j")
keymap("n", "k", "gk")
keymap("n", "gk", "k")

-- Clip board
keymap("v", '"+y', ":!xclip -f -sel clip")
-- Yank file path and line number
-- keymap('n', '<leader>y', [[:let @+=expand("%") . ':' . line(".")<CR>]])
keymap("n", "<leader>y", function()
    local path = vim.fn.expand("%") .. ":" .. vim.fn.line(".")
    vim.fn.setreg("+", path)
end)

-- Search
--   Highlight off
keymap("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>")
-- Move cursor line to center after seach
-- keymap('n', 'n', 'nzz')
-- keymap('n', 'N', 'Nzz')
-- keymap('n', '*', '*zz')
-- keymap('n', '#', '#zz')
