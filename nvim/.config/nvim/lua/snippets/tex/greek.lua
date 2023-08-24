local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

local greek = {
	alpha   = false,
	beta    = false,
	gamma   = true,
	delta   = true,
	epsilon = false,
	zeta    = false,
	eta     = false,
	theta   = true,
	iota    = false,
	kappa   = false,
	lambda  = true,
	mu      = false,
	nu      = false,
	xi      = false,
	pi      = true,
	rho     = false,
	sigma   = true,
	tau     = false,
	upsilon = true,
	phi     = true,
	chi     = false,
	psi     = true,
	omega   = true,
}

local in_math = require("snippets.tex.context").in_math

local snippets = {}

for letter, upper in pairs(greek) do
	snippets[#snippets + 1] = s(
		{
			trig = letter,
			snippetType = "autosnippet"
		},
		t("\\" .. letter),
		in_math
	)

	if upper then
		local upped = letter:sub(1, 1):upper() .. letter:sub(2, #letter)
		snippets[#snippets + 1] = s(
			{
				trig = upped,
				snippetType = "autosnippet"
			},
			t("\\" .. upped),
			in_math
		)
	end
end

return snippets
