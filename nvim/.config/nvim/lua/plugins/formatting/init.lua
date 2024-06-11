return {
    {
        "mhartington/formatter.nvim",
        config = function()
            local util = require("formatter.util")
            local servers = {}

            -- servers.lua = require("formatter.filetypes.lua").stylua
            servers.c = function()
                return {
                    exe = "clang-format",
                    args = {
                        "--assume-filename",
                        util.escape_path(util.get_current_buffer_file_name()),
                        string.format([[-style=file:'%s/lua/plugins/formatting/.clang-format']], vim.fn.stdpath("config"))
                    },
                    stdin = true,
                }
            end

            servers.cpp = servers.c
            servers.objc = servers.c

            servers.rust = require("formatter.filetypes.rust").rustfmt
            servers.toml = require("formatter.filetypes.toml").taplo
            servers.fish = require("formatter.filetypes.fish").fishindent

            require("formatter").setup({
                logging = true,
                log_level = vim.log.levels.ERROR,
                filetype = servers,
            })
        end,
    },
}
