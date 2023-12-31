local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc
local PlaceCritter

local party_elevation = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    fallout.set_global_var(598, 1)
    if fallout.metarule(22, 0) == 0 then
        if fallout.map_var(0) == 0 and time.game_time_in_seconds() - fallout.global_var(270) > 60 * 60 then
            fallout.set_global_var(270, time.game_time_in_seconds())
            if fallout.map_var(1) == 0 then
                local v0 = fallout.random(2, 3)
                fallout.set_map_var(1, v0)
                fallout.set_map_var(3, v0)
                PlaceCritter()
            elseif fallout.map_var(1) == 1 then
                local v0 = fallout.random(1, 2)
                fallout.set_map_var(1, v0 + 1)
                fallout.set_map_var(3, v0)
                PlaceCritter()
            elseif fallout.map_var(1) == 2 then
                if fallout.random(0, 1) ~= 0 then
                    fallout.set_map_var(1, 3)
                    fallout.set_map_var(3, 1)
                    PlaceCritter()
                end
            end
        end
    end
    light.lighting()
    fallout.override_map_start(96, 121, 0, 0)
    party_elevation = party.add_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 1 then
        light.darkness()
    else
        light.lighting()
    end
    party_elevation = party.update_party(party_elevation)
end

function map_exit_p_proc()
    party.remove_party()
    if fallout.map_var(0) == 1 and fallout.map_var(1) == 0 and fallout.map_var(2) == 0 then
        fallout.set_global_var(265, 9250)
    end
end

local HEXES <const> = {
    16890,
    17269,
    23492,
    15885,
    12287,
    17511,
    15475,
}

function PlaceCritter()
    local count = fallout.map_var(3)
    while count > 0 do
        local num = fallout.random(1, #HEXES)
        local critter_obj = fallout.create_object_sid(16777267, 0, 0, 922)
        fallout.critter_attempt_placement(critter_obj, HEXES[num], 0)
        count = count - 1
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
