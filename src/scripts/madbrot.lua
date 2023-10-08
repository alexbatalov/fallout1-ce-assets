local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local combat
local do_action
local timetomove

local Hostile = 0
local init = 0
local maxleash = 10
local noevent = 0
local loopcount = 0
local rndx = 0
local rndy = 0
local rndz = 0
local dist = 0
local new_tile = 0

function start()
    if not(init) then
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(fallout.self_obj()))
            fallout.set_local_var(1, 1)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 32)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
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
                        do_action()
                    else
                        if fallout.script_action() == 18 then
                            reputation.inc_good_critter()
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
end

function combat()
    Hostile = 1
end

function do_action()
    if fallout.global_var(250) then
        Hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        Hostile = 0
    end
    if Hostile then
        fallout.set_global_var(250, 1)
        Hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(1) then
            if fallout.random(1, 20) < 2 then
                if fallout.random(1, 10) < 2 then
                    fallout.use_obj(fallout.external_var("table_ptr"))
                else
                    timetomove()
                end
            end
        end
    end
end

function timetomove()
    noevent = 0
    fallout.set_local_var(4, fallout.tile_num(fallout.self_obj()))
    new_tile = fallout.tile_num_in_direction(fallout.local_var(4), fallout.random(0, 5), 2)
    if fallout.tile_distance(fallout.local_var(3), new_tile) < maxleash then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
end

local exports = {}
exports.start = start
return exports
