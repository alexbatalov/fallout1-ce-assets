local fallout = require("fallout")

local start
local use_p_proc
local pickup_p_proc
local use_skill_on_p_proc
local timed_event_p_proc
local whoami

local once_only = 1
local Test = 0
local bonus = 0
local failure = 0

function start()
    if once_only then
        once_only = 0
        fallout.set_external_var("locker_ptr", fallout.self_obj())
    end
    if fallout.script_action() == 22 then
        timed_event_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        bonus = -35
        failure = 1
        if fallout.metarule(16, 0) > 1 then
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
                fallout.display_msg(fallout.message_str(56, 204))
                fallout.set_map_var(19, 2)
            else
                fallout.display_msg(fallout.message_str(56, 205))
            end
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
    end
end

function pickup_p_proc()
    use_p_proc()
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.display_msg(fallout.message_str(56, 208))
    end
end

function timed_event_p_proc()
    if not(fallout.combat_is_initialized()) then
        fallout.obj_close(fallout.self_obj())
    end
end

function whoami()
    fallout.set_external_var("locker_ptr", fallout.self_obj())
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
