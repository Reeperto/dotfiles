vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.conceallevel = 2

-- Tabs are so confusing :(
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.cmd [[colorscheme carbonfox]]

vim.filetype.add({
    extension = {
        m = "objc",
        mm = "objcpp",
        c3 = "c3",
        c3i = "c3",
        c3t = "c3",
    }
})
