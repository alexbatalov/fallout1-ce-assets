local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(314, 100))
    else
        if fallout.script_action() == 3 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(314, 101))
        end
    end
end

local exports = {}
exports.start = start
return exports
