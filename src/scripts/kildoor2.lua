local fallout = require("fallout")
local time = require("lib.time")

local start
local damage_p_proc
local map_enter_p_proc
local map_update_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

local test = 0

function start()
    if fallout.script_action() == 14 then
        damage_p_proc()
    else
        if fallout.script_action() == 15 then
            map_enter_p_proc()
        else
            if fallout.script_action() == 23 then
                map_update_p_proc()
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
    end
end

function damage_p_proc()
    fallout.destroy_object(fallout.self_obj())
end

function map_enter_p_proc()
    fallout.obj_close(fallout.self_obj())
    if time.is_night() then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
    fallout.set_local_var(0, 0)
end

function map_update_p_proc()
    if time.is_night() and (fallout.local_var(0) == 0) then
        fallout.obj_close(fallout.self_obj())
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

function use_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(873, 100))
    else
        if time.is_day() and fallout.obj_can_see_obj(fallout.dude_obj(), fallout.external_var("Killian_ptr")) then
            fallout.script_overrides()
        end
    end
    fallout.set_map_var(9, 1)
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        fallout.script_overrides()
        if not time.is_day() and (fallout.obj_can_see_obj(fallout.external_var("Killian_ptr"), fallout.dude_obj()) == 0) then
            if not(fallout.obj_is_locked(fallout.self_obj())) then
                fallout.display_msg(fallout.message_str(873, 104))
            else
                test = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
                if fallout.is_success(test) then
                    fallout.display_msg(fallout.message_str(873, 101))
                    fallout.obj_unlock(fallout.self_obj())
                    fallout.set_local_var(0, 1)
                else
                    if fallout.is_critical(test) then
                        fallout.display_msg(fallout.message_str(873, 103))
                        fallout.jam_lock(fallout.self_obj())
                    else
                        fallout.display_msg(fallout.message_str(873, 102))
                    end
                end
            end
        end
        fallout.set_map_var(9, 1)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        if not time.is_day() and (fallout.obj_can_see_obj(fallout.external_var("Killian_ptr"), fallout.dude_obj()) == 0) then
            if not(fallout.obj_is_locked(fallout.self_obj())) then
                fallout.display_msg(fallout.message_str(873, 104))
            else
                test = fallout.roll_vs_skill(fallout.source_obj(), 9, -20)
                if fallout.is_success(test) then
                    fallout.display_msg(fallout.message_str(873, 101))
                    fallout.obj_unlock(fallout.self_obj())
                    fallout.set_local_var(0, 1)
                else
                    if fallout.is_critical(test) then
                        fallout.display_msg(fallout.message_str(873, 103))
                        fallout.jam_lock(fallout.self_obj())
                    else
                        fallout.display_msg(fallout.message_str(873, 102))
                    end
                end
            end
        end
        fallout.set_map_var(9, 1)
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
