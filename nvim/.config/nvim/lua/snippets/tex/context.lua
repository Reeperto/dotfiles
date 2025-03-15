local M = {}

M.in_math = {
    condition = function()
        -- The `in_mathzone` function requires the VimTeX plugin
        return vim.fn['vimtex#syntax#in_mathzone']() == 1
    end
}

-- TODO: Clean up
M.in_align = {
    condition = function()
        ---@type string
        local name = vim.fn['vimtex#env#get_inner']()['name']

        if name == nil then
            return false
        end

        return name:match("align[*]?") ~= nil
    end
}

return M
