local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0

local start
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local map_update_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

-- ?import? variable test
-- ?import? variable messing_with_SkumDoor

function start()
    if fallout.script_action() == 14 then
        damage_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
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
    end
end

function damage_p_proc()
    fallout.set_external_var("SkumDoor_ptr", 0)
    fallout.destroy_object(fallout.self_obj())
end

function destroy_p_proc()
    fallout.set_external_var("SkumDoor_ptr", 0)
end

function map_enter_p_proc()
    fallout.set_external_var("SkumDoor_ptr", fallout.self_obj())
    if (fallout.game_time_hour() > 410) and (fallout.game_time_hour() < 1400) then
        fallout.obj_close(fallout.self_obj())
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
    fallout.set_local_var(0, 0)
end

function map_update_p_proc()
    if (fallout.game_time_hour() > 410) and (fallout.game_time_hour() < 1400) then
        if fallout.local_var(0) == 0 then
            fallout.obj_close(fallout.self_obj())
            fallout.obj_lock(fallout.self_obj())
        end
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.obj_is_locked(fallout.self_obj()) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(853, 100))
        end
    else
        if fallout.external_var("Neal_ptr") ~= 0 then
            if fallout.source_obj() == fallout.external_var("Neal_ptr") then
                fallout.set_local_var(0, 0)
                if fallout.external_var("Neal_closing_door") == 0 then
                    fallout.script_overrides()
                    fallout.obj_open(fallout.self_obj())
                    fallout.obj_unlock(fallout.self_obj())
                else
                    fallout.script_overrides()
                    fallout.obj_close(fallout.self_obj())
                    fallout.obj_lock(fallout.self_obj())
                end
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        if fallout.obj_is_locked(fallout.self_obj()) then
            g0 = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
            if fallout.is_success(g0) then
                fallout.display_msg(fallout.message_str(853, 101))
                fallout.obj_unlock(fallout.self_obj())
                fallout.set_local_var(0, 1)
            else
                if fallout.is_critical(g0) then
                    fallout.display_msg(fallout.message_str(853, 103))
                    fallout.jam_lock(fallout.self_obj())
                else
                    fallout.display_msg(fallout.message_str(853, 102))
                end
            end
        else
            fallout.display_msg(fallout.message_str(853, 104))
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        if fallout.obj_is_locked(fallout.self_obj()) then
            g0 = fallout.roll_vs_skill(fallout.source_obj(), fallout.action_being_used(), -10)
            if fallout.is_success(g0) then
                fallout.display_msg(fallout.message_str(853, 101))
                fallout.obj_unlock(fallout.self_obj())
                fallout.set_local_var(0, 1)
            else
                if fallout.is_critical(g0) then
                    fallout.display_msg(fallout.message_str(853, 103))
                    fallout.jam_lock(fallout.self_obj())
                else
                    fallout.display_msg(fallout.message_str(853, 102))
                end
            end
        else
            fallout.display_msg(fallout.message_str(853, 104))
        end
    end
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
