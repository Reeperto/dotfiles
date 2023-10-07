local map = vim.keymap.set

map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>d", "<cmd>bd<CR>")
map("n", "<leader>Q", "<cmd>q!<CR>")
map("n", "<leader>D", "<cmd>bd!<CR>")
map("n", "\\", "<cmd>split<CR>")
map("n", "|", "<cmd>vsplit<CR>")
map("n", "<leader>sf", "<cmd>Telescope find_files<CR>")
