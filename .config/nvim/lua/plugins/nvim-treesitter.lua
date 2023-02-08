local plug_ok, plug = pcall(require, "nvim-treesitter.configs")
if not plug_ok then return end


plug.setup {
    ensure_installed = { 'python', 'lua', 'markdown' },
    sync_install = true,
    auto_install = true,

    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
}
