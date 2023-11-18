local fallout = require("fallout")

--- @param flags integer
local function flee_dude(flags)
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    local tile = 0
    local rotation = 0
    local distance = 0
    while rotation < 5 do
        if fallout.tile_distance(dude_tile_num, fallout.tile_num_in_direction(self_tile_num, rotation, 3)) > distance then
            tile = fallout.tile_num_in_direction(self_tile_num, rotation, 3)
            distance = fallout.tile_distance(dude_tile_num, tile)
        end
        rotation = rotation + 1
    end
    fallout.animate_move_obj_to_tile(self_obj, tile, flags)
end

local exports = {}
exports.flee_dude = flee_dude
return exports
