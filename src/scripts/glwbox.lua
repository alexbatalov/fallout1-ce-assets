local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(308, 100))
    else
        if fallout.script_action() == 7 then
            if fallout.obj_being_used_with() == 84 then
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
                    fallout.set_local_var(0, 1)
                    fallout.display_msg(fallout.message_str(308, 101))
                else
                    fallout.display_msg(fallout.message_str(308, 102))
                end
            else
                fallout.display_msg(fallout.message_str(308, 103))
            end
        else
            if fallout.script_action() == 6 then
                if fallout.local_var(0) == 0 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(308, 104))
                end
            else
                if fallout.script_action() == 8 then
                    fallout.script_overrides()
                    if fallout.action_being_used() == 9 then
                        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -15)) then
                            fallout.set_local_var(0, 1)
                            fallout.display_msg(fallout.message_str(308, 105))
                        else
                            fallout.display_msg(fallout.message_str(308, 106))
                        end
                    else
                        fallout.display_msg(fallout.message_str(308, 107))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
