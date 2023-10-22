local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 2)) then
        fallout.display_msg(fallout.message_str(191, 100))
    end
end)
