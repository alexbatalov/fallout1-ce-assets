local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local do_dialogue
local timeforwhat
local genericend
local genericcbt

local Hostile = 0
local initialized = false
local noevent = 0
local loopcount = 0
local rndx = 0
local rndy = 0
local rndz = 0
local dist = 0
local time = 0
local maxsight = 0
local maxleash = 9
local new_tile = 0

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 34)
        initialized = true
    end
    if fallout.script_action() == 22 then
        timeforwhat()
    else
        if fallout.local_var(2) == 0 then
            fallout.set_local_var(2, fallout.tile_num(fallout.self_obj()))
        end
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if fallout.global_var(13) == 0 then
                        fallout.set_obj_visibility(fallout.self_obj(), 1)
                    else
                        maxsight = fallout.get_critter_stat(fallout.self_obj(), 1)
                        time = fallout.game_time_hour()
                        if (time > 2300) or (time < 600) then
                            maxsight = 4
                        end
                        if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= maxsight) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                            if (Hostile > 0) or (fallout.local_var(0) > 0) then
                                Hostile = 0
                                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                            else
                                do_dialogue()
                            end
                        end
                        loopcount = loopcount + 1
                        if loopcount > 40 then
                            loopcount = 0
                            if noevent == 0 then
                                noevent = 1
                                rndx = 5 + fallout.random(1, 10)
                                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(rndx), 0)
                            end
                        end
                    end
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(35, fallout.global_var(35) + 1)
                        reputation.inc_evil_critter()
                    else
                        if fallout.script_action() == 21 then
                            fallout.display_msg(fallout.message_str(13, 100))
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(13, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_local_var(0, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(13, 101, 50)
    else
        fallout.gsay_message(13, 102, 50)
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timeforwhat()
    noevent = 0
    rndy = fallout.random(1, 6)
    if rndy > 1 then
        dist = 2
    end
    if rndy > 5 then
        dist = 3
    end
    rndz = fallout.random(0, 5)
    fallout.set_local_var(3, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(3), rndz, dist)
    if fallout.tile_distance(fallout.local_var(2), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

function genericend()
end

function genericcbt()
end

local exports = {}
exports.start = start
return exports
