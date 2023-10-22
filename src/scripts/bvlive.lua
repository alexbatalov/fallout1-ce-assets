local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    local roll = fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0) - 2)
    if fallout.is_success(roll) then
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(150, 100))
        else
            fallout.display_msg(fallout.message_str(150, 101))
        end
    end
end)
