local fallout = require("fallout")

local start
local Lighting
local Darkness
local add_party
local update_party
local remove_party

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

local Invasion

function start()
    if fallout.script_action() == 15 then
        Player_Elevation = fallout.elevation(fallout.dude_obj())
        if Player_Elevation == 0 then
            if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) and (fallout.metarule(22, 0) == 0) then
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
        Darkness()
        add_party()
    end
    if fallout.script_action() == 23 then
        Darkness()
        if fallout.global_var(55) ~= 0 then
            cur_count = 240 - ((fallout.game_time() // 10) - fallout.global_var(55))
            if cur_count ~= prev_count then
                fallout.display_msg(fallout.message_str(447, 100) .. cur_count .. fallout.message_str(447, 101))
                prev_count = cur_count
            end
            if ((fallout.game_time() // 10) - fallout.global_var(55)) > 240 then
                fallout.display_msg(fallout.message_str(447, 106))
                fallout.play_gmovie(4)
                fallout.metarule(13, 0)
            end
        end
        update_party()
    end
    if fallout.script_action() == 16 then
        fallout.kill_critter_type(16777408, 0)
        remove_party()
    end
end

function Lighting()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if (v0 >= 600) and (v0 < 700) then
        fallout.set_light_level(v0 - 600 + 40)
    else
        if (v0 >= 700) and (v0 < 1800) then
            fallout.set_light_level(100)
        else
            if (v0 >= 1800) and (v0 < 1900) then
                fallout.set_light_level(100 - (v0 - 1800))
            else
                fallout.set_light_level(40)
            end
        end
    end
end

function Darkness()
    fallout.set_light_level(40)
end

function add_party()
    local v0 = 0
    local v1 = 0
    party_elevation = fallout.elevation(fallout.dude_obj())
    if fallout.global_var(26) == 5 then
        if fallout.external_var("Tandi_ptr") == 0 then
        end
        fallout.critter_add_trait(fallout.external_var("Tandi_ptr"), 1, 6, 0)
    end
end

function update_party()
    local v0 = 0
    local v1 = 0
    if fallout.elevation(fallout.dude_obj()) ~= party_elevation then
        party_elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(118) == 2 then
            if fallout.external_var("Ian_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(5) then
            if fallout.external_var("Dog_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 1), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(121) == 2 then
            if fallout.external_var("Tycho_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(244) == 2 then
            if fallout.external_var("Katja_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Katja_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(26) == 5 then
            if fallout.external_var("Tandi_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tandi_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 4), fallout.elevation(fallout.dude_obj()))
            end
        end
    end
end

function remove_party()
    if fallout.global_var(118) == 2 then
        fallout.set_global_var(118, 2)
    end
    if fallout.global_var(5) then
        fallout.set_global_var(5, 1)
    end
    if fallout.global_var(121) == 2 then
        fallout.set_global_var(121, 2)
    end
    if fallout.global_var(244) == 2 then
        fallout.set_global_var(244, 2)
    end
    if fallout.global_var(26) == 5 then
    end
end

function Invasion()
    if not(fallout.global_var(18) == 2) then
        if fallout.global_var(149) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(150) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(151) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(16, 1)
        end
        if fallout.global_var(152) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(15, 1)
        end
        if fallout.global_var(153) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(12, 1)
        end
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(148) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(7, 1)
        end
    end
end

local exports = {}
exports.start = start
return exports
