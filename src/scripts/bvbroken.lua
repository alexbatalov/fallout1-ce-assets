local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.script_overrides()
    fallout.display_msg("The elevator is broken. Maybe you can use the ladder.")
end)
