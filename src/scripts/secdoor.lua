local fallout = require("fallout")

local start
local dude_use_door
local Officer_use_door
local map_enter_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local give_exps

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function dude_use_door()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(459, 100))
    end
end

function Officer_use_door()
    local self_obj = fallout.self_obj()
    if fallout.obj_is_open(self_obj) then
        fallout.obj_close(self_obj)
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
        fallout.obj_open(self_obj)
    end
end

function map_enter_p_proc()
    fallout.set_external_var("SecDoor_ptr", fallout.self_obj())
end

function use_p_proc()
    local source_obj = fallout.source_obj()
    if source_obj == fallout.dude_obj() then
        dude_use_door()
    elseif source_obj == fallout.external_var("Officer_ptr") then
        Officer_use_door()
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 77 then
        fallout.script_overrides()
        local self_obj = fallout.self_obj()
        if not fallout.obj_is_locked(self_obj) then
            fallout.display_msg(fallout.message_str(459, 101))
        else
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(459, 102))
                fallout.obj_unlock(self_obj)
                give_exps()
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(self_obj)
                    fallout.display_msg(fallout.message_str(459, 104))
                else
                    fallout.display_msg(fallout.message_str(459, 103))
                end
            end
        end
        if fallout.tile_distance_objs(fallout.external_var("Officer_ptr"), fallout.dude_obj()) < 4 then
            if fallout.external_var("armory_access") == 0 then
                fallout.set_external_var("armory_access", 2)
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        local self_obj = fallout.self_obj()
        if not fallout.obj_is_locked(self_obj) then
            fallout.display_msg(fallout.message_str(459, 101))
        else
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -20)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(459, 102))
                fallout.obj_unlock(self_obj)
                give_exps()
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(self_obj)
                    fallout.display_msg(fallout.message_str(459, 104))
                else
                    fallout.display_msg(fallout.message_str(459, 103))
                end
            end
        end
        if fallout.tile_distance_objs(fallout.external_var("Officer_ptr"), fallout.dude_obj()) < 4 then
            if fallout.external_var("armory_access") == 0 then
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
