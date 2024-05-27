local keymap = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Prevents weird window shifting when diagnostics appear
        vim.o.signcolumn = "yes"

        local opts = { buffer = ev.buf }

        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>r", vim.lsp.buf.rename, opts)
        keymap("n", "gd", "<CMD>Glance definitions<CR>", opts)
        keymap("n", "gi", "<CMD>Glance implementations<CR>", opts)
        keymap("n", "gr", "<CMD>Glance references<CR>")
        keymap("n", "gt", "<CMD>Glance type_definitions<CR>", opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
    end,
})

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
                ---@diagnostic disable-next-line
                glance.setup({
                    border = {
                        enable = true,
                        top_char = "―",
                        bottom_char = "―",
                    },
                    theme = {
                        enable = true,
                        mode = "auto",
                    },
                })
            end,
        },
        {
            "saecki/crates.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require("crates").setup()
                local cmp = require("cmp")

                vim.api.nvim_create_autocmd("BufRead", {
                    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                    pattern = "Cargo.toml",
                    callback = function()
                        ---@diagnostic disable-next-line
                        cmp.setup.buffer({ sources = { { name = "crates" } } })
                    end,
                })
            end,
        },
    },
    config = function()
        local configurations = require("modules.lsp.servers")

        require("neodev").setup({
            library = { plugins = { "nvim-dap-ui" }, types = true }
        })

        require("mason").setup()
        require("mason-lspconfig").setup()
        require("clangd_extensions").setup()

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local floating_border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
        }

        ---@diagnostic disable
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or floating_border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        ---@diagnostic enable

        -- Disable formatting for lsp servers as formatting is handled separately
        local function on_attach_formatless(client, _)
            if client.supports_method("textDocument/formatting") then
                client.server_capabilities.documentFormattingProvider = false
            end
        end

        local function on_attach_formatfull(_, _)
            -- Format using language server's formatting
            keymap("n", "<Leader>F", vim.lsp.buf.format)
        end

        for server, config in pairs(configurations) do
            local attach_function

            if config.formatter then
                attach_function = on_attach_formatfull
            else
                attach_function = on_attach_formatless
            end

            config.lsp = config.lsp or {}
            config.lsp.on_attach = attach_function
            config.lsp.capabilities = capabilities
            lspconfig[server].setup(config.lsp)
        end
    end,
}
