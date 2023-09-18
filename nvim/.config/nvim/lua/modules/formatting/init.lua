local servers = {}

return {
	{
		"mhartington/formatter.nvim",
		config = function()
			local util = require("formatter.util")

			servers.lua = require("formatter.filetypes.lua").stylua
			servers.c = function()
				return {
					exe = "clang-format",
					args = {
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
						-- "--style=" .. "file:" .. util.escape_path(
						-- 	vim.fn.stdpath("config") .. "/lua/modules/formatting/.clang-format"
						-- ),
					},
					stdin = true,
					try_node_modules = true,
				}
			end
			servers.cpp = servers.c
			servers.objc = servers.c
			servers.rust = require("formatter.filetypes.rust").rustfmt

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.ERROR,
				filetype = servers,
			})
		end,
	},
}
