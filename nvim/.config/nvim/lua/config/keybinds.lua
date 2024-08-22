local set = vim.keymap.set

set("n", "|", vim.cmd.vsplit, {})
set("n", "\\", vim.cmd.split, {})

set("n", "<leader>q", vim.cmd.quit, {})
set("n", "<leader>Q", Utils.func.delay(vim.cmd, [[:q!]]), {})
set("n", "<leader>w", vim.cmd.write, {})
set("n", "<leader>m", vim.cmd.make, {})
