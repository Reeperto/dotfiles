return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        branch = "v3.x",
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = Utils.root.get() })
                end,
                desc = "Explorer NeoTree (Root Dir)",
            },
            {
                "<leader>fE",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
            {
                "<leader>ge",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git Explorer",
            },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer Explorer",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
            -- because `cwd` is not set up properly.
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
                desc = "Start Neo-tree with directory",
                once = true,
                callback = function()
                    if package.loaded["neo-tree"] then
                        return
                    else
                        local stats = vim.uv.fs_stat(vim.fn.argv(0))
                        if stats and stats.type == "directory" then
                            require("neo-tree")
                        end
                    end
                end,
            })
        end,
        opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                    ["Y"] = {
                        function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.fn.setreg("+", path, "c")
                        end,
                        desc = "Copy Path to Clipboard",
                    },
                    ["O"] = {
                        function(state)
                            Utils.lazy.open(state.tree:get_node().path, { system = true })
                        end,
                        desc = "Open with System Application",
                    },
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                git_status = {
                    symbols = {
                        unstaged = "󰄱",
                        staged = "󰱒",
                    },
                },
            },
        },
        config = function(_, opts)
            local function on_move(data)
                Utils.lsp.on_rename(data.source, data.destination)
            end

            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED,   handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({})
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>sg", builtin.git_files, {})
            vim.keymap.set("n", "<leader>sb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})
        end
    },
    {
        "ziontee113/color-picker.nvim",
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
            vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

            require("color-picker").setup({ -- for changing icons & mappings
                ["border"] = "rounded",     -- none | single | double | rounded | solid | shadow
                ["keymap"] = {              -- mapping example:
                    ["U"] = "<Plug>ColorPickerSlider5Decrease",
                    ["O"] = "<Plug>ColorPickerSlider5Increase",
                },
                ["background_highlight_group"] = "Normal",  -- default
                ["border_highlight_group"] = "FloatBorder", -- default
                ["text_highlight_group"] = "Normal",        --default
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = "^$",
                opleader = {
                    line = "<localleader><localleader>",
                    block = "<localleader>b",
                },
                ---@diagnostic disable-next-line: missing-fields
                toggler = {
                    line = "<localleader><localleader>",
                },
            })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        -- opts = {
        --     highlight = {
        --         pattern = [[.*<(KEYWORDS)(\s*:|\(.*\):)]]
        --     },
        --     search = {
        --         pattern = [[\b(KEYWORDS)(?::|\(.*\):)]]
        --     }
        -- }
    },
    {
        "andweeb/presence.nvim",
        config = function ()
            require("presence").setup({})
        end
    }
    -- {
    --     "saecki/crates.nvim",
    --     config = function()
    --         require('crates').setup()
    --     end,
    -- }
}
