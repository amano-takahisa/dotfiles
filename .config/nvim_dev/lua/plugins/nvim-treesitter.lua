require("nvim-treesitter.configs").setup({
	-- ensure_installed = "all", -- one of 'all', 'language', or a list of languages
	ensure_installed = {
        "bash", "dockerfile", "gitcommit", "gitignore",
        "json", "markdown", "rust", "python", "rst", "toml", "yaml",
    },
    sync_install = true,
    auto_install = true,

    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
})