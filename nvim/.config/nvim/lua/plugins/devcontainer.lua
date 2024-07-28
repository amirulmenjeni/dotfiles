return {
    {
        "https://codeberg.org/esensar/nvim-dev-container",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require('devcontainer').setup {
                container_runtime = "docker",
            }
        end,
    },
}
