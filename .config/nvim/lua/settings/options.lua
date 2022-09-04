-- ### Basic options ###
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.visualbell = true


-- ### Key maps ###
-- Switch buffers
vim.keymap.set('n', '<C-j>', ':bnext<CR>')
vim.keymap.set('n', '<C-k>', ':bprevious<CR>')

-- Close a buffer without close window
vim.keymap.set('n', '<C-c>', ':bprevious<bar>bdelete #<CR>')


-- ### Line numbers ###
vim.opt.number = true
vim.opt.relativenumber = true

-- Toggle relativenumber and absolutenumber
vim.keymap.set('n', '<F3>', ':<C-u>setlocal relativenumber!<CR>')


-- ### Line ###
vim.opt.cursorline = true


-- ### Caret move ###
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gk', 'k')


-- ### Cut and paste ###
-- Paste yanked text without yanking
vim.keymap.set('v', '<leader>p', '"_dP')

-- Copy to xclip
vim.keymap.set('v', '"+y', ':!xclip -f -sel clip')


-- ### Tab & indents
-- Show tab charactors as |...
vim.opt.listchars = { tab = '|.' }
vim.opt.list = true

