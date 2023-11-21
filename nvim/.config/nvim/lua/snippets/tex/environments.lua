local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

return {
	s(
		"beg",
		fmta([[
		\begin{<>}
			<>
		\end{<>}
		]], { i(1), i(0), rep(1) })
	),
	s(
		{
			trig = "algn",
			snippetType = "autosnippet"
		},
		fmta([[
		\begin{align*}
			<>
		\end{align*}
		]], { i(0) })
	),
	s(
		{
			trig = "defn",
			snippetType = "autosnippet"
		},
		fmta([[
		\begin{definition}[<>]
			<>
		\end{definition}
		]], { i(1), i(0) })
	),
	s(
		{
			trig = "thm",
			snippetType = "autosnippet"
		},
		fmta([[
		\begin{theorem}[<>]
			\label{thm:<>}
			<>
		\end{theorem}
		]], { i(1), i(2), i(0) })
	),
	s(
		{
			trig = "prf",
			snippetType = "autosnippet"
		},
		fmta([[
		\begin{proof}
			<>
		\end{proof}
		]], { i(0) })
	),
	s(
		{
			trig = "dm",
			snippetType = "autosnippet"
		},
		fmta([[
		\[
			<>
		.\]<>
		]], { i(1), i(0) }
		)
	),
	s(
		{
			trig = "mk",
			snippetType = "autosnippet",
			wordTrig = true,
		},
		fmta([[
		$<>$<>
		]], { i(1), i(0) }
		)
	),
}
