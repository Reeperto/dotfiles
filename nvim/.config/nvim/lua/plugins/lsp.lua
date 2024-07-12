---@type LazySpec
return {
    {
        "nvimdev/lspsaga.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require('lspsaga').setup({})
        end,
    },
    {
        "neovim/nvim-lspconfig",
        -- event = "LazyFile",
        dependencies = {
            { "folke/neoconf.nvim",               cmd = "Neoconf", config = true, dependencies = { "nvim-lspconfig" } },
            { "folke/neodev.nvim",                opts = {} },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            ---@type vim.diagnostic.Opts
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    -- prefix = "icons",
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "E",
                        [vim.diagnostic.severity.WARN]  = "W",
                        [vim.diagnostic.severity.HINT]  = "H",
                        [vim.diagnostic.severity.INFO]  = "I"
                    },
                },
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = true,
            },
            -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the code lenses.
            codelens = {
                enabled = false,
            },
            -- Enable lsp cursor word highlighting
            document_highlight = {
                enabled = true,
            },
            -- add any global capabilities here
            capabilities = {},
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            servers = require("servers"),
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            require("neoconf").setup()
            require("mason").setup()
            require("neodev").setup()

            vim.o.signcolumn = "yes"

            -- setup autoformat
            -- LazyVim.format.register(LazyVim.lsp.formatter())

            -- setup keymaps
            Utils.lsp.on_attach(function(_, _)
                local set = vim.keymap.set

                set("n", "K", vim.lsp.buf.hover, {})
                set("n", "gd", vim.lsp.buf.definition, {})
                set("n", "gr", vim.lsp.buf.references, {})
                set("n", "<leader>r", vim.lsp.buf.rename, {})
                set("n", "<leader>F", vim.lsp.buf.format, {})
            end)

            -- LazyVim.lsp.setup()
            -- LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)
            -- LazyVim.lsp.words.setup(opts.document_highlight)

            -- diagnostics signs
            if vim.fn.has("nvim-0.10.0") == 0 then
                if type(opts.diagnostics.signs) ~= "boolean" then
                    for severity, icon in pairs(opts.diagnostics.signs.text) do
                        local name = vim.diagnostic.severity[severity]:lower():gsub("^%l",
                            string.upper)
                        name = "DiagnosticSign" .. name
                        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
                    end
                end
            end

            -- if vim.fn.has("nvim-0.10") == 1 then
            --   -- inlay hints
            --   if opts.inlay_hints.enabled then
            --     LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
            --       if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
            --         LazyVim.toggle.inlay_hints(buffer, true)
            --       end
            --     end)
            --   end

            --   -- code lens
            --   if opts.codelens.enabled and vim.lsp.codelens then
            --     LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
            --       vim.lsp.codelens.refresh()
            --       vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            --         buffer = buffer,
            --         callback = vim.lsp.codelens.refresh,
            --       })
            --     end)
            --   end
            -- end

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                    or function(diagnostic)
                        local icons = require("config.icons")
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local servers = opts.servers

            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities(),
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local mason = require("mason-lspconfig")
            local all_mslp_servers = {}

            all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server")
                .lspconfig_to_package)

            local ensure_installed = {} ---@type string[]

            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == nil and {} or server_opts

                    if server_opts.separate_formatter == true then
                        ---@type vim.lsp.client.on_attach_cb
                        server_opts.on_attach = function(client, _)
                            if client.supports_method("textDocument/formatting") then
                                client.server_capabilities.documentFormattingProvider = false
                            end

                            vim.keymap.set("n", "<leader>F", "<cmd>FormatLock<CR>", {})
                        end
                    end

                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    elseif server_opts.enabled ~= false then
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            mason.setup({
                ensure_installed = vim.tbl_deep_extend(
                    "force",
                    ensure_installed,
                    {}
                ),
                handlers = { setup },
            })
        end,
    }
}
