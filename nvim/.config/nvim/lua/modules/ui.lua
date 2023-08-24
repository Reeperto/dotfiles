return {
	-- Colorscheme
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.cmd [[colorscheme gruvbox-material]]
		end
	},
	-- Icons
	{ "nvim-tree/nvim-web-devicons" },
	-- Statusbar
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({})
		end
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require('dressing').setup({
				input = {
					enabled = true,
				},
				select = {
					enabled = true,
				},
			})
		end
	}
}
