return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"p00f/clangd_extensions.nvim",
		{
			"DNLHC/glance.nvim",
			config = function()
				local glance = require("glance")
				glance.setup({
					border = {
						enable = true,
						top_char = '―',
						bottom_char = '―',
					},
					theme = {
						enable = true,
						mode = 'auto',
					},
				})
			end
		},
		{
			'saecki/crates.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('crates').setup()
				local cmp = require('cmp')

				vim.api.nvim_create_autocmd("BufRead", {
					group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
					pattern = "Cargo.toml",
					callback = function()
						cmp.setup.buffer({ sources = { { name = "crates" } } })
					end,
				})
			end,
		}
	},
	config = function()
		local configurations = require("modules.lsp.servers")

		require("neodev").setup()
		require("mason").setup()
		require("mason-lspconfig").setup()

		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		require("clangd_extensions").setup()

		for server, settings in pairs(configurations) do
			lspconfig[server].setup({
				settings = settings,
				capabilities = capabilities
			})
		end

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Prevents weird window shifting when diagnostics appear
				vim.o.signcolumn = "yes"

				local keymap = vim.keymap.set
				local opts = { buffer = ev.buf }

				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("n", "gr", vim.lsp.buf.rename, opts)
				keymap("n", "gd", "<CMD>Glance definitions<CR>", opts)
				keymap("n", "gi", "<CMD>Glance implementations<CR>", opts)
				keymap("n", "gR", "<CMD>Glance references<CR>")
				keymap("n", "gt", "<CMD>Glance type_definitions<CR>", opts)
				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "<Leader>F", vim.lsp.buf.format, opts)
			end,
		})
	end
}
