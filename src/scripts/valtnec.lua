local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local addrats

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

function start()
    if fallout.script_action() == 15 then
        light.darkness()
        if fallout.global_var(30) == 1 then
            if (time.game_time_in_days() - fallout.global_var(552)) > 7 then
                if fallout.global_var(31) ~= 2 then
                    fallout.kill_critter_type(16777230, 2)
                    fallout.kill_critter_type(16777232, 2)
                end
            end
        end
        light.lighting()
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
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            light.darkness()
            party_elevation = party.update_party(party_elevation)
        end
    end
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

local exports = {}
exports.start = start
return exports
