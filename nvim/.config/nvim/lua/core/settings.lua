vim.o.relativenumber = true
vim.o.conceallevel = 2
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.breakindent = true
-- vim.o.colorcolumn = "80"

vim.o.undofile = true

vim.filetype.add({
    extension = {
        frag = "glsl",
        vert = "glsl"
    }
})

vim.cmd([[
filetype on
filetype plugin on
filetype indent on
]])
