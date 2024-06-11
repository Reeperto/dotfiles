local wezterm = require("wezterm")
local utils = require("utils")

local name = "IosevkaTerm Nerd Font"

return {
    font_size = utils.is_darwin() and 16 or 18,
    font_name = name,
    rules = {
        -- {
        --     intensity = 'Normal',
        --     italic = true,
        --     font = wezterm.font {
        --         family = "PragmataPro Mono Liga",
        --         harfbuzz_features = { 'ss06=1' }
        --     }
        -- },
        -- {
        --     intensity = 'Bold',
        --     italic = true,
        --     font = wezterm.font {
        --         family = "PragmataPro Mono Liga",
        --         harfbuzz_features = { 'ss07=1' }
        --     }
        -- }
    }
}
