local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    if fallout.get_critter_stat(fallout.dude_obj(), 4) > 6 then
        fallout.display_msg(fallout.message_str(111, 100))
    else
        fallout.display_msg(fallout.message_str(111, 101))
    end
end)
