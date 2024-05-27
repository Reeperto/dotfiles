local M = {}

--------------------------------------------------------------------------------
-- Compiled Languages
--------------------------------------------------------------------------------

M.rust_analyzer = {
    formatter = true,
}

M.clangd = {}
M.zls = {}
M.gopls = {}

M.ols = {
    formatter = true,
}

M.omnisharp = {
    lsp = {
        enable_roslyn_analyzers = true,
    }
}

--------------------------------------------------------------------------------
-- Interpreted Languages
--------------------------------------------------------------------------------

M.pyright = {}
-- M.pylsp = {}

M.lua_ls = {
    formatter = true,
    lsp = {
        Lua = {
            runtime = {
                version = "Lua 5.1",
                path = vim.fn.split(vim.fn.getenv("LUA_PATH"), ";"),
            },
            workspace = {
                library = {
                    vim.fn.expand("~/.luarocks/share/lua/5.1"),
                },
                userThirdParty = {
                    vim.fn.expand("~/.lua/addons"),
                },
            },
        },
    }
}

M.uiua = {
    lsp = {
        full_config = true,
        filetypes = { "ua", "uiua" }
    }
}

--------------------------------------------------------------------------------
-- Web Development
--------------------------------------------------------------------------------

local webdev_fts = { "etlua", "css", "svelte", "js", "ts", "html", "astro", "mjs" }

M.tailwindcss = {
    lsp = {
        init_options = {
            userLanguages = {
                etlua = "html-eex",
                ["html.etlua"] = "html-eex",
            },
        },
        settings = {
            tailwindCSS = {
                emmetCompletions = false,
            },
        },
        filetypes = webdev_fts,
    }
}

M.emmet_language_server = {
    lsp = {
        filetypes = webdev_fts
    }
}

M.html = {
    lsp = {
        filetypes = webdev_fts,
    }
}

M.astro = {
    lsp = {
        filetypes = webdev_fts
    }
}

M.tsserver = {
    lsp = {
        filetypes = webdev_fts
    }
}

M.jsonls = {
    formatter = true
}

M.svelte = {}
-- M.unocss = {}

--------------------------------------------------------------------------------
-- Miscellaneous
--------------------------------------------------------------------------------

-- M.texlab = {}
M.glslls = {}
M.wgsl_analyzer = {}
M.taplo = {}

return M
