local map = vim.keymap.set

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.relativenumber = true
vim.o.numberwidth = 1
vim.o.colorcolumn = "80"

vim.o.foldmethod = "expr"
vim.o.foldlevelstart = 1000

vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.indentexpr = "nvim_treesitter#indent()"

vim.filetype.add({
    extension = {
        ["m"] = "objc",
        ["mm"] = "objcpp"
    }
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt", "man://*" },
    callback = function()
        local ft = vim.o.filetype
        if ft == 'help' or ft == "man" then
            vim.cmd.wincmd("L")
        end
    end
})

local function ESC(cmd)
    return vim.api.nvim_replace_termcodes(cmd, true, true, true)
end

vim.api.nvim_create_user_command("AlignTable", function ()
    vim.api.nvim_feedkeys("gv", "n", false)
    vim.api.nvim_feedkeys(ESC"gA", "v", false)
    vim.api.nvim_feedkeys(ESC[[s= %.%w+<CR><CR>]], "n", false)
    vim.api.nvim_feedkeys(ESC[[:'<,'>s/\(\S\+\)\(\s\+\),/\1,\2/g<CR>]], "n", false)
end, { range = 1 })

local tsutils = require("nvim-treesitter.ts_utils")

local function_types = {
    ["procedure_declaration"] = true,
    ["function_declaration" ] = true,
    ["function_definition"  ] = true,
    ["method_declaration"   ] = true,
    ["method_definition"    ] = true,
    ["arrow_function"       ] = true
}

local function select_function()
    local node = tsutils.get_node_at_cursor()

    while node do
        if function_types[node:type()] then
            break
        end

        node = node:parent()
    end

    if not node then
        return
    end

    local s_row, s_col, e_row, e_col = node:range()
    s_row, e_row = s_row + 1, e_row + 1

    vim.api.nvim_win_set_cursor(0, {s_row, s_col})
    vim.cmd[[normal! v]]
    vim.api.nvim_win_set_cursor(0, {e_row, e_col})
end

local function select_walk_tree()
    local node = tsutils.get_node_at_cursor()
    local nodes = {}

    while node do
        nodes[#nodes+1] = node
        node = node:parent()
    end

    local lines = {}

    for _, n in ipairs(nodes) do
        local s_row, _, _, _ = n:range()
        local line = vim.api.nvim_buf_get_lines(0, s_row, s_row + 1, true)[1]
        lines[#lines + 1] = line
    end

    vim.ui.select(lines, { kind = "tree-walk-selector" }, function (_, _) end)
end

map("n", "\\", vim.cmd.split)
map("n", "|", vim.cmd.vsplit)

map("n", "<leader>w", [[:w<CR>]])
map("n", "<leader>q", [[:q<CR>]])

map("n", "sf", select_function)
map("n", "st", select_walk_tree)
