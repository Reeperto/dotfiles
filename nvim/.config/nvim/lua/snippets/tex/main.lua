local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
-- local sn = ls.snippet_node
-- local d = ls.dynamic_node
-- local f = ls.function_node

local in_math = require("snippets.tex.context").in_math

return {
	s(
		"template",
		fmta([[
		\documentclass[12pt,titlepage]{extarticle}
		\input{../preamble.tex}
		\renewcommand*\contentsname{Table of Contents}
		
		\title{<>}
		\author{Eli Griffiths}
		
		\begin{document}
		\maketitle
		\pagebreak
		\thispagestyle{empty}
		\tableofcontents
		\pagebreak
		
		<>
		
		\newpage
		\pagestyle{empty}
		\addcontentsline{toc}{section}{List of Theorems}
		\listoftheorems[ignoreall,onlynamed={theorem}]
		\addcontentsline{toc}{section}{List of Definitions}
		\listoftheorems[ignoreall,onlynamed={definition},title={List of Definitions}]
		\end{document}
		]],
			{ i(1), i(0) }
		)
	),
	s(
		"subtemplate",
		fmta([[
		\documentclass[../notes.tex]{subfiles}
		\graphicspath{
		    {'../figures'}
		}

		<>
		
		\begin{document}
		\end{document}
		]],
			{ i(0) }
		)
	),
}
