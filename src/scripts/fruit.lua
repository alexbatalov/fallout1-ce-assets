local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 17, 0)) then
        fallout.display_msg(fallout.message_str(127, 100))
    end
end)
