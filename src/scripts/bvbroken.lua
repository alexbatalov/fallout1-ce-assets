local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.display_msg("The elevator is broken. Maybe you can use the ladder.")
    end
end

local exports = {}
exports.start = start
return exports
