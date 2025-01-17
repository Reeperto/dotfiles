---@class LspSettings
---@field mason boolean?
---@field formatter "separate" | "lsp" | "none" | nil
---@field enabled boolean?
---@field keys LazyKeysSpec[]?
---@field settings table?
---@field on_attach vim.lsp.client.on_attach_cb?

---@type table<string, LspSettings>
local M = {}

M.neocmake = {
    mason = false
}

M.clangd = {
    mason = false,
    formatter = "none",
}

M.rust_analyzer = {
    mason = false,
}

M.zls = {
    mason = false
}

M.ols = {
    mason = false,
    settings = {
        cmd = "ols"
    }
}

-- M.wgsl_analyzer = {
--     mason = true
-- }

M.pyright = {
    mason = true
}

M.lua_ls = {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
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

M.ts_ls = {
    mason = true,
    settings = {
        implicitProjectConfiguration = {
            checkJs = true
        },
    }
}

M.tailwindcss = {
    mason = true
}

M.svelte = {
    mason = true
}

M.pest_ls = {
    mason = true
}

return M
