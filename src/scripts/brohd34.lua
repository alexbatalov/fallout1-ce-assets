local fallout = require("fallout")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

fallout.create_external_var("term1_ptr")
fallout.create_external_var("term2_ptr")
fallout.create_external_var("term3_ptr")
fallout.create_external_var("term4_ptr")
fallout.create_external_var("term5_ptr")
fallout.create_external_var("term6_ptr")
fallout.create_external_var("term7_ptr")
fallout.create_external_var("term8_ptr")
fallout.create_external_var("Vree_ptr")
fallout.create_external_var("table_ptr")
fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("term1_ptr", nil)
fallout.set_external_var("term2_ptr", nil)
fallout.set_external_var("term3_ptr", nil)
fallout.set_external_var("term4_ptr", nil)
fallout.set_external_var("term5_ptr", nil)
fallout.set_external_var("term6_ptr", nil)
fallout.set_external_var("term7_ptr", nil)
fallout.set_external_var("term8_ptr", nil)
fallout.set_external_var("Vree_ptr", nil)
fallout.set_external_var("table_ptr", nil)
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
    if time.game_time_in_days() >= fallout.global_var(151) then
        fallout.set_global_var(16, 1)
    end
    if fallout.global_var(32) == 4 then
        fallout.override_map_start(138, 108, 0, 5)
    elseif fallout.global_var(32) == 5 then
        fallout.override_map_start(140, 107, 1, 5)
    else
        fallout.override_map_start(138, 108, 0, 5)
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 0 then
        fallout.set_global_var(585, 1)
    else
        fallout.set_global_var(586, 1)
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
