local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local groundr00
local groundr01
local critter_p_proc
local timed_event_p_proc

local hostile = false
local initialized = false
local maxleash = 9
local noevent = false
local loopcount = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(6) == 0 then
            fallout.set_local_var(6, fallout.tile_num(self_obj))
            fallout.set_local_var(5, 1)
        end
        fallout.critter_add_trait(self_obj, 1, 6, 31)
        fallout.critter_add_trait(self_obj, 1, 5, 40)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(1) < 2 then
        groundr01()
    else
        groundr00()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(77, 100))
end

function groundr00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(77, fallout.random(101, 104)), 0)
end

function groundr01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(77, fallout.random(105, 107)), 0)
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) ~= 0 then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if not noevent then
                    noevent = true
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

function timed_event_p_proc()
    noevent = false
    fallout.set_local_var(7, fallout.tile_num(fallout.self_obj()))
    local new_tile = fallout.tile_num_in_direction(fallout.local_var(7), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(6), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
