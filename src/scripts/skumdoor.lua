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
    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function damage_p_proc()
    fallout.set_external_var("SkumDoor_ptr", nil)
    fallout.destroy_object(fallout.self_obj())
end

function destroy_p_proc()
    fallout.set_external_var("SkumDoor_ptr", nil)
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    local game_time_hour = fallout.game_time_hour()
    fallout.set_external_var("SkumDoor_ptr", self_obj)
    if game_time_hour > 410 and game_time_hour < 1400 then
        fallout.obj_close(self_obj)
        fallout.obj_lock(self_obj)
    else
        fallout.obj_unlock(self_obj)
    end
    fallout.set_local_var(0, 0)
end

function map_update_p_proc()
    local game_time_hour = fallout.game_time_hour()
    local self_obj = fallout.self_obj()
    if game_time_hour > 410 and game_time_hour < 1400 then
        if fallout.local_var(0) == 0 then
            fallout.obj_close(self_obj)
            fallout.obj_lock(self_obj)
        end
    else
        fallout.obj_unlock(self_obj)
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.obj_is_locked(fallout.self_obj()) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(853, 100))
        end
    else
        local neal_obj = fallout.external_var("Neal_ptr")
        if neal_obj ~= nil then
            if fallout.source_obj() == neal_obj then
                fallout.set_local_var(0, 0)
                local self_obj = fallout.self_obj()
                if fallout.external_var("Neal_closing_door") == 0 then
                    fallout.script_overrides()
                    fallout.obj_open(self_obj)
                    fallout.obj_unlock(self_obj)
                else
                    fallout.script_overrides()
                    fallout.obj_close(self_obj)
                    fallout.obj_lock(self_obj)
                end
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_locked(self_obj) then
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, 0)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(853, 101))
                fallout.obj_unlock(self_obj)
                fallout.set_local_var(0, 1)
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(853, 103))
                    fallout.jam_lock(self_obj)
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
    local skill = fallout.action_being_used()
    if skill == 9 then
        fallout.script_overrides()
        if fallout.obj_is_locked(fallout.self_obj()) then
            local roll = fallout.roll_vs_skill(fallout.source_obj(), skill, -10)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(853, 101))
                fallout.obj_unlock(fallout.self_obj())
                fallout.set_local_var(0, 1)
            else
                if fallout.is_critical(roll) then
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
