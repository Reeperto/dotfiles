local wezterm = require("wezterm")
local color = wezterm.color
require("events").setup()

local utils = require("utils")
local font = require("font")
local keys = utils.is_darwin() and require("mac_keys") or require("linux_keys")
local scheme = require("colors.kanagawa-dragon")

local config = {
    enable_wayland = false,
    window_decorations = utils.is_darwin() and "RESIZE" or "NONE",
    font = wezterm.font {
        family = font.font_name,
    },
    font_rules = font.rules,
    font_size = font.font_size,
    line_height = 1,
    scrollback_lines = 1500,
    adjust_window_size_when_changing_font_size = false,
    hide_tab_bar_if_only_one_tab = true,
    disable_default_key_bindings = true,
    leader = keys.leader,
    keys = keys.mappings,
    use_dead_keys = false,
    window_frame = {
        font_size = 16,
        font = wezterm.font({
            family = font.font_name,
            weight = "Bold"
        }),
        active_titlebar_bg = scheme.colors.background,
        inactive_titlebar_bg = scheme.colors.background,
    },
    colors = {
        tab_bar = {
            background = scheme.colors.background,
            inactive_tab = {
                bg_color = scheme.colors.background,
                fg_color = color.parse(scheme.colors.background):lighten(0.1)
            },
            active_tab = {
                bg_color = scheme.colors.background,
                fg_color = scheme.colors.ansi[4]
            }
        }
    },
    inactive_pane_hsb = {
        saturation = 1,
        brightness = 0.6,
    },
}

utils.tbl_merge(config, scheme)

return config
