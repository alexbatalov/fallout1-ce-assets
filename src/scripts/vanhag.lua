local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc

local hostile = false
local sequence = 0
local iseeu = false
local waiting = false
local clock = 4
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 69)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 12 then
        if hostile then
            hostile = false
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.global_var(57) < 1 then
            iseeu = true
        end
        if iseeu and not waiting and fallout.external_var("Lt_ptr") ~= nil and fallout.local_var(4) == 0 then
            waiting = true
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(clock), 1)
        end
    end
end

function destroy_p_proc()
    sequence = 10
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(435, 100))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(435, 101), 0)
end

function timed_event_p_proc()
    waiting = false
    if sequence == 0 then
        fallout.float_msg(fallout.external_var("Lt_ptr"), fallout.message_str(435, 102), 0)
    elseif sequence == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(435, 103), 0)
    elseif sequence == 2 then
        fallout.float_msg(fallout.external_var("Lt_ptr"), fallout.message_str(435, 104), 0)
    elseif sequence == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(435, 105), 0)
    elseif sequence == 4 then
        fallout.float_msg(fallout.external_var("Lt_ptr"), fallout.message_str(435, 106), 0)
    elseif sequence == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(435, 107), 0)
        clock = 6
    elseif sequence == 6 then
        fallout.float_msg(fallout.external_var("Lt_ptr"), fallout.message_str(435, 108), 0)
        clock = 4
    elseif sequence == 7 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(435, 109), 0)
    elseif sequence == 8 then
        fallout.float_msg(fallout.external_var("Lt_ptr"), fallout.message_str(435, 110), 0)
    elseif sequence == 9 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(435, 111), 0)
        if fallout.local_var(4) == 0 then
            fallout.give_exp_points(1000)
            fallout.display_msg(fallout.message_str(435, 112))
            fallout.set_local_var(4, 1)
        end
    end
    sequence = sequence + 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
