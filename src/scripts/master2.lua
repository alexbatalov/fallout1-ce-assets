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
fallout.create_external_var("Skill_Used")
fallout.create_external_var("Key_Used")
fallout.create_external_var("Master_Has_Armed")
fallout.create_external_var("Bomb_Armed")
fallout.create_external_var("Master_ptr")
fallout.create_external_var("signal_mutants")
fallout.create_external_var("Master_Has_Activated")

local Player_Elevation = 0
local mutan1_ptr = 0
local mutan2_ptr = 0
local mutan_ptr = 0
local stuff = 0
local cur_count = 0
local prev_count = 0

function start()
    if fallout.script_action() == 15 then
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if Player_Elevation == 0 then
            if time.is_day() and (fallout.metarule(22, 0) == 0) then
                if fallout.map_var(10) == 0 then
                    fallout.set_map_var(10, 1)
                    mutan_ptr = fallout.create_object_sid(16777408, 0, 0, 524)
                    fallout.critter_attempt_placement(mutan_ptr, 20532, 0)
                    fallout.critter_add_trait(mutan_ptr, 1, 6, 34)
                    stuff = fallout.create_object_sid(15, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(39, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(40, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    mutan_ptr = fallout.create_object_sid(16777408, 0, 0, 524)
                    fallout.critter_attempt_placement(mutan_ptr, 19337, 0)
                    fallout.critter_add_trait(mutan_ptr, 1, 6, 34)
                    stuff = fallout.create_object_sid(28, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(39, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(40, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    mutan_ptr = fallout.create_object_sid(16777408, 0, 0, 524)
                    fallout.critter_attempt_placement(mutan_ptr, 18740, 0)
                    fallout.critter_add_trait(mutan_ptr, 1, 6, 34)
                    stuff = fallout.create_object_sid(28, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(39, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(40, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    mutan_ptr = fallout.create_object_sid(16777408, 0, 0, 524)
                    fallout.critter_attempt_placement(mutan_ptr, 21339, 0)
                    fallout.critter_add_trait(mutan_ptr, 1, 6, 34)
                    stuff = fallout.create_object_sid(28, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(39, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                    stuff = fallout.create_object_sid(40, 0, 0, -1)
                    fallout.add_obj_to_inven(mutan_ptr, stuff)
                end
            end
        end
        if fallout.global_var(32) == 2 then
            fallout.override_map_start(112, 84, 0, 3)
        else
            if fallout.global_var(32) == 3 then
                fallout.override_map_start(140, 78, 1, 4)
            else
                if fallout.global_var(32) == 5 then
                    fallout.override_map_start(140, 78, 0, 4)
                else
                    if fallout.global_var(32) == 12 then
                        fallout.override_map_start(55, 68, 0, 5)
                        if fallout.metarule(22, 0) == 0 then
                            fallout.create_object_sid(16777363, 13854, 0, 53)
                            mutan_ptr = fallout.create_object_sid(16777409, 0, 0, 524)
                            fallout.critter_attempt_placement(mutan_ptr, 15468, 0)
                            fallout.critter_add_trait(mutan_ptr, 1, 6, 55)
                            stuff = fallout.create_object_sid(15, 0, 0, -1)
                            fallout.add_obj_to_inven(mutan_ptr, stuff)
                            stuff = fallout.create_object_sid(39, 0, 0, -1)
                            fallout.add_obj_to_inven(mutan_ptr, stuff)
                            stuff = fallout.create_object_sid(40, 0, 0, -1)
                            fallout.add_obj_to_inven(mutan_ptr, stuff)
                            mutan_ptr = fallout.create_object_sid(16777409, 0, 0, 524)
                            fallout.critter_attempt_placement(mutan_ptr, 15450, 0)
                            fallout.critter_add_trait(mutan_ptr, 1, 6, 55)
                            stuff = fallout.create_object_sid(15, 0, 0, -1)
                            fallout.add_obj_to_inven(mutan_ptr, stuff)
                            stuff = fallout.create_object_sid(39, 0, 0, -1)
                            fallout.add_obj_to_inven(mutan_ptr, stuff)
                            stuff = fallout.create_object_sid(40, 0, 0, -1)
                            fallout.add_obj_to_inven(mutan_ptr, stuff)
                        end
                    else
                        fallout.override_map_start(112, 84, 0, 3)
                    end
                end
            end
        end
        light.darkness()
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
                fallout.display_msg(fallout.message_str(447, 106))
                fallout.play_gmovie(4)
                fallout.metarule(13, 0)
            end
        end
        party_elevation = party.update_party(party_elevation)
    end
    if fallout.script_action() == 16 then
        fallout.kill_critter_type(16777408, 0)
        party.remove_party()
    end
end

local exports = {}
exports.start = start
return exports
