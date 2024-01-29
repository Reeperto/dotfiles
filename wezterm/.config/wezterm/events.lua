local wezterm = require("wezterm")
local act = wezterm.action

local events = {
    ["trigger-search-zotero"] = function(window, pane)
        window:perform_action(
            act.SpawnCommandInNewTab {
                args = { 'sklib' }
            },
            pane
        )
    end,
    ["trigger-search-notes"] = function(window, pane)
        window:perform_action(
            act.SpawnCommandInNewTab {
                args = { 'notes' }
            },
            pane
        )
    end,
    ["trigger-fd-to-nvim"] = function(window, pane)
        window:perform_action(
            act.SpawnCommandInNewTab {
                args = { 'nvim (fd -H . | sk)' }
            },
            pane
        )
    end
}

return {
    setup = function ()
        for trigger, _action in pairs(events) do
            wezterm.on(trigger, _action)
        end
    end
}

