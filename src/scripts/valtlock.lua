local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_one_off_spatial_scr(function()
    fallout.display_msg(fallout.message_str(131, 100))
end)
