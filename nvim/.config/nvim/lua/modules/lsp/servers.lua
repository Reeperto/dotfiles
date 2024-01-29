local M = {}

M.rust_analyzer = {
	formatter = true,
}
M.clangd = {}
M.zls = {}
M.gopls = {}
M.omnisharp = {
	enable_roslyn_analyzers = true,
}

M.pyright = {}

M.lua_ls = {
	formatter = true,
	Lua = {
		runtime = {
			version = "Lua 5.1",
			path = vim.fn.split(vim.fn.getenv("LUA_PATH"), ";"),
		},
		workspace = {
			library = {
				vim.fn.expand("~/.luarocks/share/lua/5.1"),
				-- vim.fn.expand("~/.lua/addons/pl-definitions/library"),
				-- vim.fn.expand("~/.lua/addons/lapis-definitions/library"),
			},
			userThirdParty = {
				vim.fn.expand("~/.lua/addons"),
			},
		},
	},
}

M.uiua = {
	full_config = true,
	filetypes = { "ua", "uiua" }
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
			emmetCompletions = false,
		},
	},
	filetypes = { "etlua", "css", "svelte", "js", "ts", "html" },
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

-- M.texlab = {}
M.wgsl_analyzer = {}
M.taplo = {}

return M
