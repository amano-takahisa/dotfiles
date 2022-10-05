local options = {
    -- UI left
    number = true,
    numberwidth = 2,
    relativenumber = true,

    -- UI top
    title = true,

    -- UI right

    -- UI bottom
    cmdheight = 2,  -- from v0.8, 0 is available. 

    -- mouse, clip board integration
    clipboard = "unnamedplus",
    mouse="a",

    -- cursor
    cursorline = false,
    scrolloff = 8,
    sidescrolloff = 8,

    -- floating window
    winblend = 20,
    pumblend = 20,

    -- search
    ignorecase = true,
    smartcase = true,

    -- indent, tabs
    smartindent = true,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,

    -- backup, swap
    swapfile = false,
    undofile = true,

    -- colors
    termguicolors = true,

}

for k, v in pairs(options) do
  vim.opt[k] = v
end


