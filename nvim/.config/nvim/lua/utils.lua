local M = {}

---Updates a highlight group without replacing all options
---@param hl_name string
---@param opts table
function M.modify_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
    if is_ok then
        for k, v in pairs(opts) do hl_def[k] = v end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

---Sets a highlight group by replacing all options
---@param hl_name string
---@param opts table
function M.set_hl(hl_name, opts)
    vim.api.nvim_set_hl(0, hl_name, opts)
end

---Gets field from highlight group definition
---@param hl_name string
---@return any|nil
function M.get_hl_definition(hl_name)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name })
    if is_ok then
        return hl_def
    end

    return nil
end

---Gets field from highlight group definition
---@param hl_name string
---@param field string
---@return any|nil
function M.get_hl_field(hl_name, field)
    local hl_def = M.get_hl_definition(hl_name)
    if hl_def ~= nil then
        return hl_def[field]
    end

    return nil
end

return M
