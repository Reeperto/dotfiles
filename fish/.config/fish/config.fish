if status is-interactive
end

if test (tty) = /dev/tty1
    exec Hyprland
end

mise activate | source
eval (luarocks path)
