local wezterm = require("wezterm")
local keys = require("keys")
local font = require("font")

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

return {
	-- default_prog = { "/opt/homebrew/bin/nu" },
	window_decorations = "RESIZE",
	color_scheme = 'Gruvbox Material (Gogh)',
	font = wezterm.font {
		family = "PragmataPro Mono Liga",
		harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		italic = false,
	},
	font_rules = font,
	font_size = is_darwin() and 16 or 13,
	line_height = 1.2,
	scrollback_lines = 5000,
	max_fps = 120,
	adjust_window_size_when_changing_font_size = false,
	hide_tab_bar_if_only_one_tab = true,
	disable_default_key_bindings = true,
	leader = keys.leader,
	keys = keys.mappings,
	use_dead_keys = false,
	inactive_pane_hsb = {
		saturation = 1,
		brightness = 0.6,
	},
	window_frame = {
		font = wezterm.font({ family = "PragmataPro Liga", weight = "Regular" }),
		active_titlebar_bg = "#1d2021",
		inactive_titlebar_bg = "#1d2021",
	},
	colors = {
		background = "#1d2021",
		tab_bar = {
			background = "#1d2021",
			inactive_tab = {
				bg_color = "#1d2021",
				fg_color = "#3c3836"
			},
			active_tab = {
				bg_color = "#1d2021",
				fg_color = "#d8a657"
			}
		}
	}
}
