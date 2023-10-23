local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.script_overrides()
    fallout.move_to(fallout.dude_obj(), 23102, 1)
end)
