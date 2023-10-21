local fallout = require("fallout")

local start

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(293, 100 + fallout.random(0, 2)))
    end
end

local exports = {}
exports.start = start
return exports
