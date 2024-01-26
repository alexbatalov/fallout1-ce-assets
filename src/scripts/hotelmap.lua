local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

fallout.create_external_var("Use_Manhole_Top")
fallout.create_external_var("Use_Manhole_Bottom")
fallout.create_external_var("Use_Manhole_Middle")
fallout.create_external_var("Manhole_Pointer_Top")
fallout.create_external_var("Manhole_Pointer_Middle")
fallout.create_external_var("Manhole_Pointer_Bottom")

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
        light.lighting()
        if fallout.global_var(32) == 3 then
            fallout.override_map_start(94, 136, 1, 5)
        else
            if fallout.global_var(32) == 12 then
                fallout.override_map_start(143, 64, 0, 2)
            else
                fallout.override_map_start(94, 136, 1, 5)
            end
        end
        if misc.map_first_run() then
            fallout.display_msg(fallout.message_str(194, 106))
        end
        fallout.set_global_var(573, 1)
        if time.game_time_in_days() >= fallout.global_var(149) then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(29) == 2 then
            if (time.game_time_in_days() - fallout.global_var(225)) > 29 then
                fallout.set_global_var(13, 1)
            end
        end
        if (fallout.global_var(13) == 1) and (fallout.global_var(18) == 0) and (not misc.is_loading_game()) then
            fallout.kill_critter_type(16777230, 1)
            fallout.kill_critter_type(16777521, 1)
            fallout.kill_critter_type(16777322, 1)
            fallout.kill_critter_type(16777232, 1)
            if fallout.map_var(10) == 0 then
                fallout.set_map_var(10, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 25717
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 24516
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
                fugee_ptr = fallout.create_object_sid(16777404, 0, 0, 912)
                fallout.critter_add_trait(fugee_ptr, 1, 5, 48)
                fugee_hex = 24927
                fallout.critter_attempt_placement(fugee_ptr, fugee_hex, 1)
            end
        end
        if (fallout.global_var(30) == 1) and (not misc.is_loading_game()) then
            if (time.game_time_in_days() - fallout.global_var(552)) > 7 then
                if fallout.global_var(31) ~= 2 then
                    fallout.kill_critter_type(16777230, 2)
                    fallout.kill_critter_type(16777521, 2)
                    fallout.kill_critter_type(16777322, 2)
                    fallout.kill_critter_type(16777232, 2)
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
                party.remove_party()
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
