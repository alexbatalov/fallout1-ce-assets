local fallout = require("fallout")

local start
local look_at_p_proc

function start()
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 6 then
            fallout.display_msg(fallout.message_str(725, 101))
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(725, 100))
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
