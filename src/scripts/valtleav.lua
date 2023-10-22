local fallout = require("fallout")
local factory = require("lib.factory")
local time = require("lib.time")

return factory.create_one_off_spatial_scr(function()
    if time.is_night() then
        fallout.display_msg(fallout.message_str(208, 101))
    else
        fallout.display_msg(fallout.message_str(208, 100))
    end
end)
