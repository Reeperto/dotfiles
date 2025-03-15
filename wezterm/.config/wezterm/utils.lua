local M = {}

local wezterm = require("wezterm")

function M.is_darwin()
    return wezterm.target_triple:find("darwin") ~= nil
end

function M.tbl_merge(tbl, ...)
    local tables = { ... }

    for i = 1, #tables do
        local other_tbl = tables[i]
        for key, value in pairs(other_tbl) do
            if type(value) == "table" then
                if type(tbl[key] or false) == "table" then
                    M.tbl_merge(tbl[key] or {}, other_tbl[key] or {})
                else
                    tbl[key] = value
                end
            else
                tbl[key] = value
            end
        end
    end

    return tbl
end

return M
