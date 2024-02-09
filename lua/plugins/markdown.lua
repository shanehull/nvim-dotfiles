return {
    {
        "vim-pandoc/vim-pandoc",
        dependencies = { "vim-pandoc/vim-pandoc-syntax" },
    },
    {
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
    },
}
