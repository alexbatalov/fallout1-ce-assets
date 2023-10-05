local fallout = require("fallout")

local start
local critter_p_proc
local damage_p_proc

local initialized = 0
local damage_counter = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 3)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 4)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
            end
        end
    end
end

function critter_p_proc()
    fallout.script_overrides()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 4, 6), 1)
    if (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) <= 1) and (fallout.random(1, 3) == 1) then
        fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 6) + 3, 0)
        fallout.critter_injure(fallout.dude_obj(), 2)
    end
end

function damage_p_proc()
    if damage_counter > 2 then
        fallout.attack_complex(fallout.self_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        damage_counter = damage_counter + 1
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
return exports
