local fallout = require("fallout")

local start
local description_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
        fallout.display_msg(fallout.message_str(83, 101))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(83, 100))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
