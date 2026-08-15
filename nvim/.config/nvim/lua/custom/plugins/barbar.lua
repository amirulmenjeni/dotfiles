vim.g.barbar_auto_setup = false

vim.pack.add {
  'https://github.com/romgrk/barbar.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
}

require('barbar').setup {}

vim.keymap.set('n', '<S-l>', '<cmd>BufferNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>BufferClose<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>BufferPick<CR>', { desc = 'Pick buffer' })
