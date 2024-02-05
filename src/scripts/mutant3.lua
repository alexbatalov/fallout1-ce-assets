local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(13) == 0 then
            fallout.set_obj_visibility(fallout.self_obj(), true)
        else
            if fallout.local_var(0) ~= 1 then
                local couple_of_minutes = 150 + fallout.random(1, 60)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(couple_of_minutes), 0)
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(35, fallout.global_var(35) + 1)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(232, 100))
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.local_var(0) == 1 then
        fallout.animate_move_obj_to_tile(self_obj, 16929, 0)
        fallout.set_local_var(0, 0)
    else
        fallout.animate_move_obj_to_tile(self_obj, 10917, 0)
        fallout.set_local_var(0, 1)
        fallout.add_timer_event(self_obj, fallout.game_ticks(40), 0)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
