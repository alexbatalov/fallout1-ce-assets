local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local genericend
local genericcbt
local generic00
local generic01
local generic02
local generic03
local critter_p_proc
local timed_event_p_proc

local hostile = false
local initialized = false
local maxleash = 9
local noevent = false
local loopcount = 0
local SET = 0
local MUTANTS = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(self_obj))
            fallout.set_local_var(5, 1)
        end
        fallout.critter_add_trait(self_obj, 1, 6, 32)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
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
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        if fallout.local_var(1) < 2 then
            -- FIXME: Looks wrong.
            if fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0)) then
                hostile = true
            else
                hostile = true
            end
        end
    end
    if hostile then
        generic01()
    else
        generic00()
    end
end

function genericend()
end

function genericcbt()
end

function generic00()
    local rndx = fallout.random(1, 7)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 100), 7)
    elseif rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 101), 7)
    elseif rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 102), 7)
    elseif rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 103), 7)
    elseif rndx == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 104), 7)
    elseif rndx == 6 then
        generic02()
    elseif rndx == 7 then
        generic03()
    end
end

function generic01()
    local rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 105), 7)
    elseif rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 106), 7)
    elseif rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 107), 7)
    elseif rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 108), 7)
    end
end

function generic02()
    if SET == 0 then
        local rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 109), 7)
        elseif rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 110), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 111), 7)
    end
end

function generic03()
    if MUTANTS == 0 then
        local rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 112), 7)
        elseif rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 113), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 114), 7)
    end
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
    local self_obj = fallout.self_obj()
    fallout.set_local_var(8, fallout.tile_num(self_obj))
    local new_tile = fallout.tile_num_in_direction(fallout.local_var(8), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(7), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(self_obj, new_tile, 0)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
