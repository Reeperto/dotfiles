require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")

local configs = {
    clangd = {},
    lua_ls = {},
    ols = {},
    rust_analyzer = {},
    ts_ls = {
        filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
        }
    }
}

local map = vim.keymap.set
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- local bufnr = args.buf
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)

        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "rn", vim.lsp.buf.rename)
        map("n", "ca", vim.lsp.buf.code_action)
        map("n", "K",  vim.lsp.buf.hover)

        vim.o.signcolumn = "yes"
    end,
})

local all_servers = vim.tbl_keys(configs)

for _, installed in ipairs(require("mason-lspconfig").get_installed_servers()) do
    if configs[installed] == nil then
        all_servers[#all_servers+1] = installed
    end
end

for _, server_name in ipairs(all_servers) do
    if configs[server_name] == nil then
        lspconfig[server_name].setup({})
    else
        lspconfig[server_name].setup(configs[server_name])
    end
end
