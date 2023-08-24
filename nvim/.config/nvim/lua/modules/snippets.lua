return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	config = function()
		require("luasnip").setup({
			enable_autosnippets = true
		})
		require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
	end
}
