if not vim.g.vscode then
    require("utils")
    require("bootstrap")
    require("config")
end

-- local out = require("nightfox.palette.carbonfox")
-- out.spec = out.generate_spec(out.palette)

-- vim.fn.setreg("a", vim.inspect(out))
