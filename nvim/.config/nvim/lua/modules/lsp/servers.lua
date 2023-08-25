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
			version = 'Lua 5.1',
			path = vim.fn.split(vim.fn.getenv('LUA_PATH'), ';')
		},
		workspace = {
			library = {
				vim.fn.expand '~/.luarocks/share/lua/5.1',
				vim.fn.expand '~/.lua/addons/pl-definitions/library',
				vim.fn.expand '~/.lua/addons/lapis-definitions/library'
			},
			userThirdParty = {
				vim.fn.expand '~/.lua/addons'
			}
		}
	}
}
M.tsserver = {}
M.tailwindcss = {}
M.html = {}
M.emmet_language_server = {}

M.texlab = {}
M.wgsl_analyzer = {}
M.taplo = {}

return M
