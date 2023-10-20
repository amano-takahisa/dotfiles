-- if true then return {} end
return {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        -- Register linters and formatters per language
        local eslint = require("efmls-configs.linters.eslint")
        local prettier = require("efmls-configs.formatters.prettier")
        local stylua = require("efmls-configs.formatters.stylua")
        local autopep8 = require('efmls-configs.formatters.autopep8')
        local languages = {
            typescript = { eslint, prettier },
            lua = { stylua },
            python = {autopep8}
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
