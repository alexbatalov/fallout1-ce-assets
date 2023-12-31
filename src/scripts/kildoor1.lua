local fallout = require("fallout")
local time = require("lib.time")

local start
local damage_p_proc
local map_enter_p_proc
local map_update_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function damage_p_proc()
    fallout.destroy_object(fallout.self_obj())
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if time.is_night() then
        fallout.obj_close(self_obj)
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
    end
    fallout.obj_close(self_obj)
    fallout.set_local_var(0, 0)
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    if time.is_night() and fallout.local_var(0) == 0 then
        fallout.obj_close(self_obj)
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
    end
end

function use_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(873, 100))
    else
        if time.is_night() then
            fallout.set_map_var(8, 1)
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        fallout.script_overrides()
        fallout.set_map_var(8, 1)
        local self_obj = fallout.self_obj()
        if not fallout.obj_is_locked(self_obj) then
            fallout.display_msg(fallout.message_str(873, 104))
        else
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(873, 101))
                fallout.obj_unlock(self_obj)
                fallout.set_local_var(0, 1)
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(873, 103))
                    fallout.jam_lock(self_obj)
                else
                    fallout.display_msg(fallout.message_str(873, 102))
                end
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        fallout.set_map_var(8, 1)
        local self_obj = fallout.self_obj()
        if not fallout.obj_is_locked(self_obj) then
            fallout.display_msg(fallout.message_str(873, 104))
        else
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -20)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(873, 101))
                fallout.obj_unlock(self_obj)
                fallout.set_local_var(0, 1)
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(873, 103))
                    fallout.jam_lock(self_obj)
                else
                    fallout.display_msg(fallout.message_str(873, 102))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
