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

return {
    s(
        "template",
        fmta([[
        \documentclass[14pt]{book}
        \input{../course_preamble.tex}
        \title{<>}

        \begin{document}

        \subfile{<>}

        \end{document}
		]],
            { i(1), i(0) }
        )
    ),
    s(
        "subtemplate",
        fmta([[
		\documentclass[../notes.tex]{subfiles}
		\graphicspath{{'../figures'}}

		<>
		
		\begin{document}
		\end{document}
		]],
            { i(0) }
        )
    ),
}
