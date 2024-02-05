local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local combat
local timed_event_p_proc
local critter_p_proc

local hostile = false
local initialized = false
local loopcount = 0
local noevent = false
local maxleash = 9

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.tile_num(self_obj))
        end
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 79)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(912, 100))
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        reputation.inc_evil_critter()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    local rndx = fallout.random(0, 1)
    if rndx == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(912, 101), 2)
    elseif rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(912, 102), 2)
    end
    combat()
end

function combat()
    hostile = true
end

function timed_event_p_proc()
    noevent = false
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    fallout.set_local_var(1, self_tile_num)
    local new_tile = fallout.tile_num_in_direction(self_tile_num, fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(0), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(self_obj, new_tile, 0)
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.tile_distance_objs(self_obj, dude_obj) < 6 then
            talk_p_proc()
        else
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if not noevent then
                    noevent = true
                    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
