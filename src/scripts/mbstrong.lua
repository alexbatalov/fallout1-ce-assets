local fallout = require("fallout")
local misc = require("lib.misc")
local party = require("lib.party")
local time = require("lib.time")

local start
local combat_p_proc

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

local Player_Elevation = 0

fallout.create_external_var("field_change")
fallout.create_external_var("ignoring_dude")
fallout.create_external_var("radio_computer")
fallout.create_external_var("radio_room_attacked")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("valid_target")
fallout.create_external_var("FieldC1a_ptr")
fallout.create_external_var("FieldC1b_ptr")
fallout.create_external_var("FieldC2a_ptr")
fallout.create_external_var("FieldC2b_ptr")
fallout.create_external_var("Field1a_Ptr")
fallout.create_external_var("Field2a_Ptr")
fallout.create_external_var("Field3a_Ptr")
fallout.create_external_var("Field4a_Ptr")
fallout.create_external_var("Field5a_Ptr")
fallout.create_external_var("Field6a_Ptr")
fallout.create_external_var("Field1b_Ptr")
fallout.create_external_var("Field2b_Ptr")

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 15 then
            if misc.map_first_run() then
                fallout.set_external_var("field_change", "off")
            end
            if fallout.global_var(146) ~= 0 then
                fallout.set_external_var("field_change", "on")
            end
            if fallout.global_var(609) ~= 0 then
                fallout.set_external_var("field_change", "off")
            end
            if fallout.global_var(32) == 0 then
                fallout.override_map_start(120, 75, 0, 2)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(120, 75, 1, 2)
                else
                    if fallout.global_var(32) == 12 then
                        fallout.override_map_start(92, 135, 0, 5)
                    else
                        fallout.override_map_start(93, 143, 0, 5)
                    end
                end
            end
            fallout.set_external_var("radio_room_attacked", fallout.map_var(13))
            party_elevation = party.add_party()
        else
            if fallout.script_action() == 23 then
                if fallout.global_var(146) == 0 then
                    if fallout.elevation(fallout.dude_obj()) == 0 then
                        fallout.set_global_var(588, 1)
                    else
                        fallout.set_global_var(589, 1)
                    end
                else
                    if fallout.map_var(24) == 0 then
                        fallout.display_msg(fallout.message_str(766, 186))
                        fallout.set_map_var(24, 1)
                    end
                    fallout.set_global_var(588, 0)
                    fallout.set_global_var(589, 0)
                end
                if fallout.global_var(147) ~= 0 then
                    fallout.display_msg(fallout.message_str(441, 108) .. (300 - (time.game_time_in_seconds() - fallout.global_var(147))) .. fallout.message_str(441, 109))
                    if (time.game_time_in_seconds() - fallout.global_var(147)) >= 300 then
                        fallout.play_gmovie(3)
                        misc.signal_end_game()
                    end
                end
                if fallout.external_var("removal_ptr") ~= 0 then
                    fallout.destroy_object(fallout.external_var("removal_ptr"))
                    fallout.set_external_var("removal_ptr", 0)
                end
                party_elevation = party.update_party(party_elevation)
            else
                if fallout.script_action() == 16 then
                    party.remove_party()
                end
            end
        end
    end
end

function combat_p_proc()
    if fallout.global_var(276) ~= 0 then
        fallout.script_overrides()
        fallout.set_global_var(276, 0)
        fallout.set_global_var(57, 3)
        fallout.load_map(32, 5)
    end
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
return exports
