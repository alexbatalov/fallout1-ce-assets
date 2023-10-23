local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(21, 100))
end)
