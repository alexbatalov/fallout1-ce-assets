local fallout = require("fallout")

local start

local temp = 0

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.local_var(0) < 1 then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(152, 101))
                fallout.display_msg(fallout.message_str(152, 100))
                fallout.give_exp_points(500)
                fallout.display_msg(fallout.message_str(152, 102) + 500 + fallout.message_str(152, 103))
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
