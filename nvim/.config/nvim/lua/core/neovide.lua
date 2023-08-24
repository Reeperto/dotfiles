if vim.g.neovide then
	local utils = require("utils")

	-- Font
	vim.o.guifont = "PragmataPro Mono Liga:h16"

	-- Padding
	vim.g.neovide_padding_top = 20
	vim.g.neovide_padding_bottom = 20
	vim.g.neovide_padding_left = 20
	vim.g.neovide_padding_right = 20

	-- FPS
	vim.g.neovide_refresh_rate = 90
	vim.g.neovide_refresh_rate_idle = 10

	-- MacOS / Keys
	vim.g.neovide_input_use_logo = 1
	vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
	vim.keymap.set('v', '<D-c>', '"+y') -- Copy
	vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
	vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	vim.keymap.set('i', '<D-v>', '<ESC>"+Pi') -- Paste insert mode

	-- Animations
	vim.g.neovide_cursor_animation_length = 0.02
	vim.g.neovide_curosr_trail_size = 0.2
end
