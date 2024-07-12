return {
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
                -- ["_"] = "-xelatex",
                ["_"] = "-lualatex",
            }

            if vim.fn.has('macunix') == 1 then
                g.vimtex_view_method = "sioyek"
            else
                g.vimtex_view_method = "zathura"
            end

            -- Latex warnings to ignore
            g.vimtex_quickfix_ignore_filters = {
                "Command terminated with space",
                "LaTeX Font Warning: Font shape",
                "Package caption Warning: The option",
                [[Underfull \\hbox (badness [0-9]*) in]],
                "Package enumitem Warning: Negative labelwidth",
                [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
                [[Package caption Warning: Unused \\captionsetup]],
                "Package typearea Warning: Bad type area settings!",
                [[Package fancyhdr Warning: \\headheight is too small]],
                [[Package hyperref Warning: Rerun to get \/PageLabels entry.]],
                [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
                "Package hyperref Warning: Token not allowed in a PDF string",
                [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
            }
        end,
    },
}
