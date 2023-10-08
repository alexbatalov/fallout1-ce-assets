local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

local First_Time = 0
local Next_Time = 0
local Rads = 0

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        party_elevation = party.add_party()
        if fallout.metarule(14, 0) then
            fallout.set_global_var(224, 1)
            fallout.display_msg(fallout.message_str(194, 108))
        end
        fallout.set_global_var(592, 1)
        First_Time = time.game_time_in_seconds()
        light.lighting()
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(107, 130, 0, 5)
        else
            if fallout.global_var(32) == 2 then
                fallout.override_map_start(117, 103, 0, 1)
            else
                fallout.override_map_start(107, 130, 0, 5)
            end
        end
    else
        if fallout.script_action() == 23 then
            party_elevation = party.update_party(party_elevation)
            Next_Time = time.game_time_in_seconds()
            if (Next_Time - First_Time) > 30 then
                Rads = (Next_Time - First_Time) // 30 * 15
                fallout.radiation_inc(fallout.dude_obj(), Rads)
                First_Time = time.game_time_in_seconds()
                Rads = 0
            else
                fallout.radiation_inc(fallout.dude_obj(), 15)
            end
            light.lighting()
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
