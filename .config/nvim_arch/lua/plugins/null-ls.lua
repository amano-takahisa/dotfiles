local plug_ok, plug = pcall(require, "null-ls")
if not plug_ok then return end



plug.setup({
    root_dir = git_root_dir,
    sources = {
        plug.builtins.formatting.sumneko_lua,
        plug.builtins.diagnostics.eslint,
        plug.builtins.completion.spell,
        -- plug.builtins.formatting.isort,
        plug.builtins.formatting.autopep8.with({
            'aggressive',
            'aggressive'
        }),

    },
})
