vim.pack.add {
  'https://github.com/andrewferrier/wrapping.nvim',
}

require('wrapping').setup {
  softener = {
    markdown = true,
  },
}
