local fallout = require("fallout")

local start
local look_at_p_proc
local use_obj_on_p_proc
local map_update_p_proc
local damage_p_proc
local use_skill_on_p_proc

local OnceOnly = 1

function start()
    if OnceOnly then
        OnceOnly = 0
        fallout.set_external_var("jake_door_ptr", fallout.self_obj())
        map_update_p_proc()
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        look_at_p_proc()
    else
        if fallout.script_action() == 7 then
            use_obj_on_p_proc()
        else
            if fallout.script_action() == 8 then
                use_skill_on_p_proc()
            else
                if fallout.script_action() == 23 then
                    map_update_p_proc()
                else
                    if fallout.script_action() == 14 then
                        damage_p_proc()
                    end
                end
            end
        end
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(589, 203))
    end
end

function use_obj_on_p_proc()
    local v0 = 0
    local v1 = 0
    v0 = fallout.obj_being_used_with()
    v1 = fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)
    if fallout.obj_pid(v0) == 84 then
        fallout.script_overrides()
        if fallout.is_success(v1) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(589, 204))
        else
            if fallout.is_critical(v1) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
                fallout.destroy_object(v0)
                fallout.display_msg(fallout.message_str(589, 207))
            else
                fallout.display_msg(fallout.message_str(589, 205))
            end
        end
    end
end

function map_update_p_proc()
    if not((fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600)) then
        fallout.set_local_var(0, 1)
    end
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
    fallout.set_map_var(7, 0)
    if fallout.map_var(6) == 0 then
        if fallout.obj_is_open(fallout.self_obj()) == 1 then
            fallout.set_map_var(7, 1)
        end
    end
    if fallout.obj_is_locked(fallout.self_obj()) == 1 then
        fallout.set_local_var(0, 1)
    else
        fallout.set_local_var(0, 0)
    end
end

function damage_p_proc()
    fallout.set_obj_visibility(fallout.self_obj(), 1)
    fallout.set_local_var(1, 1)
    fallout.set_map_var(6, 1)
end

function use_skill_on_p_proc()
    local v0 = 0
    if fallout.local_var(0) == 0 then
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            v0 = fallout.roll_vs_skill(fallout.dude_obj(), 9, -40)
            if fallout.is_success(v0) then
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
