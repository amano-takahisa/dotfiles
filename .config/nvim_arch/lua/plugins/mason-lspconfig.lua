local plug_ok, plug = pcall(require, "mason-lspconfig")
if not plug_ok then return end

plug.setup(
    {
    ensure_installed = { "pyright"}
}
)

