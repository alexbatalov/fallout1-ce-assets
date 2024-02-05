local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc
local genericend
local genericcbt
local generic00
local generic01
local generic02
local generic03

local loopcount = 0
local noevent = 0
local dist = 0
local curtime = 0
local prevtime = 0
local hostile = false
local SET = 0
local MUTANTS = 0
local MAXLEASH = 9
local DAY = 0
local initialized = false

function start()
    if not initialized then
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, 1)
        end
        misc.set_team(fallout.self_obj(), 32)
        initialized = true
    end

    -- FIXME: Get rid of this stuff.
    curtime = DAY
    if prevtime ~= curtime then
        noevent = curtime
        prevtime = curtime
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(0), 0)
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
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(84, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if hostile then
        generic01()
    else
        generic00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        loopcount = loopcount + 1
        if loopcount > 40 then
            loopcount = 0
            if noevent == 0 then
                noevent = 1
                local delay = 5 + fallout.random(1, 10)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(delay), 0)
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    noevent = curtime
    local rndy = fallout.random(1, 6)
    if rndy > 1 then
        dist = 2
    end
    if rndy > 5 then
        dist = 3
    end
    local rotation = fallout.random(0, 5)
    local prev_tile = fallout.tile_num(fallout.self_obj())
    local new_tile = fallout.tile_num_in_direction(prev_tile, rotation, dist)
    if fallout.tile_distance(fallout.local_var(0), new_tile) < MAXLEASH then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

function genericend()
end

function genericcbt()
end

function generic00()
    local rndx = fallout.random(1, 7)
    if rndx == 1 then
        fallout.gsay_message(84, 100, 50)
    elseif rndx == 2 then
        fallout.gsay_message(84, 101, 50)
    elseif rndx == 3 then
        fallout.gsay_message(84, 102, 50)
    elseif rndx == 4 then
        fallout.gsay_message(84, 103, 50)
    elseif rndx == 5 then
        fallout.gsay_message(84, 104, 50)
    elseif rndx == 6 then
        generic02()
    elseif rndx == 7 then
        generic03()
    end
end

function generic01()
    local rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.gsay_message(84, 105, 50)
    elseif rndx == 2 then
        fallout.gsay_message(84, 106, 50)
    elseif rndx == 3 then
        fallout.gsay_message(84, 107, 50)
    elseif rndx == 4 then
        fallout.gsay_message(84, 108, 50)
    end
end

function generic02()
    if SET == 0 then
        local rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.gsay_message(84, 109, 50)
        elseif rndx == 2 then
            fallout.gsay_message(84, 110, 50)
        end
    else
        fallout.gsay_message(84, 111, 50)
    end
end

function generic03()
    if MUTANTS == 0 then
        local rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.gsay_message(84, 112, 50)
        elseif rndx == 2 then
            fallout.gsay_message(84, 113, 50)
        end
    else
        fallout.gsay_message(84, 114, 50)
    end
end

local exports = {}
exports.start = start
return exports
