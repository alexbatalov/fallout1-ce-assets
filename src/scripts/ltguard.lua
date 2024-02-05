local fallout = require("fallout")
local misc = require("lib.misc")

local start
local critter_p_proc
local map_init_p_proc

local initialized = false
local hostile = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    end
end

function critter_p_proc()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
return exports
