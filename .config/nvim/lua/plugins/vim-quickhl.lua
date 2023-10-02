return {
    "t9md/vim-quickhl",

    lazy = false,

    keys = {
        {"<Leader>m", "<Plug>(quickhl-manual-this)", mode = "n", noremap = true},
        {"<Esc><Esc><Esc>", "<Plug>(quickhl-manual-reset)", mode = "n", noremap = true},
        {"<Leader>n", "<Plug>(quickhl-manual-go-to-next)", mode = "n", noremap = true},
        {"<Leader>N", "<Plug>(quickhl-manual-go-to-prev)", mode = "n", noremap = true}
    }
}
