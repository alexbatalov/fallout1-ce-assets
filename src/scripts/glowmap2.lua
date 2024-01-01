local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

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

local first_time = 0
local party_elevation = 0

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
    first_time = time.game_time_in_seconds()
    if fallout.global_var(224) == 2 then
        fallout.set_light_level(100)
    else
        if fallout.global_var(224) == 1 then
            light.darkness()
        else
            fallout.set_light_level(1)
        end
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    local next_time = time.game_time_in_seconds()
    if next_time - first_time > 30 then
        local rads = (next_time - first_time) // 30
        fallout.radiation_inc(fallout.dude_obj(), rads)
        first_time = time.game_time_in_seconds()
    else
        fallout.radiation_inc(fallout.dude_obj(), 1)
    end
    if fallout.global_var(224) == 2 then
        fallout.set_light_level(100)
    elseif fallout.global_var(224) == 1 then
        light.darkness()
    else
        fallout.set_light_level(1)
    end
    party_elevation = party.update_party(party_elevation)
    if fallout.map_var(0) == 0 and fallout.elevation(fallout.dude_obj()) == 1 then
        fallout.display_msg(fallout.message_str(766, 103) .. "1000" .. fallout.message_str(766, 104))
        fallout.give_exp_points(1000)
        fallout.set_map_var(0, 1)
    end
end

function map_exit_p_proc()
    party.remove_party()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
