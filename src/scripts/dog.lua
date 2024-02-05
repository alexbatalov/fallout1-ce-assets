local fallout = require("fallout")
local misc = require("lib.misc")

local start

local rndx = 0
local rndy = 0
local critter_tile = 0

function start()
    misc.set_ai(fallout.self_obj(), 8)
    if (fallout.cur_map_index() == 26) or (fallout.cur_map_index() == 25) then
        misc.set_team(fallout.self_obj(), 2)
    end
    if fallout.script_action() == 12 then
        rndy = fallout.random(1, 20)
        if rndy == 1 then
            rndx = fallout.random(0, 5)
            critter_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), rndx, 1)
            fallout.animate_move_obj_to_tile(fallout.self_obj(), critter_tile, 0)
        end
        detach()
    end
end

local exports = {}
exports.start = start
return exports
