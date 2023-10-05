local fallout = require("fallout")

local start
local description_p_proc

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(681, 100))
    if fallout.global_var(138) == 1 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
            fallout.display_msg(fallout.message_str(681, 101))
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
return exports
