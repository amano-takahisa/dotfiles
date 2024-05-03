-- if true then return {} end
return {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        -- Register linters and formatters per language
        local eslint = require("efmls-configs.linters.eslint")
        local prettier = require("efmls-configs.formatters.prettier")
        local stylua = require("efmls-configs.formatters.stylua")
        local ruff = require("efmls-configs.formatters.ruff")
        local isort = require("efmls-configs.formatters.isort")
        local jq_linter = require("efmls-configs.linters.jq")
        local jq_formatter = require("efmls-configs.formatters.jq")
        local languages = {
            typescript = { eslint, prettier },
            lua = { stylua },
            python = { ruff, isort },
            json = { jq_linter, jq_formatter },
        }

        -- Or use the defaults provided by this plugin
        -- check doc/SUPPORTED_LIST.md for the supported languages
        --
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
}
