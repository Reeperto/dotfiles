---@class utils.plugins
local M = {}

---Checks if plugin has been loaded by Lazy
---@param name string
function M.is_loaded(name)
    local lazy_plugs = require("lazy.core.config").plugins
    return lazy_plugs[name] ~= nil and lazy_plugs[name]._.loaded
end

return M
