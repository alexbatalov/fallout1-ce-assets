local fallout = require("fallout")
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

fallout.create_external_var("Lt_ptr")
fallout.create_external_var("Team9_Count")
fallout.create_external_var("ignoring_dude")
fallout.create_external_var("VWeapLocker_ptr")
fallout.create_external_var("valid_target")
fallout.create_external_var("field_change")
fallout.create_external_var("removal_ptr")
fallout.create_external_var("Field1c_Ptr")
fallout.create_external_var("Field1d_Ptr")
fallout.create_external_var("Field2c_Ptr")
fallout.create_external_var("FieldH_Ptr")

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
        if fallout.script_action() == 15 then
            if fallout.metarule(14, 0) then
                fallout.set_external_var("field_change", "off")
            end
            if fallout.global_var(146) ~= 0 then
                fallout.set_external_var("field_change", "on")
            end
            if fallout.global_var(609) ~= 0 then
                fallout.set_external_var("field_change", "off")
            end
            Player_Elevation = fallout.elevation(fallout.dude_obj())
            if fallout.global_var(32) == 0 then
                fallout.override_map_start(144, 64, 0, 3)
            else
                if fallout.global_var(32) == 1 then
                    fallout.override_map_start(120, 122, 0, 3)
                else
                    if fallout.global_var(32) == 2 then
                        fallout.override_map_start(92, 122, 0, 2)
                    else
                        if fallout.global_var(32) == 3 then
                            fallout.override_map_start(120, 122, 1, 3)
                        else
                            if fallout.global_var(32) == 4 then
                                fallout.override_map_start(92, 122, 1, 2)
                            else
                                if fallout.global_var(32) == 5 then
                                    fallout.override_map_start(71, 116, 1, 0)
                                else
                                    fallout.override_map_start(144, 64, 0, 3)
                                end
                            end
                        end
                    end
                end
            end
            party_elevation = party.add_party()
        else
            if fallout.script_action() == 23 then
                if fallout.global_var(146) == 0 then
                    if fallout.elevation(fallout.dude_obj()) == 0 then
                        fallout.set_global_var(590, 1)
                    else
                        fallout.set_global_var(591, 1)
                        if not(fallout.map_var(4)) and not(fallout.global_var(57)) then
                            fallout.display_msg(fallout.message_str(361, 140))
                            fallout.give_exp_points(2000)
                            fallout.set_map_var(4, 1)
                        end
                    end
                else
                    if fallout.map_var(19) == 0 then
                        fallout.display_msg(fallout.message_str(766, 186))
                        fallout.set_map_var(19, 1)
                    end
                    fallout.set_global_var(590, 0)
                    fallout.set_global_var(591, 0)
                end
                if fallout.global_var(147) ~= 0 then
                    fallout.display_msg(fallout.message_str(442, 107) .. (300 - (time.game_time_in_seconds() - fallout.global_var(147))) .. fallout.message_str(442, 108))
                    if (time.game_time_in_seconds() - fallout.global_var(147)) >= 300 then
                        fallout.play_gmovie(3)
                        fallout.metarule(13, 0)
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
    if fallout.global_var(276) == 1 then
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
