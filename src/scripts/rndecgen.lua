local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc

local hostile = 0
local initialized = false
local creation_pid = 0
local critter_tile = 0

function start()
    if not initialized and misc.map_first_run() then
        creation_pid = fallout.obj_pid(fallout.self_obj())
        if creation_pid == 16777261 then
            fallout.critter_add_trait(fallout.self_obj(), 1, 5, 73)
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
            fallout.debug_msg(" Init Floater.")
        else
            if creation_pid == 16777259 then
                fallout.critter_add_trait(fallout.self_obj(), 1, 5, 72)
                fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
                fallout.debug_msg(" Init Centaur.")
            else
                if creation_pid == 16777230 then
                    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 42)
                    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
                    fallout.debug_msg(" Init ghoul.")
                else
                    fallout.critter_add_trait(fallout.self_obj(), 1, 5, -1)
                    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
                    fallout.debug_msg(" Init defualt.")
                end
            end
        end
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) or (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) <= 4) then
            hostile = 1
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        reputation.inc_evil_critter()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
