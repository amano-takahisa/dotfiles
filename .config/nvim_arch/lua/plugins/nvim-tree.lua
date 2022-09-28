-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

local plug_ok, plug = pcall(require, "nvim-tree")
if not plug_ok then return end

plug.setup({
    open_on_setup = true,
  sort_by = "case_sensitive",
  view = {
    -- adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
      ignore = false
  }
})
