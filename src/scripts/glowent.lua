local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc

local First_Time = 0

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
    party_elevation = party.add_party()
    if misc.map_first_run() then
        fallout.set_global_var(224, 1)
        fallout.display_msg(fallout.message_str(194, 108))
    end
    fallout.set_global_var(592, 1)
    First_Time = time.game_time_in_seconds()
    light.lighting()
    if fallout.global_var(32) == 0 then
        fallout.override_map_start(107, 130, 0, 5)
    elseif fallout.global_var(32) == 2 then
        fallout.override_map_start(117, 103, 0, 1)
    else
        fallout.override_map_start(107, 130, 0, 5)
    end
end

function map_exit_p_proc()
    party.remove_party()
end

function map_update_p_proc()
    party_elevation = party.update_party(party_elevation)
    local Next_Time = time.game_time_in_seconds()
    if Next_Time - First_Time > 30 then
        local rads = (Next_Time - First_Time) // 30 * 15
        fallout.radiation_inc(fallout.dude_obj(), rads)
        First_Time = time.game_time_in_seconds()
    else
        fallout.radiation_inc(fallout.dude_obj(), 15)
    end
    light.lighting()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
