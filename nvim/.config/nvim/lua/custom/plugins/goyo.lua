vim.pack.add {
  'https://github.com/junegunn/goyo.vim',
}

vim.g.goyo_width = 100
vim.g.goyo_height = '90%'
vim.g.goyo_linenr = 0

vim.keymap.set('n', '<leader>zg', '<cmd>Goyo<CR>', { desc = 'Toggle Goyo' })
