local fallout = require("fallout")

local start
local look_at_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local alert
local damage_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function look_at_p_proc()
    fallout.set_map_var(3, fallout.self_obj())
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.source_obj() == fallout.external_var("Katja_ptr") then
        fallout.obj_unlock(fallout.self_obj())
        fallout.float_msg(fallout.external_var("Katja_ptr"), fallout.message_str(623, 172), 0)
    else
        if not fallout.obj_is_locked(fallout.self_obj()) then
            fallout.load_map(31, 12)
        else
            if fallout.map_var(1) == 1 or fallout.global_var(271) == 1 then
                fallout.display_msg(fallout.message_str(526, 101))
                fallout.obj_unlock(fallout.self_obj())
            else
                fallout.display_msg(fallout.message_str(526, 100))
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 77 then
        if not fallout.obj_is_locked(fallout.self_obj()) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(526, 102))
        else
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -40)) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(526, 103))
                fallout.obj_unlock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(766, 103) .. "65" .. fallout.message_str(766, 104))
                fallout.give_exp_points(65)
            else
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(526, 104))
                fallout.set_local_var(0, fallout.local_var(0) + 1)
            end
        end
    end
    alert()
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        if not fallout.obj_is_locked(fallout.self_obj()) then
            fallout.display_msg(fallout.message_str(526, 102))
        else
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -60)) then
                fallout.script_overrides()
                fallout.obj_unlock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(526, 103))
                fallout.give_exp_points(85)
                fallout.display_msg(fallout.message_str(766, 103) .. "85" .. fallout.message_str(766, 104))
            else
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(526, 105))
                fallout.set_local_var(0, fallout.local_var(0) + 1)
            end
        end
    end
    alert()
end

function alert()
    if fallout.local_var(0) > 2 then
        fallout.set_global_var(146, 1)
    end
end

function damage_p_proc()
    fallout.set_local_var(0, fallout.local_var(0) + 1)
    fallout.display_msg(fallout.message_str(526, 106))
    alert()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.damage_p_proc = damage_p_proc
return exports
