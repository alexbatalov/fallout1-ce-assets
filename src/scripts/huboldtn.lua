local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

fallout.create_external_var("Jake_Door_Ptr")
fallout.create_external_var("Jake_Desk_Ptr")
fallout.create_external_var("Vance_Box_Ptr")
fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Jake_Door_Ptr", nil)
fallout.set_external_var("Jake_Desk_Ptr", nil)
fallout.set_external_var("Vance_Box_Ptr", nil)
fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)

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
    fallout.set_global_var(579, 1)
    if time.game_time_in_days() >= fallout.global_var(150) then
        fallout.set_global_var(14, 1)
    end
    light.lighting()
    party_elevation = party.add_party()
    fallout.override_map_start(125, 85, 0, 1)
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
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
