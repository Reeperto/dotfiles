local map = vim.keymap.set

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.o.expandtab = true

vim.o.relativenumber = true
vim.o.numberwidth = 1
vim.o.colorcolumn = '80'
vim.o.signcolumn = 'no'

map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')
