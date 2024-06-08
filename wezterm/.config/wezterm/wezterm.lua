local wezterm = require("wezterm")
local font = require("font")
local utils = require("utils")
local keys = utils.is_darwin() and require("mac_keys") or require("linux_keys")

require("events").setup()

local font_size = utils.is_darwin() and 16 or 18
local font_name = "IosevkaTerm Nerd Font"
local color_scheme = "carbonfox"

local p = wezterm.color.load_scheme(string.format("/home/eeleyes/.dotfiles/wezterm/.config/wezterm/colors/%s.toml", color_scheme))

return {
    enable_wayland = false,
    window_decorations = utils.is_darwin() and "RESIZE" or "NONE",
    color_scheme = color_scheme,
    font = wezterm.font {
        family = font_name,
    },
    font_rules = font,
    font_size = font_size,
    line_height = 1.0,
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
            family = font_name,
            weight = "Bold"
        }),
        active_titlebar_bg = p.background,
        inactive_titlebar_bg = p.background,
    },
    colors = {
        tab_bar = {
            background = p.background,
            inactive_tab = {
                bg_color = p.background,
                fg_color = p.ansi[1]
            },
            active_tab = {
                bg_color = p.background,
                fg_color = p.ansi[6]
            }
        }
    },
    inactive_pane_hsb = {
        saturation = 1,
        brightness = 0.6,
    },
}
