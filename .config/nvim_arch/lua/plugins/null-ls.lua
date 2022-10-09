local plug_ok, plug = pcall(require, "null-ls")
if not plug_ok then return end


plug.setup({
        sources = {
        plug.builtins.formatting.stylua,
        plug.builtins.diagnostics.eslint,
        plug.builtins.completion.spell,
        plug.builtins.formatting.isort,
    },
})
