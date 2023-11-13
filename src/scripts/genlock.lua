local fallout = require("fallout")

local start
local pickup_p_proc
local use_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local look_at_p_proc
local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function pickup_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(954, 100))
    end
end

function use_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(954, 100))
    end
end

function use_skill_on_p_proc()
    local self_obj = fallout.self_obj()
    local skill = fallout.action_being_used()
    if skill == 9 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
        if fallout.obj_is_locked(self_obj) then
            if fallout.is_success(roll) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(954, 101))
                fallout.obj_unlock(self_obj)
                fallout.display_msg(fallout.message_str(766, 103) .. "25" .. fallout.message_str(766, 104))
                fallout.give_exp_points(25)
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(954, 102))
                    fallout.jam_lock(self_obj)
                else
                    fallout.display_msg(fallout.message_str(954, 103))
                end
            end
        else
            fallout.display_msg(fallout.message_str(954, 104))
        end
    elseif skill == 10 then
        if fallout.obj_is_locked(self_obj) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(954, 100))
        end
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    if fallout.obj_pid(item_obj) == 84 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, 20)
        if fallout.obj_is_locked(fallout.self_obj()) then
            if fallout.is_success(roll) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(954, 101))
                fallout.obj_unlock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(766, 103) .. "25" .. fallout.message_str(766, 104))
                fallout.give_exp_points(25)
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(954, 102))
                    fallout.display_msg(fallout.message_str(954, 105))
                    fallout.jam_lock(fallout.self_obj())
                    fallout.rm_obj_from_inven(fallout.source_obj(), item_obj)
                    fallout.destroy_object(item_obj)
                else
                    fallout.display_msg(fallout.message_str(954, 103))
                end
            end
        else
            fallout.display_msg(fallout.message_str(954, 104))
        end
    end
end

function look_at_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(954, 100))
    end
end

function map_update_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
