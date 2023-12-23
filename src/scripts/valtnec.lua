local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc

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
    end
    -- FIXME: Probably missing `map_exit_p_proc` which usually calls `remove_party`.
end

function map_enter_p_proc()
    light.darkness()
    if fallout.global_var(30) == 1 then
        if time.game_time_in_days() - fallout.global_var(552) > 7 then
            if fallout.global_var(31) ~= 2 then
                fallout.kill_critter_type(16777230, 2)
                fallout.kill_critter_type(16777232, 2)
            end
        end
    end
    -- FIXME: Overrides previous darkness and conflicts with darkness in `map_update_p_proc`
    light.lighting()
    if fallout.global_var(32) == 12 then
        fallout.override_map_start(104, 135, 0, 5)
    elseif fallout.global_var(32) == 1 then
        fallout.override_map_start(104, 67, 0, 5)
    elseif fallout.global_var(32) == 2 then
        fallout.override_map_start(102, 115, 1, 5)
    elseif fallout.global_var(32) == 3 then
        fallout.override_map_start(109, 86, 2, 5)
    else
        fallout.override_map_start(104, 135, 0, 5)
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    light.darkness()
    party_elevation = party.update_party(party_elevation)
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
