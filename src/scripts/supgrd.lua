local fallout = require("fallout")

local start
local critter_p_proc

local Hostile = 0
local Only_Once = 1

function start()
    if Only_Once == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
        Only_Once = 0
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    end
end

function critter_p_proc()
    if fallout.map_var(18) ~= 0 then
        if fallout.map_var(18) > 2 then
            Hostile = 1
        end
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        Hostile = 1
    end
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
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
return exports
