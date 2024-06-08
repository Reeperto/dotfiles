-- This is a better implementation of `cmp.confirm`:
--  * check if the completion menu is visible without waiting for running sources
--  * create an undo point before confirming
-- This function is both faster and more reliable.
---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
local function confirm(opts)
    local cmp = require("cmp")
    opts = vim.tbl_extend("force", {
        select = true,
        behavior = cmp.ConfirmBehavior.Insert,
    }, opts or {})
    return function(fallback)
        if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
            -- LazyVim.create_undo()
            if cmp.confirm(opts) then
                return
            end
        end
        return fallback()
    end
end

local function auto_brackets(entry)
    local cmp = require("cmp")
    local Kind = cmp.lsp.CompletionItemKind
    local item = entry:get_completion_item()
    if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
        local cursor = vim.api.nvim_win_get_cursor(0)
        local prev_char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
        if prev_char ~= "(" and prev_char ~= ")" then
            local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
            vim.api.nvim_feedkeys(keys, "i", true)
        end
    end
end

---@param snippet string
---@param fn fun(placeholder:Placeholder):string
---@return string
local function snippet_replace(snippet, fn)
    return snippet:gsub("%$%b{}", function(m)
        local n, name = m:match("^%${(%d+):(.+)}$")
        return n and fn({ n = n, text = name }) or m
    end) or snippet
end

-- This function resolves nested placeholders in a snippet.
---@param snippet string
---@return string
local function snippet_preview(snippet)
    local ret = snippet_replace(snippet, function(placeholder)
        return snippet_preview(placeholder.text)
    end):gsub("%$0", "")
    return ret
end

-- This function adds missing documentation to snippets.
-- The documentation is a preview of the snippet.
---@param window cmp.CustomEntriesView|cmp.NativeEntriesView
local function add_missing_snippet_docs(window)
    local cmp = require("cmp")
    local Kind = cmp.lsp.CompletionItemKind
    local entries = window:get_entries()
    for _, entry in ipairs(entries) do
        if entry:get_kind() == Kind.Snippet then
            local item = entry:get_completion_item()
            if not item.documentation and item.insertText then
                item.documentation = {
                    kind = cmp.lsp.MarkupKind.Markdown,
                    value = string.format("```%s\n%s\n```", vim.bo.filetype, snippet_preview(item.insertText)),
                }
            end
        end
    end
end

return {
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()

            ---@type cmp.ConfigSchema
            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = confirm(),
                    ["<S-CR>"] = confirm({ behavior = cmp.ConfirmBehavior.Replace }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    -- { name = "buffer" },
                    { name = "path" },
                }),
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,
            }
        end,
        ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
        config = function(_, opts)
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end

            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.event:on("confirm_done", function(event)
                if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
                    auto_brackets(event.entry)
                end
            end)
            cmp.event:on("menu_opened", function(event)
                add_missing_snippet_docs(event.window)
            end)
        end,
    }
}
