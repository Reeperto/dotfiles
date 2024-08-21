---@class utils.lsp
local M = {}

---Runs `on_attach` whenever an LSP is attached
---@param on_attach vim.lsp.client.on_attach_cb
function M.on_attach(on_attach)
    return vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf ---@type number
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                return on_attach(client, buffer)
            end
        end,
    })
end

---@param from string
---@param to string
function M.on_rename(from, to)
    local clients = M.get_clients()
    for _, client in ipairs(clients) do
        if client.supports_method("workspace/willRenameFiles") then
            ---@diagnostic disable-next-line: invisible
            local resp = client.request_sync("workspace/willRenameFiles", {
                files = {
                    {
                        oldUri = vim.uri_from_fname(from),
                        newUri = vim.uri_from_fname(to),
                    },
                },
            }, 1000, 0)
            if resp and resp.result ~= nil then
                vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
            end
        end
    end
end

---Gets all attached LSP clients based on opts
---@param opts table?
---@return lsp.Client
function M.get_clients(opts)
    return vim.lsp.get_active_clients(opts)
end

return M
