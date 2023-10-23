local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.move_to(fallout.source_obj(), 13883, 1)
end)
