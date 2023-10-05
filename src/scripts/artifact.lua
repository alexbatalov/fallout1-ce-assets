local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        if fallout.global_var(108) ~= 0 then
            fallout.display_msg(fallout.message_str(333, 100))
        else
            fallout.display_msg(fallout.message_str(333, 106))
        end
    else
        if fallout.script_action() == 6 then
            fallout.script_overrides()
            if fallout.local_var(0) == 1 then
                fallout.display_msg(fallout.message_str(333, 101))
            else
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(333, 102))
                fallout.set_global_var(161, 1)
                fallout.display_msg(fallout.message_str(766, 103) + "100" + fallout.message_str(766, 104))
                fallout.give_exp_points(100)
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
