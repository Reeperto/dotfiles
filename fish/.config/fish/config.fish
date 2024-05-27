mise activate fish | source

# if status is-interactive
# end

# eval (mise x luajit --command "luarocks path") <-- this hangs for some reason :3
# eval (mise x luajit -- luarocks path)
eval (luarocks path)

switch (uname)
    case Linux
        set LUA_CPATH "$LUA_CPATH;$HOME/.lua/lib/linux/?.so"
        set LUA_PATH "$LUA_PATH;$HOME/.lua/lib/linux/?.lua;$HOME/.lua/lib/linux/?/init.lua"
    case Darwin
        set LUA_CPATH "$LUA_CPATH;$HOME/.lua/lib/macos/?.so"
        set LUA_PATH "$LUA_PATH;$HOME/.lua/lib/macos/?.lua;$HOME/.lua/lib/linux/?/init.lua"
end

# pnpm
set -gx PNPM_HOME "/home/eeleyes/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Launch Hyprland
if test (tty) = /dev/tty1
    exec Hyprland
end
