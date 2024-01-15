local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on('trigger-search-zotero', function(window, pane)
	window:perform_action(
		act.SpawnCommandInNewTab {
			args = { 'fish', '-c', 'sklib' }
		},
		pane
	)
end)

wezterm.on('trigger-search-notes', function(window, pane)
	window:perform_action(
		act.SpawnCommandInNewTab {
			args = { 'fish', '-c', 'notes' }
		},
		pane
	)
end)

wezterm.on('trigger-fd-to-nvim', function(window, pane)
	window:perform_action(
		act.SpawnCommandInNewTab {
			args = { 'fish', '-c', 'nvim (fd -H . | sk)' }
		},
		pane
	)
end)

return {
	mappings = {
		{ key = "]",     mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "[",     mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "Enter", mods = "CMD",       action = act.ToggleFullScreen },
		-- { key = "Enter", mods = "CMD",       action = act.ActivateCopyMode },
		{ key = "R",     mods = "CMD|SHIFT", action = act.ReloadConfiguration },
		{ key = "+",     mods = "CMD",       action = act.IncreaseFontSize },
		{ key = "-",     mods = "CMD",       action = act.DecreaseFontSize },
		{ key = "0",     mods = "CMD",       action = act.ResetFontSize },
		{ key = "c",     mods = "CMD",       action = act.CopyTo("Clipboard") },
		{ key = "n",     mods = "CMD",       action = act.SpawnWindow },
		{
			key = "P",
			mods = "CMD|SHIFT",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		{ key = "v",          mods = "CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "v",          mods = "CMD", action = act.PasteFrom("Clipboard") },
		{ key = "LeftArrow",  mods = "CMD", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "CMD", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow",    mods = "CMD", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow",  mods = "CMD", action = act.ActivatePaneDirection("Down") },
		{ key = "f",          mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "d",          mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "t",          mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w",          mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
		{ key = "c",          mods = "ALT", action = act.EmitEvent('trigger-search-zotero') },
		{ key = "n",          mods = "ALT", action = act.EmitEvent('trigger-search-notes') },
		{ key = "v",          mods = "ALT", action = act.EmitEvent('trigger-fd-to-nvim') },
	},
	leader = {
		key = "b",
		mods = "CMD",
		timeout_milliseconds = 2000
	}
}
