local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local genericend
local genericcbt
local generic00
local generic01
local generic02
local generic03
local Critter_Action
local timetomove

local Hostile = 0
local init = 0
local maxleash = 9
local noevent = 0
local loopcount = 0
local rndx = 0
local rndy = 0
local rndz = 0
local dist = 0
local new_tile = 0
local SET = 0
local MUTANTS = 0

local exit_line = 0

function start()
    if not(init) then
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(fallout.self_obj()))
            fallout.set_local_var(5, 1)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 32)
        init = 1
    else
        if fallout.script_action() == 22 then
            timetomove()
        else
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if fallout.script_action() == 4 then
                    Hostile = 1
                else
                    if fallout.script_action() == 12 then
                        Critter_Action()
                    else
                        if fallout.script_action() == 18 then
                            reputation.inc_evil_critter()
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        if fallout.local_var(1) < 2 then
            if fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0)) then
                Hostile = Hostile + 1
            else
                Hostile = Hostile + 2
            end
        end
    end
    if Hostile then
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
    rndx = fallout.random(1, 7)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 100), 7)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 101), 7)
    end
    if rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 102), 7)
    end
    if rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 103), 7)
    end
    if rndx == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 104), 7)
    end
    if rndx == 6 then
        generic02()
    end
    if rndx == 7 then
        generic03()
    end
end

function generic01()
    rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 105), 7)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 106), 7)
    end
    if rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 107), 7)
    end
    if rndx == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 108), 7)
    end
end

function generic02()
    if SET == 0 then
        rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 109), 7)
        end
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 110), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 111), 7)
    end
end

function generic03()
    if MUTANTS == 0 then
        rndx = fallout.random(1, 2)
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 112), 7)
        end
        if rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 113), 7)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(66, 114), 7)
    end
end

function Critter_Action()
    if Hostile > 0 then
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) ~= 0 then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if noevent == 0 then
                    noevent = 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 13)), 0)
                end
            end
        end
    end
end

function timetomove()
    noevent = 0
    fallout.set_local_var(8, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(8), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(7), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

local exports = {}
exports.start = start
return exports
