local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(308, 104))
    end
end

function use_obj_on_p_proc()
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
end

function use_skill_on_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(308, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
