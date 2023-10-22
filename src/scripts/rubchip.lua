local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    local xp = 500
    fallout.display_msg(fallout.message_str(152, 101))
    fallout.display_msg(fallout.message_str(152, 100))
    fallout.give_exp_points(xp)
    fallout.display_msg(fallout.message_str(152, 102) .. xp .. fallout.message_str(152, 103))
end)
