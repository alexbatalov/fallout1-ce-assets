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
        First_Time = time.game_time_in_seconds()
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
    else
        if fallout.script_action() == 23 then
            Next_Time = time.game_time_in_seconds()
            if (Next_Time - First_Time) > 30 then
                Rads = (Next_Time - First_Time) // 30
                fallout.radiation_inc(fallout.dude_obj(), Rads)
                First_Time = time.game_time_in_seconds()
                Rads = 0
            else
                fallout.radiation_inc(fallout.dude_obj(), 1)
            end
            if fallout.global_var(224) == 2 then
                fallout.set_light_level(100)
            else
                if fallout.global_var(224) == 1 then
                    light.darkness()
                else
                    fallout.set_light_level(1)
                end
            end
            party_elevation = party.update_party(party_elevation)
            if (fallout.map_var(0) == 0) and (fallout.elevation(fallout.dude_obj()) == 1) then
                fallout.display_msg(fallout.message_str(766, 103) .. "1000" .. fallout.message_str(766, 104))
                fallout.give_exp_points(1000)
                fallout.set_map_var(0, 1)
            end
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
