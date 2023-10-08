local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")
fallout.create_external_var("patient")
fallout.create_external_var("lets_go")
fallout.create_external_var("contpan")
fallout.create_external_var("J_Door_Ptr")
fallout.create_external_var("Psy_Field_Ptr")

local Player_Elevation = 0
local monstr_ptr = 0
local stuff = 0
local cur_count = 0
local prev_count = 0

function start()
    if fallout.script_action() == 15 then
        light.darkness()
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if Player_Elevation == 0 then
            if time.is_day() and (fallout.metarule(22, 0) == 0) then
                if fallout.map_var(10) == 0 then
                    fallout.set_map_var(10, 1)
                    monstr_ptr = fallout.create_object_sid(16777259, 0, 0, 686)
                    fallout.critter_attempt_placement(monstr_ptr, 24678, 0)
                    fallout.critter_add_trait(monstr_ptr, 1, 6, 34)
                    monstr_ptr = fallout.create_object_sid(16777261, 0, 0, 686)
                    fallout.critter_attempt_placement(monstr_ptr, 25680, 0)
                    fallout.critter_add_trait(monstr_ptr, 1, 6, 34)
                    monstr_ptr = fallout.create_object_sid(16777261, 0, 0, 686)
                    fallout.critter_attempt_placement(monstr_ptr, 25276, 0)
                    fallout.critter_add_trait(monstr_ptr, 1, 6, 34)
                end
            end
        end
        if fallout.global_var(32) == 0 then
            fallout.override_map_start(136, 107, 0, 3)
        else
            if fallout.global_var(32) == 4 then
                fallout.override_map_start(98, 60, 0, 3)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(94, 98, 1, 3)
                else
                    fallout.override_map_start(136, 107, 0, 3)
                end
            end
        end
        party_elevation = party.add_party()
    end
    if fallout.script_action() == 23 then
        light.darkness()
        if fallout.global_var(55) ~= 0 then
            cur_count = 240 - (time.game_time_in_seconds() - fallout.global_var(55))
            if cur_count ~= prev_count then
                fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
                prev_count = cur_count
            end
            if (time.game_time_in_seconds() - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(446, 106))
                fallout.play_gmovie(4)
                fallout.metarule(13, 0)
            end
        end
        party_elevation = party.update_party(party_elevation)
    end
    if fallout.script_action() == 16 then
        fallout.kill_critter_type(16777259, 0)
        fallout.kill_critter_type(16777261, 0)
        party.remove_party()
    end
end

local exports = {}
exports.start = start
return exports
