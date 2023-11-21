local cmp = require("cmp")

-- Allows VimTex autocompletion instead of a seperate LSP
---@diagnostic disable-next-line
cmp.setup.buffer {
	sources = {
		{ name = 'omni' },
		{ name = 'luasnip' },
	},
}
