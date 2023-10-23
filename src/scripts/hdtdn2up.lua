local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    if fallout.map_var(52) == 0 then
        fallout.move_to(fallout.dude_obj(), 25539, 0)
    else
        fallout.display_msg(fallout.message_str(628, 100))
    end
end)
