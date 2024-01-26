local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

fallout.create_external_var("Set_Pointer")
fallout.create_external_var("Garret_ptr")
fallout.create_external_var("Fridge_ptr")
fallout.create_external_var("Shotgun_ptr")
fallout.create_external_var("Shells1_ptr")
fallout.create_external_var("Shells2_ptr")
fallout.create_external_var("Flare1_ptr")
fallout.create_external_var("Flare2_ptr")
fallout.create_external_var("Flare3_ptr")
fallout.create_external_var("Flare4_ptr")
fallout.create_external_var("Cola1_ptr")
fallout.create_external_var("Cola2_ptr")
fallout.create_external_var("Cola3_ptr")
fallout.create_external_var("Cola4_ptr")
fallout.create_external_var("Manhole_Pointer_Top")
fallout.create_external_var("Manhole_Pointer_Middle")
fallout.create_external_var("Manhole_Pointer_Bottom")
fallout.create_external_var("Use_Manhole_Top")
fallout.create_external_var("Use_Manhole_Bottom")
fallout.create_external_var("Use_Manhole_Middle")
fallout.create_external_var("set_gone")
fallout.create_external_var("set_dead")

local fugee_ptr = 0
local fugee_hex = 0

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
        if fallout.global_var(32) == 2 then
            fallout.override_map_start(153, 100, 1, 0)
        else
            if fallout.global_var(32) == 12 then
                fallout.override_map_start(103, 58, 0, 2)
            else
                if fallout.global_var(32) == 13 then
                    fallout.override_map_start(141, 134, 0, 5)
                else
                    fallout.override_map_start(153, 100, 1, 0)
                end
            end
        end
        fallout.set_global_var(574, 1)
        if time.game_time_in_days() >= fallout.global_var(149) then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(29) == 2 then
            if (time.game_time_in_days() - fallout.global_var(225)) > 29 then
                fallout.set_global_var(13, 1)
            end
        end
        if (fallout.global_var(13) == 1) and (fallout.global_var(18) == 0) and (not misc.is_loading_game()) then
            fallout.kill_critter_type(16777320, 1)
            fallout.kill_critter_type(16777321, 1)
            fallout.kill_critter_type(16777521, 1)
            fallout.kill_critter_type(16777322, 1)
            fallout.kill_critter_type(16777230, 1)
            fallout.kill_critter_type(16777232, 1)
            if fallout.map_var(10) == 0 then
                fallout.set_map_var(10, 1)
                fugee_ptr = fallout.create_object_sid(16777401, 0, 0, 74)
                fugee_hex = 28689
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fallout.critter_add_trait(fugee_ptr, 1, 6, 0)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 16886
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 16084
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 20111
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
            end
        else
            if fallout.global_var(263) == 1 then
                fallout.kill_critter_type(16777320, 1)
                fallout.kill_critter_type(16777321, 1)
            end
        end
        if (fallout.global_var(30) == 1) and (not misc.is_loading_game()) then
            if (time.game_time_in_days() - fallout.global_var(552)) > 7 then
                if fallout.global_var(31) ~= 2 then
                    fallout.kill_critter_type(16777320, 2)
                    fallout.kill_critter_type(16777321, 2)
                    fallout.kill_critter_type(16777521, 2)
                    fallout.kill_critter_type(16777322, 2)
                    fallout.kill_critter_type(16777230, 2)
                    fallout.kill_critter_type(16777232, 2)
                end
            end
        end
        if fallout.global_var(607) == 3 then
            fallout.kill_critter_type(16777321, 0)
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
                party.remove_party()
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
