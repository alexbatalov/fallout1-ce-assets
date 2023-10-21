local fallout = require("fallout")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc

fallout.create_external_var("Student_ptr")
fallout.create_external_var("locker_ptr")
fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Student_ptr", nil)
fallout.set_external_var("locker_ptr", nil)
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
    if fallout.global_var(32) == 2 then
        fallout.override_map_start(113, 75, 0, 5)
    else
        if fallout.global_var(32) == 3 then
            fallout.override_map_start(138, 96, 1, 5)
        else
            fallout.override_map_start(113, 75, 0, 5)
        end
    end
    party_elevation = party.add_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 0 then
        fallout.set_global_var(583, 1)
    else
        fallout.set_global_var(584, 1)
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
