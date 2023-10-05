local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(428, 100))
    else
        if fallout.script_action() == 8 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(428, 101))
        end
    end
end

local exports = {}
exports.start = start
return exports
