local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local in_math = require("snippets.tex.context").in_math

return {
	s(
		{
			trig = [[((\d+)|(\d*)(\\)?([A-Za-z]+)((\^|_)(\{\d+\}|\d))*)/]],
			trigEngine = "ecma",
			snippetType = "autosnippet"
		},
		fmta(
			[[\frac{<>}{<>}<>]],
			{
				f(function(_, snip) return snip.captures[1] end),
				i(1),
				i(0)
			}
		),
		in_math
	),
	s(
		{
			trig = "(%a)(%d)",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = "false"
		},
		f(function(_, snip)
			return snip.captures[1] .. "_" .. snip.captures[2]
		end)
	),
	s(
		{
			trig = [[^.*\)/]],
			trigEngine = "ecma",
			snippetType = "autosnippet"
		},
		fmta(
			[[<>{<>}<>]],
			{
				f(function(_, snip)
					---@type string
					local trig = snip.trigger
					---@type string
					local stripped = trig:sub(1, trig:len() - 1)

					local idx = stripped:len()
					local depth = 0

					while true do
						local char = stripped:sub(idx, idx)

						if char == ')' then
							depth = depth + 1
						elseif char == '(' then
							depth = depth - 1
						end

						if depth == 0 then
							break
						end

						idx = idx - 1
					end

					if idx == 1 then
						return [[\frac{]] .. stripped:sub(idx + 1, stripped:len() - 1) .. "}"
					else
						return stripped:sub(1, idx - 1) .. [[\frac{]] .. stripped:sub(idx + 1, stripped:len() - 1) .. "}"
					end
				end),
				i(1),
				i(0)
			}
		),
		in_math
	),
	s(
		{
			trig = "sr",
			wordTrig = false,
			snippetType = "autosnippet",
		},
		t("^2"),
		in_math
	),
	s(
		{
			trig = "int",
			wordTrig = false,
			snippetType = "autosnippet",
		},
		t("\\int"),
		in_math
	),
	s(
		{
			trig = "__",
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta(
			"_{<>}<>",
			{ i(1), i(0) }
		)
	)
}
