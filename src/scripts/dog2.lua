local fallout = require("fallout")
local misc = require("lib.misc")

local start

local rndx = 0
local rndy = 0
local critter_tile = 0
local Herebefore = 0
local Talked_Once = 0
local initialized = false

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 8)
        if (fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25) then
            misc.set_team(fallout.self_obj(), 2)
        else
            misc.set_team(fallout.self_obj(), 21)
        end
    end
    if fallout.script_action() == 12 then
        if (fallout.global_var(5) == 1) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 5) and (Herebefore == 1) then
            rndx = fallout.random(0, 5)
            critter_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), rndx, 1)
            fallout.animate_move_obj_to_tile(fallout.self_obj(), critter_tile, 0)
        else
            rndy = fallout.random(1, 20)
            if rndy == 1 then
                rndx = fallout.random(0, 5)
                critter_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), rndx, 1)
                fallout.animate_move_obj_to_tile(fallout.self_obj(), critter_tile, 0)
            end
        end
        if fallout.global_var(4) == 0 then
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.global_var(5) == 0) then
                if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 74 then
                    fallout.set_global_var(5, 1)
                    Herebefore = 1
                    fallout.display_msg(fallout.message_str(242, 102))
                end
            end
        end
    else
        if fallout.script_action() == 18 then
            fallout.set_global_var(4, fallout.global_var(4) + 1)
        else
            if fallout.script_action() == 13 then
                fallout.set_global_var(5, 1)
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
