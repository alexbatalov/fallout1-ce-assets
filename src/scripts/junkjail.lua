local fallout = require("fallout")

local start
local damage_p_proc
local description_p_proc
local map_enter_p_proc
local spatial_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local lockpicking

local triggered = false

local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 2 then
        spatial_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function damage_p_proc()
    fallout.destroy_object(fallout.self_obj())
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(789, 101))
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.tile_num(self_obj) == 18666 then
        fallout.obj_close(self_obj)
        fallout.obj_lock(self_obj)
        fallout.set_external_var("jail_door_ptr", self_obj)
    end
end

function spatial_p_proc()
    if fallout.source_obj() == fallout.dude_obj() and not triggered and fallout.map_var(1) == 1 then
        fallout.display_msg(fallout.message_str(789, 100))
        fallout.set_map_var(1, 0)
        fallout.set_global_var(155, fallout.global_var(155) - 3)
        fallout.display_msg(fallout.message_str(789, 107))
        fallout.give_exp_points(250)
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
        triggered = true
        fallout.destroy_object(fallout.self_obj())
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)
        lockpicking(roll)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
        lockpicking(roll)
    end
end

function lockpicking(roll)
    fallout.script_overrides()
    fallout.set_map_var(3, fallout.map_var(3) + 1)
    local self_obj = fallout.self_obj()
    if fallout.is_success(roll) then
        if fallout.obj_is_locked(self_obj) then
            fallout.obj_unlock(self_obj)
            fallout.display_msg(fallout.message_str(789, 103))
        else
            fallout.obj_lock(self_obj)
            fallout.display_msg(fallout.message_str(789, 104))
        end
    else
        if fallout.obj_is_locked(self_obj) then
            fallout.display_msg(fallout.message_str(789, 105))
        else
            fallout.display_msg(fallout.message_str(789, 106))
        end
    end
end

function use_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(789, 102))
    end
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.description_p_proc = description_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.spatial_p_proc = spatial_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_p_proc = use_p_proc
return exports
