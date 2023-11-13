local fallout = require("fallout")

local start
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(299, fallout.random(100, 103)))
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
