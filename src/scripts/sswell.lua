local fallout = require("fallout")

local start
local look_at_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(14, 100))
end

function use_obj_on_p_proc()
    local pid = fallout.obj_pid(fallout.obj_being_used_with())
    if pid == 127 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(14, 101))
    elseif pid == 41 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(14, 103))
        fallout.item_caps_adjust(fallout.dude_obj(), -1)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(14, 102))
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
