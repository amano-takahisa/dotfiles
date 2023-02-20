require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "yamlls",
    },
    automatic_installation = true,
})

