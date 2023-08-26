local servers = {}

return {
	{
		"mhartington/formatter.nvim",
		config = function()
			servers.lua = require("formatter.filetypes.lua").stylua
			servers.c = require("formatter.filetypes.c").clangformat
			servers.cpp = servers.c
			servers.objc = servers.c

			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.ERROR,
				filetype = servers,
			})
		end,
	},
}
