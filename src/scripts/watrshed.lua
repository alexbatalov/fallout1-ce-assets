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

local fugee_ptr = 0
local fugee_hex = 0

fallout.create_external_var("SuperLeave")
fallout.create_external_var("SuperLeft")
fallout.create_external_var("ghoul_door_open")
fallout.create_external_var("Harry_Pointer")
fallout.create_external_var("Manhole_Pointer_Top")
fallout.create_external_var("Manhole_Pointer_Middle")
fallout.create_external_var("Manhole_Pointer_Bottom")
fallout.create_external_var("Use_Manhole_Top")
fallout.create_external_var("Use_Manhole_Bottom")
fallout.create_external_var("Use_Manhole_Middle")

function start()
    if fallout.script_action() == 15 then
        if fallout.elevation(fallout.dude_obj()) == 0 then
            light.darkness()
        else
            light.lighting()
        end
        if fallout.global_var(227) then
            fallout.override_map_start(57, 62, 1, 0)
        else
            if fallout.global_var(32) == 1 then
                fallout.override_map_start(110, 70, 1, 5)
            else
                if fallout.global_var(32) == 12 then
                    fallout.override_map_start(53, 98, 0, 5)
                else
                    fallout.override_map_start(110, 70, 1, 5)
                end
            end
        end
        fallout.set_global_var(575, 1)
        if fallout.map_var(7) == 2 then
            fallout.kill_critter_type(16777225, 0)
            fallout.kill_critter_type(16777374, 0)
        end
        if time.game_time_in_days() >= fallout.global_var(149) then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(29) == 2 then
            if (time.game_time_in_days() - fallout.global_var(225)) > 1 then
                fallout.kill_critter_type(16777245, 0)
            end
            if (time.game_time_in_days() - fallout.global_var(225)) > 29 then
                fallout.set_global_var(13, 1)
            end
        end
        if (fallout.global_var(13) == 1) and (fallout.global_var(18) == 0) then
            fallout.kill_critter_type(16777321, 0)
            fallout.kill_critter_type(16777521, 1)
            fallout.kill_critter_type(16777322, 1)
            fallout.kill_critter_type(16777230, 1)
            fallout.kill_critter_type(16777232, 1)
            if fallout.map_var(10) == 0 then
                fallout.set_map_var(10, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 16501
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 15696
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 16696
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
            end
        end
        if fallout.global_var(607) == 3 then
            fallout.kill_critter_type(16777321, 0)
        end
        if fallout.global_var(30) == 1 then
            if (time.game_time_in_days() - fallout.global_var(552)) > 7 then
                if fallout.global_var(31) ~= 2 then
                    fallout.kill_critter_type(16777321, 0)
                    fallout.kill_critter_type(16777521, 2)
                    fallout.kill_critter_type(16777322, 2)
                    fallout.kill_critter_type(16777230, 2)
                    fallout.kill_critter_type(16777232, 2)
                    fallout.kill_critter_type(16777225, 0)
                    fallout.kill_critter_type(16777374, 0)
                end
            end
        end
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            if fallout.elevation(fallout.dude_obj()) == 0 then
                light.darkness()
            else
                light.lighting()
            end
            if fallout.external_var("Use_Manhole_Top") then
                fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Top"))
            end
            if fallout.external_var("Use_Manhole_Middle") then
                fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Middle"))
            end
            if fallout.external_var("Use_Manhole_Bottom") then
                fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Bottom"))
            end
            party_elevation = party.update_party(party_elevation)
        else
            if fallout.script_action() == 16 then
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
