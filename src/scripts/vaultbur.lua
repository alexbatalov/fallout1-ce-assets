local fallout = require("fallout")
local party = require("lib.party")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

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
    fallout.set_light_level(40)
    if fallout.global_var(32) == 1 then
        fallout.override_map_start(94, 95, 0, 5)
    elseif fallout.global_var(32) == 2 then
        fallout.override_map_start(109, 113, 1, 5)
    elseif fallout.global_var(32) == 3 then
        fallout.override_map_start(108, 93, 2, 5)
    else
        fallout.override_map_start(119, 103, 0, 5)
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    local dude_elevation = fallout.elevation(fallout.dude_obj())
    if dude_elevation == 0 then
        fallout.set_global_var(563, 1)
    elseif dude_elevation == 1 then
        fallout.set_global_var(564, 1)
    else
        fallout.set_global_var(565, 1)
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
