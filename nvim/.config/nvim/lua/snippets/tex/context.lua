local M = {}

M.in_math = {
	condition = function()
		-- The `in_mathzone` function requires the VimTeX plugin
		return vim.fn['vimtex#syntax#in_mathzone']() == 1
	end
}

return M
