local fallout = require("fallout")

local start
local damage_p_proc
local timed_event_p_proc
local hear_check
local anger
local anger2

local failure = 0
local bonus = 0
local Test = 0

function start()
    if fallout.script_action() == 14 then
        damage_p_proc()
    else
        if fallout.script_action() == 22 then
            timed_event_p_proc()
        else
            if fallout.script_action() == 8 then
                hear_check()
            else
                if fallout.script_action() == 6 then
                    hear_check()
                else
                    if fallout.script_action() == 7 then
                        hear_check()
                    end
                end
            end
        end
    end
end

function damage_p_proc()
    fallout.set_global_var(250, 1)
    fallout.set_local_var(0, fallout.local_var(0) + 1)
    if fallout.local_var(0) == 3 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.set_map_var(19, 0)
        if not(fallout.combat_is_initialized()) then
            fallout.obj_close(fallout.self_obj())
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
    else
        if fallout.fixed_param() == 2 then
            if fallout.obj_is_open(fallout.self_obj()) then
                fallout.obj_close(fallout.self_obj())
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 3)
            else
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
            end
        else
            if fallout.fixed_param() == 3 then
                fallout.rm_timer_event(fallout.self_obj())
            end
        end
    end
end

function hear_check()
    bonus = -35
    failure = 1
    if (fallout.metarule(16, 0) > 1) and (fallout.source_obj() == fallout.dude_obj()) then
        fallout.set_map_var(19, 2)
    else
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.using_skill(fallout.dude_obj(), 8) then
                Test = fallout.roll_vs_skill(fallout.dude_obj(), 8, bonus)
                if fallout.is_success(Test) then
                    failure = 0
                else
                    failure = 1
                end
                if fallout.has_skill(fallout.dude_obj(), 8) < 40 then
                    failure = 1
                end
            end
        end
        if failure then
            anger()
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
end

function anger()
    if (fallout.map_var(19) < 1) and (fallout.source_obj() == fallout.dude_obj()) then
        fallout.set_map_var(19, 1)
    end
end

function anger2()
    if (fallout.map_var(19) < 1) and (fallout.source_obj() == fallout.dude_obj()) then
        fallout.set_map_var(19, 2)
    end
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
