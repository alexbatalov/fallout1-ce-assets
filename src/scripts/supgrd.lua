local fallout = require("fallout")
local misc = require("lib.misc")

local start
local critter_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 65)
        initialized = true
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.map_var(18) ~= 0 then
        if fallout.map_var(18) > 2 then
            hostile = true
        end
    end
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
    end
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(self_obj, dude_obj) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
return exports
