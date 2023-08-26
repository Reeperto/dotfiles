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
	-- UI Overhaul
	{
		'stevearc/dressing.nvim',
		opts = {},
	}
}
