if status is-interactive
end

if test (tty) = /dev/tty1
    exec Hyprland
end

mise activate | source
eval (luarocks path)

# pnpm
set -gx PNPM_HOME "/home/eeleyes/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
