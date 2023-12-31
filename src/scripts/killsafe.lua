local fallout = require("fallout")

local start
local description_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local safe_bonus

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.display_msg(fallout.message_str(340, 105))
    else
        fallout.display_msg(fallout.message_str(340, 101))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(340, 100))
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("KillSafe_ptr", self_obj)
    fallout.obj_close(self_obj)
    fallout.obj_lock(self_obj)
    if fallout.local_var(0) == 0 then
        local item_obj
        if fallout.random(0, 3) == 3 then
            item_obj = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_obj_to_inven(self_obj, item_obj)
        end
        if fallout.random(0, 3) == 3 then
            item_obj = fallout.create_object_sid(31, 0, 0, -1)
            fallout.add_obj_to_inven(self_obj, item_obj)
        end
        if fallout.random(0, 3) == 3 then
            item_obj = fallout.create_object_sid(30, 0, 0, -1)
            fallout.add_obj_to_inven(self_obj, item_obj)
        end
        if fallout.random(0, 3) == 3 then
            item_obj = fallout.create_object_sid(34, 0, 0, -1)
            fallout.add_obj_to_inven(self_obj, item_obj)
        end
        if fallout.random(0, 3) == 3 then
            item_obj = fallout.create_object_sid(4, 0, 0, -1)
            fallout.add_obj_to_inven(self_obj, item_obj)
        end
    end
end

function pickup_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
    end
end

function use_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(340, 105))
        fallout.set_map_var(9, 1)
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        fallout.script_overrides()
        fallout.set_map_var(9, 1)
        if not fallout.obj_is_locked(fallout.self_obj()) then
            fallout.display_msg(fallout.message_str(340, 101))
        else
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -10)
            if fallout.is_success(roll) then
                fallout.obj_unlock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(340, 103))
                safe_bonus()
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(340, 107))
                else
                    fallout.display_msg(fallout.message_str(340, 104))
                end
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        fallout.set_map_var(9, 1)
        if not fallout.obj_is_locked(fallout.self_obj()) then
            fallout.display_msg(fallout.message_str(340, 101))
        else
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -30)
            if fallout.is_success(roll) then
                fallout.obj_unlock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(340, 103))
                safe_bonus()
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(340, 107))
                else
                    fallout.display_msg(fallout.message_str(340, 104))
                end
            end
        end
    end
end

function safe_bonus()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(340, 106))
        fallout.set_local_var(0, 1)
        fallout.give_exp_points(500)
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
