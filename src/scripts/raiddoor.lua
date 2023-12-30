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
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
    if fallout.local_var(0) == 0 and fallout.source_obj() == fallout.dude_obj() then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 104))
    else
        if fallout.map_var(2) == 0 then
            fallout.set_map_var(2, 1)
        end
    end
end

function use_skill_on_p_proc()
    if fallout.local_var(0) == 0 then
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
            if fallout.is_success(roll) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(63, 100))
                fallout.give_exp_points(25)
                fallout.display_msg(fallout.message_str(766, 103) .. "25" .. fallout.message_str(766, 104))
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
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 20)
    if fallout.obj_pid(item_obj) == 84 then
        fallout.script_overrides()
        if fallout.is_success(roll) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(63, 100))
            fallout.display_msg(fallout.message_str(766, 103) .. "25" .. fallout.message_str(766, 104))
            fallout.give_exp_points(25)
        else
            if fallout.is_critical(roll) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
                fallout.destroy_object(item_obj)
                fallout.display_msg(fallout.message_str(63, 101))
            else
                fallout.display_msg(fallout.message_str(63, 103))
            end
        end
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Cell_Door_Ptr", self_obj)
    if fallout.map_var(2) ~= 0 then
        fallout.set_local_var(0, 1)
    end
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
    end
end

function damage_p_proc()
    fallout.set_obj_visibility(fallout.self_obj(), true)
    fallout.set_local_var(1, 1)
    fallout.set_global_var(254, 1)
    fallout.set_map_var(2, 1)
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
