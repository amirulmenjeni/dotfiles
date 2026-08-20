vim.pack.add {
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
}

-- vim-dadbod-ui stores saved database connections here.
vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/dadbod-ui'
vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font and 1 or 0

vim.keymap.set('n', '<leader>du', '<cmd>DBUIToggle<CR>', { desc = '[D]atabase UI toggle' })
vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<CR>', { desc = '[D]atabase find buffer' })
vim.keymap.set('n', '<leader>dr', '<cmd>DBUIRenameBuffer<CR>', { desc = '[D]atabase rename buffer' })
vim.keymap.set('n', '<leader>dl', '<cmd>DBUILastQueryInfo<CR>', { desc = '[D]atabase last query info' })

-- Quick helper for DuckDB files. Usage: :DuckDB path/to/file.duckdb
-- If no path is provided, it uses the current file.
vim.api.nvim_create_user_command('DuckDB', function(opts)
  local path = opts.args ~= '' and opts.args or vim.fn.expand '%:p'
  if path == '' then
    vim.notify('Usage: :DuckDB path/to/file.duckdb', vim.log.levels.ERROR)
    return
  end

  path = vim.fn.fnamemodify(path, ':p')
  vim.g.db = 'duckdb:' .. path
  vim.cmd 'DBUI'
end, {
  nargs = '?',
  complete = 'file',
  desc = 'Open a DuckDB database in dadbod-ui',
})
