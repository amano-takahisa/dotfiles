local plug_ok, plug = pcall(require, "mason-lspconfig")
if not plug_ok then return end

plug.setup(
    {
        ensure_installed = {
            "pyright",
            "lua_ls",
            "marksman",
            "rust_analyzer",
            "yamlls",
        },
        automatic_installation = true,
    }
)
