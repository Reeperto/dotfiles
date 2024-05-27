-- Set the lsp window border style + color

local utils = require("utils")

utils.modify_hl("NormalFloat", {
    bg = "none"
})

utils.modify_hl("FloatBorder", {
    bg = "none",
    fg = utils.get_hl_field("Blue", "fg")
})

utils.set_hl("LineNrAbove", utils.get_hl_definition("LineNr"))
utils.set_hl("LineNrBelow", { link = "LineNrAbove" })

utils.modify_hl("LineNr", {
    fg = utils.get_hl_field("Yellow", "fg")
})
