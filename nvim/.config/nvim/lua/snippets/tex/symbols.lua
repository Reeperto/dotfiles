local ls = require("luasnip")
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local in_math = require("snippets.tex.context").in_math
local in_align = require("snippets.tex.context").in_align

local snippets = {
    s(
        "uu",
        t("\\mathcal{U}"),
        in_math
    ),
    s(
        {
            trig = "partial",
            snippetType = "autosnippet"
        },
        t("\\partial"),
        in_math
    ),
    s(
        {
            trig = "nabla",
            snippetType = "autosnippet"
        },
        t("\\nabla"),
        in_math
    ),
    s(
        {
            trig = "==",
            snippetType = "autosnippet"
        },
        t("&="),
        in_align
    ),
    s(
        {
            trig = "ooo",
            snippetType = "autosnippet"
        },
        t("\\infty"),
        in_math
    ),
    s(
        {
            trig = ">=",
            snippetType = "autosnippet"
        },
        t("\\geq"),
        in_math
    ),
    s(
        {
            trig = "<=",
            snippetType = "autosnippet"
        },
        t("\\leq"),
        in_math
    ),
    s(
        {
            trig = "=>",
            snippetType = "autosnippet"
        },
        t("\\implies"),
        in_math
    ),
    s(
        {
            trig = "...",
            snippetType = "autosnippet"
        },
        t("\\ldots"),
        in_math
    ),
    s(
        {
            trig = "(.*)[^\\]sqrt",
            regTrig = true,
            snippetType = "autosnippet"
        },
        fmta([[<> \sqrt{<>}<>]], { f(function(_, snip)
            return snip.captures[1]
        end), i(1), i(0) }),
        in_math
    ),
    s(
        {
            trig = "[^\\]int",
            wordTrig = false,
            snippetType = "autosnippet",
        },
        t("\\int"),
        in_math
    ),
    s(
        {
            trig = "\\lim_",
            snippetType = "autosnippet"
        },
        fmta([[\lim_{<>}<>]], { i(1), i(0) }),
        in_math
    ),
    s(
        {
            trig = "(.*)vb(%w)",
            regTrig = true,
            snippetType = "autosnippet"
        },
        fmta([[<>\vb{<>}<>]],
            {
                f(function(_, snip)
                    return snip.captures[1]
                end),
                f(function(_, snip)
                    return snip.captures[2]
                end),
                i(0)
            }),
        in_math
    ),
}

local function shorthand(name, capital)
    return {
        abr = name,
        cap = capital
    }
end

local greek = {
    alpha = false,
    beta = false,
    gamma = true,
    delta = true,
    -- epsilon = shorthand("epsi", false),
    zeta = false,
    eta = false,
    theta = true,
    iota = false,
    kappa = false,
    lambda = shorthand("lmd", true),
    mu = false,
    -- nu = false,
    xi = false,
    pi = true,
    rho = false,
    sigma = true,
    tau = false,
    upsilon = true,
    phi = true,
    chi = false,
    psi = true,
    omega = true,
}

for letter, info in pairs(greek) do
    if type(info) == "boolean" then
        snippets[#snippets + 1] = s({
            trig = letter,
            snippetType = "autosnippet",
            wordTrig = true,
        }, t("\\" .. letter), in_math)

        if info then
            local upped = letter:sub(1, 1):upper() .. letter:sub(2, #letter)
            snippets[#snippets + 1] = s({
                trig = upped,
                snippetType = "autosnippet",
                wordTrig = true,
            }, t("\\" .. upped), in_math)
        end
    else
        snippets[#snippets + 1] = s({
            trig = info.abr,
            snippetType = "autosnippet",
            wordTrig = true,
        }, t("\\" .. letter), in_math)

        if info then
            local upped = letter:sub(1, 1):upper() .. letter:sub(2, #letter)
            local upped_abr = info.abr:sub(1, 1):upper() .. info.abr:sub(2, #info.abr)
            snippets[#snippets + 1] = s({
                trig = upped_abr,
                snippetType = "autosnippet",
                wordTrig = true,
            }, t("\\" .. upped), in_math)
        end
    end
end

local blackboard = { "R", "C", "F", "N", "Q", "Z" }

for _, identifier in ipairs(blackboard) do
    snippets[#snippets + 1] = s(identifier .. identifier,
        t(string.format("\\%s", identifier)), in_math)
end

return snippets
