local fallout = require("fallout")

local start
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(0) == 1 then
        fallout.display_msg(fallout.message_str(93, 100))
    else
        fallout.display_msg(fallout.message_str(93, 101))
        fallout.set_local_var(0, 1)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
