local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc
local look_at_p_proc
local use_obj_on_p_proc
local map_update_p_proc
local damage_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.external_var("Laura_Ptr") then
        fallout.set_local_var(0, 1)
    end
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
    if fallout.local_var(0) == 0 and fallout.source_obj() == fallout.dude_obj() then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 104))
    end
end

function use_skill_on_p_proc()
    if fallout.local_var(0) == 0 then
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -60)
            if fallout.is_success(roll) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(63, 100))
                fallout.display_msg(fallout.message_str(766, 103) .. "85" .. fallout.message_str(766, 104))
                fallout.give_exp_points(85)
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(63, 110))
                else
                    fallout.display_msg(fallout.message_str(63, 103))
                end
            end
        end
    else
        fallout.display_msg(fallout.message_str(63, 109))
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 104))
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local item_pid = fallout.obj_pid(item_obj)
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -40)
    if item_pid == 84 then
        fallout.script_overrides()
        if fallout.is_success(roll) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(63, 100))
            fallout.display_msg(fallout.message_str(766, 103) .. "85" .. fallout.message_str(766, 104))
            fallout.give_exp_points(85)
        else
            if fallout.is_critical(roll) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
                fallout.destroy_object(item_obj)
                fallout.jam_lock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(63, 110))
                fallout.display_msg(fallout.message_str(63, 101))
            else
                fallout.display_msg(fallout.message_str(63, 103))
            end
        end
    elseif item_pid == 141 or item_pid == 142 then
        fallout.script_overrides()
        fallout.set_local_var(0, 1)
        fallout.display_msg(fallout.message_str(63, 100))
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Red_Door_Ptr", self_obj)
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
    end
end

function damage_p_proc()
    fallout.set_obj_visibility(fallout.self_obj(), true)
    fallout.set_local_var(1, 1)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.damage_p_proc = damage_p_proc
return exports
