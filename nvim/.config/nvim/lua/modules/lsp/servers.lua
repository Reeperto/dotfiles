local M = {}

M.rust_analyzer = {}
M.clangd = {}
M.zls = {}
M.gopls = {}
M.csharp_ls = {}

M.pyright = {}

M.lua_ls = {
	Lua = {
		runtime = {
			version = "Lua 5.1",
			path = vim.fn.split(vim.fn.getenv("LUA_PATH"), ";"),
		},
		workspace = {
			library = {
				vim.fn.expand("~/.luarocks/share/lua/5.1"),
				vim.fn.expand("~/.lua/addons/pl-definitions/library"),
				vim.fn.expand("~/.lua/addons/lapis-definitions/library"),
			},
			userThirdParty = {
				vim.fn.expand("~/.lua/addons"),
			},
		},
	},
}
M.tailwindcss = {
	full_config = true,
	init_options = {
		userLanguages = {
			etlua = "html-eex",
			["html.etlua"] = "html-eex",
		},
	},
	settings = {
		tailwindCSS = {
			includeLanguages = {
				["html.etlua"] = "html-eex",
				["etlua"] = "html-eex",
				["lua"] = "html-eex",
			},
			emmetCompletions = true,
		},
	},
	filetypes = { "etlua" },
}
M.emmet_language_server = {
	full_config = true,
	filetypes = { "etlua", "html" },
}
M.html = {
	full_config = true,
	filetypes = { "etlua", "html" },
}
M.tsserver = {}
M.svelte = {}
M.jsonls = {}
-- M.unocss = {}

M.texlab = {}
M.wgsl_analyzer = {}
M.taplo = {}

return M
