local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc

local initialized = false
local round = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        misc.set_ai(self_obj, 64)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function critter_p_proc()
    if round < 1 then
        round = round + 1
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 0)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function timed_event_p_proc()
    if round < 7 then
        local self_obj = fallout.self_obj()
        local student_obj = fallout.external_var("Student_ptr")
        local delay
        if round == 1 then
            fallout.anim(student_obj, 16, 0)
            fallout.anim(self_obj, 13, 0)
            delay = 2
        elseif round == 2 then
            fallout.anim(self_obj, 16, 0)
            fallout.anim(student_obj, 14, 0)
            delay = 2
        elseif round == 3 then
            fallout.anim(self_obj, 16, 0)
            fallout.anim(student_obj, 13, 0)
            delay = 2
        elseif round == 4 then
            fallout.anim(self_obj, 17, 0)
            delay = 1
        elseif round == 5 then
            fallout.anim(student_obj, 20, 0)
            delay = 2
        elseif round == 6 then
            fallout.anim(self_obj, 0, 0)
            fallout.anim(student_obj, 37, 0)
            delay = 2
        end
        round = round + 1
        fallout.add_timer_event(self_obj, fallout.game_ticks(delay), 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
