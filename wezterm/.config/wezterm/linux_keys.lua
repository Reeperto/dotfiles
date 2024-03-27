local wezterm = require("wezterm")
local act = wezterm.action

return {
    mappings = {
        { key = "c",     mods = "CMD",       action = act.CopyTo("Clipboard") },
        { key = "v",     mods = "CMD",       action = act.PasteFrom("Clipboard") },
        { key = "w",     mods = "CMD",       action = act.CloseCurrentTab({ confirm = false }) },
        { key = "]",     mods = "CMD", action = act.ActivateTabRelative(1) },
        { key = "[",     mods = "CMD", action = act.ActivateTabRelative(-1) },
        { key = "=",     mods = "CMD",       action = act.IncreaseFontSize },
        { key = "-",     mods = "CMD",       action = act.DecreaseFontSize },
        { key = "`",     mods = "CMD",       action = act.ResetFontSize },
        { key = "n",     mods = "CMD",       action = act.SpawnWindow },
        -- {
        --     key = "P",
        --     mods = "CMD|SHIFT",
        --     action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
        -- },
        { key = "LeftArrow",  mods = "CMD|ALT", action = act.ActivatePaneDirection("Left") },
        { key = "RightArrow", mods = "CMD|ALT", action = act.ActivatePaneDirection("Right") },
        { key = "UpArrow",    mods = "CMD|ALT", action = act.ActivatePaneDirection("Up") },
        { key = "DownArrow",  mods = "CMD|ALT", action = act.ActivatePaneDirection("Down") },
        { key = "a",          mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
        { key = "d",          mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "t",          mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
        -- { key = "c",          mods = "ALT", action = act.EmitEvent('trigger-search-zotero') },
        -- { key = "n",          mods = "ALT", action = act.EmitEvent('trigger-search-notes') },
        -- { key = "v",          mods = "ALT", action = act.EmitEvent('trigger-fd-to-nvim') },
    },
    leader = {
        key = "b",
        mods = "CMD",
        timeout_milliseconds = 2000
    }
}
