local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.move_to(fallout.dude_obj(), 27097, 0)
end)
