---@class utils
---@field lsp utils.lsp
---@field colors utils.colors
---@field plugins utils.plugins
---@field func utils.func
---@field root utils.root
---@field lazy LazyUtil
_G.Utils = {}

setmetatable(Utils, {
    __index = function (t, k)
        t[k] = require("utils." .. k)
        return t[k]
    end
})
