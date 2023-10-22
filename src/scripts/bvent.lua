local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
        fallout.display_msg(fallout.message_str(192, 100))
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
        fallout.display_msg(fallout.message_str(192, 101))
    end
end)
