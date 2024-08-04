local cmp = require("cmp")
local sources = cmp.get_config().sources

sources[#sources + 1] = { name = "omni" }

cmp.setup.buffer({ sources = sources })
