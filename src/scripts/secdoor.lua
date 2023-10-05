local fallout = require("fallout")

local start
local dude_use_door
local Officer_use_door
local map_enter_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local give_exps

local test = 0

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 7 then
                use_obj_on_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function dude_use_door()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(459, 100))
    end
end

function Officer_use_door()
    if fallout.obj_is_open(fallout.self_obj()) then
        fallout.obj_close(fallout.self_obj())
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
        fallout.obj_open(fallout.self_obj())
    end
end

function map_enter_p_proc()
    fallout.set_external_var("SecDoor_ptr", fallout.self_obj())
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        dude_use_door()
    else
        if fallout.source_obj() == fallout.external_var("Officer_ptr") then
            Officer_use_door()
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 77 then
        fallout.script_overrides()
        if not(fallout.obj_is_locked(fallout.self_obj())) then
            fallout.display_msg(fallout.message_str(459, 101))
        else
            test = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
            if fallout.is_success(test) then
                fallout.display_msg(fallout.message_str(459, 102))
                fallout.obj_unlock(fallout.self_obj())
                give_exps()
            else
                if fallout.is_critical(test) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(459, 104))
                else
                    fallout.display_msg(fallout.message_str(459, 103))
                end
            end
        end
        if fallout.tile_distance_objs(fallout.external_var("Officer_ptr"), fallout.dude_obj()) < 4 then
            if not(fallout.external_var("armory_access")) then
                fallout.set_external_var("armory_access", 2)
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        if not(fallout.obj_is_locked(fallout.self_obj())) then
            fallout.display_msg(fallout.message_str(459, 101))
        else
            test = fallout.roll_vs_skill(fallout.source_obj(), 9, -20)
            if fallout.is_success(test) then
                fallout.display_msg(fallout.message_str(459, 102))
                fallout.obj_unlock(fallout.self_obj())
                give_exps()
            else
                if fallout.is_critical(test) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(459, 104))
                else
                    fallout.display_msg(fallout.message_str(459, 103))
                end
            end
        end
        if fallout.tile_distance_objs(fallout.external_var("Officer_ptr"), fallout.dude_obj()) < 4 then
            if not(fallout.external_var("armory_access")) then
                fallout.set_external_var("armory_access", 2)
            end
        end
    end
end

function give_exps()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(459, 105))
        fallout.give_exp_points(25)
        fallout.set_local_var(0, 1)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
