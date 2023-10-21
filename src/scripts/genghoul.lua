local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local genericend
local genericcbt
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

function start()
    if not(init) then
        if fallout.local_var(1) == 0 then
            fallout.set_local_var(1, fallout.tile_num(fallout.self_obj()))
            fallout.set_local_var(0, 1)
            if fallout.cur_map_index() == 9 then
                fallout.set_local_var(3, 1)
            end
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 93)
        fallout.critter_injure(fallout.self_obj(), 4)
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
                    if fallout.script_action() == 13 then
                        if fallout.local_var(3) ~= 0 then
                            if fallout.fixed_param() == 2 then
                                rndx = fallout.random(1, 6) - 5
                                if rndx < 0 then
                                    rndx = 0
                                end
                                if rndx > 0 then
                                    fallout.radiation_inc(fallout.target_obj(), rndx)
                                end
                            end
                        end
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
end

function do_dialogue()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(32, 105 + fallout.random(0, 3)), 7)
end

function genericend()
end

function genericcbt()
end

function Critter_Action()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 3) then
        Hostile = 1
    end
    if Hostile > 0 then
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(0) ~= 0 then
            loopcount = loopcount + 1
            if loopcount > 40 then
                loopcount = 0
                if noevent == 0 then
                    noevent = 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 15)), 0)
                end
            end
        end
    end
end

function timetomove()
    if fallout.obj_on_screen(fallout.self_obj()) then
        noevent = 0
        fallout.set_local_var(2, fallout.tile_num(fallout.self_obj()))
        new_tile = fallout.tile_num_in_direction(fallout.local_var(2), fallout.random(0, 5), fallout.random(1, 5))
        if fallout.tile_distance(fallout.local_var(1), new_tile) < maxleash then
            if fallout.random(0, 1) > 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(32, 105 + fallout.random(0, 3)), 7)
            end
            fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
        end
    else
        Critter_Action()
    end
end

local exports = {}
exports.start = start
return exports
