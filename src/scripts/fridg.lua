local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.set_map_var(0, 1)
end)
