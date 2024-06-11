---@class LspSettings
---@field settings table?
---@field mason boolean?
---@field separate_formatter boolean?
---@field enabled boolean?
---@field keys LazyKeysSpec[]?


---@type table<string, LspSettings>
local M = {}

M.clangd = {
    mason = false,
    separate_formatter = true,
}

M.ols = {
    mason = false,
    settings = {
        cmd = "ols"
    }
}

M.lua_ls = {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            codeLens = {
                enable = true,
            },
            completion = {
                callSnippet = "Replace",
            },
            doc = {
                privateName = { "^_" },
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
            },
        },
    },
}

M.tsserver = {
    mason = true
}

return M
