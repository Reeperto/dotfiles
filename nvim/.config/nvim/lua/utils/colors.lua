---@class utils.colors
local M = {}

---Properly loads and sets colorscheme
---@param plugin_name string
---@param name string
function M.set_colorscheme(plugin_name, name)
    if name == nil then
        name = plugin_name
    end

    if not Utils.plugins.is_loaded(name) then
        require(plugin_name)
    end

    vim.cmd("colorscheme " .. name)
end

return M
