-- if true then return {} end
return {
    "williamboman/mason-lspconfig",
    dependencies = "mason.nvim",
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            -- # automatic install is configured in
            -- # mason-tool-installer.lua
            -- automatic_installation = true,
            -- ensure_installed = {
            --     -- # general
            --     "efm",
            --     -- # bash
            --     -- "bashls",
            --     -- # python
            --     -- "pyright",
            -- },
        })

        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
            -- custom example
            -- ["rust_analyzer"] = function()
            --   require("rust-tools").setup({})
            -- end,

            -- https://github.com/mattn/efm-langserver#configuration-for-neovim-builtin-lsp-with-nvim-lspconfig
            ["efm"] = function()
                -- https://github.com/creativenull/efmls-configs-nvim/blob/main/README.md#setup
                -- https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md
                -- Register linters and formatters per language
                -- local eslint = require('efmls-configs.linters.eslint')
                -- local prettier = require('efmls-configs.formatters.prettier')
                local stylua = require("efmls-configs.formatters.stylua")
                local ruff = require('efmls-configs.formatters.ruff')
                local isort = require('efmls-configs.formatters.isort')
                local languages = {
                    -- typescript = { eslint, prettier },
                    lua = { stylua },
                    python = {ruff, isort},
                }
                -- Or use the defaults provided by this plugin
                -- check doc/SUPPORTED_LIST.md for the supported languages
                -- local languages = require('efmls-configs.defaults').languages()
                local efmls_config = {
                    filetypes = vim.tbl_keys(languages),
                    settings = {
                        rootMarkers = { ".git/" },
                        languages = languages,
                    },
                    init_options = {
                        documentFormatting = true,
                        documentRangeFormatting = true,
                    },
                }

                require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
                    -- Pass your custom lsp config below like on_attach and capabilities
                    --
                    -- on_attach = on_attach,
                    -- capabilities = capabilities,
                }))
            end,
        })
    end,
}
