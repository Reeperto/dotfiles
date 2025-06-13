return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        config = function() vim.cmd[[colorscheme kanagawa-dragon]] end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
            ---@diagnostic disable-next-line
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    disable = { "tex", "latex" },
                    additional_vim_regex_highlighting = { "latex", "tex" },
                }
            })
        end
    },
    {
        "folke/lazydev.nvim",
        dependencies = {
            "justinsgithub/wezterm-types"
        },
        ft = "lua",
        opts = {
            library = {
                { path = "wezterm-types", mods = { "wezterm" } },
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "~/dev/c/mc-server"}
            }
        }
    },
    {
        "echasnovski/mini.nvim",
        config = function ()
            require("mini.comment").setup({
                mappings = {
                    comment = '',
                    comment_line = '<localleader><localleader>',
                    comment_visual = '<localleader><localleader>',
                    textobject = 'gc',
                }
            })

            require("mini.align").setup({})
        end
    },
    { "folke/zen-mode.nvim" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim"
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function() require("lsp") end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip"
        },
        opts = function (_, _)
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            return {
                mapping = {
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                           luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = 'luasnip' },
                    { name = "lazydev", group_index = 0 }
                }
            }
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim"
        },
        lazy = false,
        config = function ()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        specific_opts = {
                            ["tree-walk-selector"] = {}
                        }
                    }
                }
            })

            require("telescope").load_extension("ui-select")

            local builtin = require("telescope.builtin")
            local map = vim.keymap.set

            map("n", "<leader>sf", function ()
                local git_path = vim.fn.finddir(".git", ";/Users/reeperto")

                if git_path ~= "" then
                    builtin.git_files()
                else
                    builtin.find_files()
                end
            end)
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function ()
            require("luasnip").setup({
                enable_autosnippets = true
            })

            require("luasnip.loaders.from_lua").load({
                paths = {vim.fn.stdpath("config") .. "/lua/snippets"}
            })
        end
    },
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            local g = vim.g

            g.vimtex_quickfix_mode = 0

            g.vimtex_syntax_conceal = {
                accents = 1,
                ligatures = 1,
                cites = 0,
                fancy = 1,
                spacing = 1,
                greek = 1,
                math_bounds = 1,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 0,
                styles = 1,
            }

            g.vimtex_syntax_custom_cmds = {
                {
                    name = "ball",
                    mathmode = true,
                    concealchar = "𝔹",
                },
                {
                    name = "R",
                    mathmode = true,
                    concealchar = "ℝ",
                },
                {
                    name = "coloneq",
                    mathmode = true,
                    concealchar = "≔",
                }
            }

            g.vimtex_syntax_custom_cmds_with_concealed_delims = {
                {
                    name = "vb",
                    mathmode = true,
                    argstyle = "bold"
                },
                {
                    name = "overline",
                    mathmode = true,
                    cchar_close = '‾',
                },
                {
                    name = "mathring",
                    mathmode = true,
                    cchar_close = '°'
                }
            }

            g.vimtex_syntax_conceal_cites = {
                ["type"] = "icon",
                ["icon"] = " ",
                ["verbose"] = false,
            }

            g.vimtex_toc_config = {
                split_pos = "right",
                split_width = 20,
                show_help = 0,
            }

            g.vimtex_compiler_latexmk = {
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                options = {
                    "-verbose",
                    "-file-line-error",
                    "-shell-escape",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }

            g.vimtex_compiler_latexmk_engines = {
                ["_"] = "-lualatex",
            }

            if vim.fn.has('macunix') == 1 then
                g.vimtex_view_method = "sioyek"
            else
                g.vimtex_view_method = "zathura"
            end
        end,
    },
}
