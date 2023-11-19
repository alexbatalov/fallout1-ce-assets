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

--- @param lvar integer
--- @param night_person boolean
--- @param wake_time integer
--- @param sleep_time integer
--- @param wake_tile integer
--- @param sleep_tile integer
local function sleeping(lvar, night_person, wake_time, sleep_time, wake_tile, sleep_tile)
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    local self_elevation = fallout.elevation(self_obj)
    local game_time_hour = fallout.game_time_hour()
    if fallout.local_var(lvar) == 1 then
        if not night_person and game_time_hour >= wake_time and game_time_hour < sleep_time
            or night_person and (game_time_hour >= wake_time or game_time_hour < sleep_time) then
            if game_time_hour - wake_time < 10 and game_time_hour - wake_time > 0 then
                if self_tile_num ~= wake_tile then
                    fallout.animate_move_obj_to_tile(self_obj, wake_tile, 0)
                else
                    fallout.set_local_var(lvar, 0)
                end
            else
                fallout.move_to(self_obj, wake_tile, self_elevation)
                if self_tile_num == wake_tile then
                    fallout.set_local_var(lvar, 0)
                end
            end
        end
    else
        if night_person and game_time_hour >= sleep_time and game_time_hour < wake_time
            or not night_person and (game_time_hour >= sleep_time or game_time_hour < wake_time) then
            if game_time_hour - sleep_time < 10 and game_time_hour - sleep_time > 0 then
                if self_tile_num ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(self_obj, sleep_tile, 0)
                else
                    fallout.set_local_var(lvar, 1)
                end
            else
                if self_tile_num ~= sleep_tile then
                    fallout.move_to(self_obj, sleep_tile, self_elevation)
                else
                    fallout.set_local_var(lvar, 1)
                end
            end
        end
    end
end


local exports = {}
exports.flee_dude = flee_dude
exports.sleeping = sleeping
return exports
