---@class utils.func
local M = {}

---Creates a new function that takes an exisitng function and parameters to it. 
---The function's execution is delayed to the next call of the returned function
---@param func function|table
---@param ... unknown
function M.delay(func, ...)
    local args = {...}
    return function ()
        return func(unpack(args))
    end
end

return M
