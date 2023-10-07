local fallout = require("fallout")

local start
local critter_p_proc
local map_init_p_proc

local hostile = 0

function start()
    if fallout.script_action() == map_init_p_proc() then
        map_init_p_proc()
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        end
    end
end

function critter_p_proc()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
        hostile = 1
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function map_init_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 48)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.map_init_p_proc = map_init_p_proc
return exports
