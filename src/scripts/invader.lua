local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local mutant00
local combat
local timetomove
local Critter_Action

local hostile = 0
local init_teams = 0
local loopcount = 0
local noevent = 0
local new_tile = 0
local maxleash = 9
local rndx = 0

function start()
    if not(init_teams) then
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.tile_num(fallout.self_obj()))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 79)
        init_teams = 1
    else
        if fallout.script_action() == 22 then
            timetomove()
        end
    end
    if fallout.script_action() == 11 then
        mutant00()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(912, 100))
        else
            if fallout.script_action() == 4 then
                hostile = 1
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

function mutant00()
    rndx = fallout.random(0, 1)
    if rndx == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(912, 101), 2)
    else
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(912, 102), 2)
        end
    end
    combat()
end

function combat()
    hostile = 1
end

function timetomove()
    noevent = 0
    fallout.set_local_var(1, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(1), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(0), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

function Critter_Action()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6) then
            mutant00()
        else
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

local exports = {}
exports.start = start
return exports
