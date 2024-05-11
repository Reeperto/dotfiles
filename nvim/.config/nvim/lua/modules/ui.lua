return {
	-- Colorscheme
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
			vim.cmd [[colorscheme gruvbox-material]]
		end
	},
    {
        "ellisonleao/gruvbox.nvim",
        config = {
            contrast = "hard",
        }
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
