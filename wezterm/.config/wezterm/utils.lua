local M = {}

local wezterm = require("wezterm")

function M.is_darwin ()
    return wezterm.target_triple:find("darwin") ~= nil
end

return M
