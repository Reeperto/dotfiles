local socket = require("posix.sys.socket")
local unistd = require("posix.unistd")
local hyprid = os.getenv("HYPRLAND_INSTANCE_SIGNATURE")

return {
    send = function(msg)
        local fd = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)
        assert(socket.connect(fd, { family = socket.AF_UNIX, path = "/tmp/hypr/" .. hyprid .. "/.socket.sock" }))
        socket.send(fd, msg)
        unistd.close(fd)
    end,
    listen = function(listener)
        local fd = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)
        assert(socket.connect(fd, { family = socket.AF_UNIX, path = "/tmp/hypr/" .. hyprid .. "/.socket2.sock" }))

        while true do
            ---@type string|nil
            local msg = socket.recv(fd, 200)
            if msg ~= nil then
                for line in msg:gmatch('[^\n]+') do
                    listener(line)
                end
            end
        end
        unistd.close(fd)
    end
}
