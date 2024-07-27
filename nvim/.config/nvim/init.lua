require('config.lazy')

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.termguicolors = true

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.keymap.set('n', 'J', '10j')
vim.keymap.set('n', 'K', '10k')

vim.keymap.set('v', 'J', '10j')
vim.keymap.set('v', 'K', '10k')
