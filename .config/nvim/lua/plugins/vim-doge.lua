if true then return {} end
return {
    "kkoomen/vim-doge",
    event = "BufRead",
    config = function()
        vim.cmd([[call doge#install()]])
        vim.g.doge_doc_standard_python = "numpy"

        vim.g.doge_python_settings = {
            single_quotes = 0,
            omit_redundant_param_types = 1,
        }
    end,
}
