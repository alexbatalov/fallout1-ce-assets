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
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 16 then
                map_exit_p_proc()
            end
        end
    end
end

function map_enter_p_proc()
    local v0 = 0
    fallout.set_global_var(598, 1)
    if fallout.metarule(22, 0) == 0 then
        if (fallout.map_var(0) == 0) and ((time.game_time_in_seconds() - fallout.global_var(270)) > (60 * 60)) then
            fallout.set_global_var(270, time.game_time_in_seconds())
            if fallout.map_var(1) == 0 then
                v0 = fallout.random(2, 3)
                fallout.set_map_var(1, v0)
                fallout.set_map_var(3, v0)
                PlaceCritter()
            else
                if fallout.map_var(1) == 1 then
                    v0 = fallout.random(1, 2)
                    fallout.set_map_var(1, v0 + 1)
                    fallout.set_map_var(3, v0)
                    PlaceCritter()
                else
                    if fallout.map_var(1) == 2 then
                        if fallout.random(0, 1) then
                            fallout.set_map_var(1, 3)
                            fallout.set_map_var(3, 1)
                            PlaceCritter()
                        end
                    end
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
    if (fallout.map_var(0) == 1) and (fallout.map_var(1) == 0) and (fallout.map_var(2) == 0) then
        fallout.set_global_var(265, 9250)
    end
end

function PlaceCritter()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    v3 = fallout.map_var(3)
    while v3 > 0 do
        v2 = fallout.random(1, 7)
        if v2 == 1 then
            v1 = 16890
        else
            if v2 == 2 then
                v1 = 17269
            else
                if v2 == 3 then
                    v1 = 23492
                else
                    if v2 == 4 then
                        v1 = 15885
                    else
                        if v2 == 5 then
                            v1 = 12287
                        else
                            if v2 == 6 then
                                v1 = 17511
                            else
                                if v2 == 7 then
                                    v1 = 15475
                                end
                            end
                        end
                    end
                end
            end
        end
        v0 = fallout.create_object_sid(16777267, 0, 0, 922)
        fallout.critter_attempt_placement(v0, v1, 0)
        v3 = v3 - 1
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
