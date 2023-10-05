local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        if (fallout.global_var(74) == 2) and fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
            fallout.display_msg(fallout.message_str(297, 100))
        else
            fallout.display_msg(fallout.message_str(297, 101))
        end
    else
        if fallout.script_action() == 8 then
            fallout.script_overrides()
            if fallout.action_being_used() == 7 then
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 7, 0)) then
                    fallout.display_msg(fallout.message_str(297, 102))
                else
                    fallout.display_msg(fallout.message_str(297, 103))
                end
            else
                fallout.display_msg(fallout.message_str(297, 104))
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
