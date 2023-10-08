local fallout = require("fallout")
local party = require("lib.party")
local time = require("lib.time")

local HEREBEFORE = 0
local PLayer_Elevation = 0

fallout.create_external_var("Student_ptr")
fallout.create_external_var("student_num")
fallout.create_external_var("locker_ptr")

local start

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        PLayer_Elevation = fallout.elevation(fallout.dude_obj())
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
    else
        if fallout.script_action() == 23 then
            if fallout.elevation(fallout.dude_obj()) == 0 then
                fallout.set_global_var(583, 1)
            else
                fallout.set_global_var(584, 1)
            end
            party_elevation = party.update_party(party_elevation)
        else
            if fallout.script_action() == 16 then
                party.remove_party()
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
