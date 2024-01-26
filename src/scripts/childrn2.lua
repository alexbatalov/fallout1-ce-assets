local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start

fallout.create_external_var("Master_Ptr")

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local Player_Elevation = 0
local cur_count = 0
local prev_count = 0

function start()
    if fallout.script_action() == 15 then
        light.lighting()
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(101, 95, 0, 2)
        else
            if fallout.global_var(32) == 1 then
                fallout.override_map_start(101, 95, 1, 2)
            else
                if fallout.global_var(32) == 2 then
                    fallout.override_map_start(94, 96, 2, 2)
                else
                    fallout.override_map_start(101, 95, 0, 2)
                end
            end
        end
        party_elevation = party.add_party()
    end
    if fallout.script_action() == 23 then
        light.lighting()
        if fallout.global_var(55) ~= 0 then
            cur_count = 240 - (time.game_time_in_seconds() - fallout.global_var(55))
            if cur_count ~= prev_count then
                fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
                prev_count = cur_count
            end
            if (time.game_time_in_seconds() - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(445, 106))
                fallout.play_gmovie(4)
                misc.signal_end_game()
            end
        end
        party_elevation = party.update_party(party_elevation)
    end
    if fallout.script_action() == 16 then
        party.remove_party()
    end
end

local exports = {}
exports.start = start
return exports
