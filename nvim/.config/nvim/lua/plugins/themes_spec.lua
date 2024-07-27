return {
    {
        "dracula/vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme dracula]])
            vim.cmd([[syntax enable]])
        end,
        enable = true,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1500,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
        enable = false,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 2000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
        enable = true,
    },
}
