local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 4 then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(331, 100))
        end
    else
        if fallout.script_action() == 8 then
            if fallout.action_being_used() == 9 then
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
                    fallout.set_local_var(0, 1)
                    fallout.display_msg(fallout.message_str(331, 101))
                else
                    fallout.display_msg(fallout.message_str(331, 102))
                end
            else
                fallout.display_msg(fallout.message_str(331, 103))
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
