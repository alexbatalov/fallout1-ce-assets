local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc
local look_at_p_proc
local use_obj_on_p_proc
local damage_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.display_msg(fallout.message_str(526, 104))
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(526, 104))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(526, 100))
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(526, 104))
    end
end

function damage_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(526, 106))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.damage_p_proc = damage_p_proc
return exports
