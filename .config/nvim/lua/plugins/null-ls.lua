local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- spell check
        -- null_ls.builtins.completion.spell,
        -- null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.code_actions.cspell,
        -- Python
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.pylama,
        null_ls.builtins.formatting.autopep8.with({
            extra_args = {"--aggressive", "--aggressive" },
        }),
        -- Markdown
        null_ls.builtins.diagnostics.markdownlint,
    },
})
