local fallout = require("fallout")

local start
local map_enter_p_proc
local pickup_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local pick_lock
local timed_event_p_proc
local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function map_enter_p_proc()
    fallout.set_external_var("Fridge_ptr", fallout.self_obj())
end

function pickup_p_proc()
    if fallout.source_obj() ~= fallout.external_var("Garret_ptr") then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
        else
            if fallout.local_var(1) == 0 then
                fallout.script_overrides()
            end
        end
    end
end

function use_p_proc()
    local source_obj = fallout.source_obj()
    local garret_obj = fallout.external_var("Garret_ptr")
    if source_obj == garret_obj then
        if fallout.local_var(1) == 0 then
            fallout.set_local_var(0, 1)
            fallout.set_local_var(1, 1)
        else
            if source_obj == garret_obj then
                fallout.set_local_var(1, 0)
                fallout.set_local_var(0, 0)
            else
                fallout.script_overrides()
                fallout.float_msg(garret_obj, fallout.message_str(420, 104), 0)
            end
        end
    else
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(420, 100))
        else
            if fallout.local_var(1) ~= 0 then
                fallout.set_local_var(1, 0)
            else
                fallout.set_local_var(1, 1)
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        pick_lock()
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        pick_lock()
    end
end

function pick_lock()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(420, 101))
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
            fallout.display_msg(fallout.message_str(420, 102))
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(766, 103) .. "25" .. fallout.message_str(766, 104))
            fallout.give_exp_points(25)
        else
            fallout.display_msg(fallout.message_str(420, 103))
        end
    end
end

function timed_event_p_proc()
    fallout.float_msg(fallout.external_var("Garret_ptr"), fallout.message_str(420, 105), 0)
end

function map_update_p_proc()
    fallout.set_external_var("Fridge_ptr", fallout.self_obj())
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
