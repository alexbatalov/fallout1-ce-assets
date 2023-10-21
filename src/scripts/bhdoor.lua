local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc
local look_at_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Door_ptr", self_obj)
    if fallout.obj_is_open(self_obj) then
        fallout.add_timer_event(self_obj, fallout.game_ticks(1), 1)
    end
end

function map_update_p_proc()
    fallout.set_external_var("Door_ptr", fallout.self_obj())
end

function look_at_p_proc()
    if fallout.global_var(108) == 2 and fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(526, 102))
    else
        fallout.display_msg(fallout.message_str(526, 100))
    end
end

function use_p_proc()
    if fallout.global_var(108) ~= 2 and fallout.local_var(0) == 0 then
        if fallout.source_obj() ~= fallout.external_var("Cabbot_Ptr") then
            fallout.script_overrides()
            fallout.set_map_var(0, fallout.map_var(0) + 1)
            fallout.display_msg(fallout.message_str(526, 104))
        end
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -50)
    if fallout.global_var(108) ~= 2 then
        fallout.set_map_var(0, fallout.map_var(0) + 1)
    end
    if fallout.obj_pid(item_obj) == 77 then
        fallout.script_overrides()
        if fallout.is_success(roll) then
            if fallout.global_var(108) ~= 2 then
                fallout.set_map_var(0, fallout.map_var(0) + 2)
            end
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(63, 100))
            fallout.display_msg(fallout.message_str(766, 103) .. "75" .. fallout.message_str(766, 104))
            fallout.give_exp_points(75)
        else
            if fallout.is_critical(roll) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
                fallout.destroy_object(item_obj)
                fallout.jam_lock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(63, 101))
            else
                fallout.display_msg(fallout.message_str(63, 103))
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.global_var(108) ~= 2 then
        fallout.set_map_var(0, fallout.map_var(0) + 1)
    end
    if fallout.local_var(0) == 0 then
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -70)
            if fallout.is_success(roll) then
                fallout.set_local_var(0, 1)
                if fallout.global_var(108) ~= 2 then
                    fallout.set_map_var(0, fallout.map_var(0) + 2)
                    fallout.set_global_var(250, 1)
                end
                fallout.display_msg(fallout.message_str(63, 100))
                fallout.give_exp_points(75)
                fallout.display_msg(fallout.message_str(766, 103) .. "75" .. fallout.message_str(766, 104))
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

function timed_event_p_proc()
    fallout.set_local_var(0, 0)
    fallout.obj_close(fallout.self_obj())
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
