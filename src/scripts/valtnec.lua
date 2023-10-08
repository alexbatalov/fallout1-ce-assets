local fallout = require("fallout")
local time = require("lib.time")

local start
local Lighting
local Darkness
local addrats
local add_party
local update_party
local remove_party

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local rotation = 0
local nest_tile = 0
local Critter_tile = 0
local Monster = 0
local Cur_Rotate = 0
local Tot_Critter_A = 0
local Range = 0
local Player_Elevation = 0

local Invasion

function start()
    if fallout.script_action() == 15 then
        Darkness()
        if fallout.global_var(30) == 1 then
            if (time.game_time_in_days() - fallout.global_var(552)) > 7 then
                if fallout.global_var(31) ~= 2 then
                    fallout.kill_critter_type(16777230, 2)
                    fallout.kill_critter_type(16777232, 2)
                end
            end
        end
        Lighting()
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(32) == 12 then
            fallout.override_map_start(104, 135, 0, 5)
        else
            if fallout.global_var(32) == 1 then
                fallout.override_map_start(104, 67, 0, 5)
            else
                if fallout.global_var(32) == 2 then
                    fallout.override_map_start(102, 115, 1, 5)
                else
                    if fallout.global_var(32) == 3 then
                        fallout.override_map_start(109, 86, 2, 5)
                    else
                        fallout.override_map_start(104, 135, 0, 5)
                    end
                end
            end
        end
        add_party()
    else
        if fallout.script_action() == 23 then
            Darkness()
            update_party()
        end
    end
end

function Lighting()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if (v0 >= 600) and (v0 < 700) then
        fallout.set_light_level(v0 - 600 + 40)
    else
        if (v0 >= 700) and (v0 < 1800) then
            fallout.set_light_level(100)
        else
            if (v0 >= 1800) and (v0 < 1900) then
                fallout.set_light_level(100 - (v0 - 1800))
            else
                fallout.set_light_level(40)
            end
        end
    end
end

function Darkness()
    fallout.set_light_level(40)
end

function addrats()
    local v0 = 0
    Tot_Critter_A = 1
    while v0 < Tot_Critter_A do
        Range = fallout.random(1, 3)
        Cur_Rotate = fallout.random(0, 5)
        nest_tile = 14888
        Critter_tile = fallout.tile_num_in_direction(nest_tile, Cur_Rotate, Range)
        Monster = fallout.create_object_sid(16777264, 0, 0, 419)
        fallout.critter_attempt_placement(Monster, Critter_tile, 0)
        v0 = v0 + 1
    end
end

function add_party()
    local v0 = 0
    local v1 = 0
    party_elevation = fallout.elevation(fallout.dude_obj())
    if fallout.global_var(26) == 5 then
        if fallout.external_var("Tandi_ptr") == 0 then
        end
        fallout.critter_add_trait(fallout.external_var("Tandi_ptr"), 1, 6, 0)
    end
end

function update_party()
    local v0 = 0
    local v1 = 0
    if fallout.elevation(fallout.dude_obj()) ~= party_elevation then
        party_elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(118) == 2 then
            if fallout.external_var("Ian_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(5) then
            if fallout.external_var("Dog_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 1), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(121) == 2 then
            if fallout.external_var("Tycho_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(244) == 2 then
            if fallout.external_var("Katja_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Katja_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(26) == 5 then
            if fallout.external_var("Tandi_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tandi_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 4), fallout.elevation(fallout.dude_obj()))
            end
        end
    end
end

function remove_party()
    if fallout.global_var(118) == 2 then
        fallout.set_global_var(118, 2)
    end
    if fallout.global_var(5) then
        fallout.set_global_var(5, 1)
    end
    if fallout.global_var(121) == 2 then
        fallout.set_global_var(121, 2)
    end
    if fallout.global_var(244) == 2 then
        fallout.set_global_var(244, 2)
    end
    if fallout.global_var(26) == 5 then
    end
end

function Invasion()
    if not(fallout.global_var(18) == 2) then
        if fallout.global_var(149) > time.game_time_in_days() then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(150) > time.game_time_in_days() then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(151) > time.game_time_in_days() then
            fallout.set_global_var(16, 1)
        end
        if fallout.global_var(152) > time.game_time_in_days() then
            fallout.set_global_var(15, 1)
        end
        if fallout.global_var(153) > time.game_time_in_days() then
            fallout.set_global_var(12, 1)
        end
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(148) > time.game_time_in_days() then
            fallout.set_global_var(7, 1)
        end
    end
end

local exports = {}
exports.start = start
return exports
