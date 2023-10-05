local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(302, 100))
    else
        if fallout.script_action() == 3 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(302, 101))
        else
            if fallout.script_action() == 8 then
                if fallout.action_being_used() == 13 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(302, 102))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
