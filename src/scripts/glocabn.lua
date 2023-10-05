local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(334, 100))
    else
        if fallout.script_action() == 4 then
            if fallout.local_var(0) == 0 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(334, 101))
            end
        else
            if fallout.script_action() == 8 then
                if fallout.action_being_used() == 9 then
                    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -15)) then
                        fallout.set_local_var(0, 1)
                        fallout.display_msg(fallout.message_str(334, 102))
                    else
                        fallout.display_msg(fallout.message_str(334, 103))
                    end
                else
                    if fallout.action_being_used() == 12 then
                        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -5)) then
                            fallout.set_local_var(0, 1)
                            fallout.display_msg(fallout.message_str(334, 104))
                        else
                            fallout.display_msg(fallout.message_str(334, 105))
                        end
                    else
                        fallout.display_msg(fallout.message_str(334, 106))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
