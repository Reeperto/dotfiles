switch (uname)
    case Linux
        set LUA_CPATH "$LUA_CPATH;$HOME/.lua/lib/linux/?.so"
        set LUA_PATH "$LUA_PATH;$HOME/.lua/lib/linux/?.lua"
    case Darwin
        set LUA_CPATH "$LUA_CPATH;$HOME/.lua/lib/macos/?.so"
        set LUA_PATH "$LUA_PATH;$HOME/.lua/lib/macos/?.lua"
end
