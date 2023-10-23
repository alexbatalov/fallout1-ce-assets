local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.move_to(fallout.dude_obj(), 17083, 1)
    end
end)
