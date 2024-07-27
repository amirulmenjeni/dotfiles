return {
    {
        "m4xshen/autoclose.nvim",
        lazy = false,
        priority = 2000,
        config = function()
            require("autoclose").setup()
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        priority = 2500,
        config = function()
            vim.keymap.set('n', '<C-p>', ':NvimTreeToggle<CR>')

            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"

                -- When quitting neovim by running `:q`, if NvimTree is open, you
                -- have to run `:q` again before completely existing neovim. This
                -- function helps avoid that.
                local function close_nvim_tree_and_quit()
                    if vim.fn.exists(':NvimTreeClose') == 2 then
                        vim.cmd('NvimTreeClose')
                    end
                    vim.cmd('quit')
                end

                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- When running
                vim.api.nvim_create_autocmd('QuitPre', {
                    callback = close_nvim_tree_and_quit,
                })

                -- custom mappings
                vim.keymap.set('n', '<C-n>',    api.tree.toggle,                    opts('Toggle nvim-tree'))
                vim.keymap.set('n', '<C-t>',    api.tree.change_root_to_parent,     opts('Up'))
                vim.keymap.set('n', '?',        api.tree.toggle_help,               opts('Help'))
            end

            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
                on_attach = my_on_attach,
            })
        end,
    },
    {
        "romgrk/barbar.nvim",
        lazy = false,
        priority = 2800,
        dependencies = {
            "lewis6991/gitsigns.nvim",     -- Optional for git status
            "nvim-tree/nvim-web-devicons", -- Optional for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- animation = true,
            -- insert_at_start = true,
            
            -- Set the filetypes which barbar will offset itself for
            sidebar_filetypes = {
                NvimTree = true,
            }
        },
    },
    {
	-- IMPORTANT: Ensure the external dependencies are installed (see `:checkhealth telescope`):
	-- 	- ripgrep (https://github.com/BurntSushi/ripgrep.git)
	-- 	-	pacman -S ripgrep
	--	- fd 	  (https://github.com/sharkdp/fd.git)
	--	-	pacman -S fd

        "nvim-telescope/telescope.nvim",
        tag = '0.1.8',
        lazy = false,
        priority = 2900,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        priority = 2600,
    }
}
