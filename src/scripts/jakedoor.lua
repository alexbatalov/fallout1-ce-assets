local fallout = require("fallout")
local time = require("lib.time")

local start
local look_at_p_proc
local use_obj_on_p_proc
local map_update_p_proc
local damage_p_proc
local use_skill_on_p_proc

local initialized = false

function start()
    if not initialized then
        fallout.set_external_var("jake_door_ptr", fallout.self_obj())
        map_update_p_proc()
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(589, 203))
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)
    if fallout.obj_pid(item_obj) == 84 then
        fallout.script_overrides()
        if fallout.is_success(roll) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(589, 204))
        else
            if fallout.is_critical(roll) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
                fallout.destroy_object(item_obj)
                fallout.display_msg(fallout.message_str(589, 207))
            else
                fallout.display_msg(fallout.message_str(589, 205))
            end
        end
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    if not time.is_night() then
        fallout.set_local_var(0, 1)
    end
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
    end
    fallout.set_map_var(7, 0)
    if fallout.map_var(6) == 0 then
        if fallout.obj_is_open(self_obj) == 1 then
            fallout.set_map_var(7, 1)
        end
    end
    if fallout.obj_is_locked(self_obj) == 1 then
        fallout.set_local_var(0, 1)
    else
        fallout.set_local_var(0, 0)
    end
end

function damage_p_proc()
    fallout.set_obj_visibility(fallout.self_obj(), true)
    fallout.set_local_var(1, 1)
    fallout.set_map_var(6, 1)
end

function use_skill_on_p_proc()
    if fallout.local_var(0) == 0 then
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -40)
            if fallout.is_success(roll) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(589, 204))
            else
                fallout.display_msg(fallout.message_str(589, 205))
            end
        end
    else
        fallout.display_msg(fallout.message_str(589, 206))
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.damage_p_proc = damage_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
