local fallout = require("fallout")

local start
local stranger
local Lighting
local Place_critter
local hunters
local City1
local City2
local City3
local City4
local City5
local City6
local add_party
local update_party
local remove_party

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("local Ian_ptr")
fallout.create_external_var("local Dog_ptr")
fallout.create_external_var("local Tycho_ptr")
fallout.create_external_var("local Katja_ptr")
fallout.create_external_var("local Tandi_ptr")

local Tot_Critter_A = 0
local Tot_Critter_B = 0
local Encounter_Num = 0
local dude_pos = 0
local dude_rot = 0
local Item = 0
local Dude_tile = 0
local group_angle = 0
local Ranger_rerolls = 0
local Critter = 0
local Inner_ring = 0
local Outer_ring = 0
local Critter_direction = 0
local Critter_type = 0
local Critter_script = -1
local start_attack = 0
local victim = 0
local Critter_tile = 0

local Darkness
local Invasion

function start()
    if fallout.script_action() == 15 then
        if fallout.metarule(14, 0) then
            dude_pos = fallout.random(0, 2)
            dude_rot = fallout.random(0, 5)
            if dude_pos == 0 then
                fallout.override_map_start(100, 100, 0, dude_rot)
            else
                if dude_pos == 1 then
                    fallout.override_map_start(116, 83, 0, dude_rot)
                else
                    fallout.override_map_start(92, 110, 0, dude_rot)
                end
            end
        end
        if (fallout.global_var(32) ~= 1) and fallout.metarule(14, 0) then
            Dude_tile = fallout.tile_num(fallout.dude_obj())
            Ranger_rerolls = fallout.has_trait(0, fallout.dude_obj(), 47)
            fallout.set_global_var(334, 0)
            while Encounter_Num == 0 do
                Encounter_Num = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
                if fallout.get_critter_stat(fallout.dude_obj(), 6) > 8 then
                    Encounter_Num = Encounter_Num + 2
                else
                    if fallout.get_critter_stat(fallout.dude_obj(), 6) > 7 then
                        Encounter_Num = Encounter_Num + 1
                    else
                        if fallout.get_critter_stat(fallout.dude_obj(), 6) < 3 then
                            Encounter_Num = Encounter_Num - 1
                        end
                    end
                end
                if (fallout.global_var(123) ~= 3) and (fallout.global_var(158) > 2) and fallout.random(0, 1) then
                    Encounter_Num = 7
                else
                    if Encounter_Num <= 3 then
                        Encounter_Num = 1
                    else
                        if Encounter_Num <= 5 then
                            Encounter_Num = 2
                        else
                            if Encounter_Num <= 8 then
                                Encounter_Num = 3
                            else
                                if Encounter_Num <= 12 then
                                    Encounter_Num = 4
                                else
                                    if Encounter_Num <= 15 then
                                        Encounter_Num = 5
                                    else
                                        Encounter_Num = 6
                                    end
                                end
                            end
                        end
                    end
                end
                if Ranger_rerolls then
                    if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 3) or (Encounter_Num == 3) or (Encounter_Num == 5) or (Encounter_Num == 7) then
                        Encounter_Num = 0
                    end
                    Ranger_rerolls = Ranger_rerolls - 1
                end
            end
            if fallout.global_var(295) then
                Encounter_Num = fallout.global_var(295)
                fallout.set_global_var(295, 0)
                fallout.display_msg("City encounter type: " + Encounter_Num)
            end
            if Encounter_Num == 1 then
                City1()
            else
                if Encounter_Num == 2 then
                    City2()
                else
                    if Encounter_Num == 3 then
                        City3()
                    else
                        if Encounter_Num == 4 then
                            City4()
                        else
                            if Encounter_Num == 5 then
                                City5()
                            else
                                if Encounter_Num == 6 then
                                    City6()
                                else
                                    hunters()
                                end
                            end
                        end
                    end
                end
            end
        end
        Lighting()
    else
        if fallout.script_action() == 23 then
            Lighting()
        end
    end
end

function stranger()
    if fallout.has_trait(0, fallout.dude_obj(), 46) and (fallout.global_var(601) == 0) and fallout.random(0, 1) then
        Critter_type = 16777520
        Critter_script = 856
        Critter_direction = fallout.random(0, 5)
        Outer_ring = 7
        Inner_ring = 4
        Place_critter()
        Critter_direction = dude_rot + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        fallout.anim(Critter, 1000, Critter_direction)
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 2)
        Item = fallout.create_object_sid(25, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(21, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, fallout.random(7, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        fallout.set_global_var(288, 23)
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

function Place_critter()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    Critter = fallout.create_object_sid(Critter_type, 0, 0, Critter_script)
    v2 = fallout.random(Inner_ring, Outer_ring)
    v0 = fallout.random(0, 5)
    Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, v2)
    v1 = fallout.tile_num_in_direction(Critter_tile, v0, v2 // 2)
    if (fallout.tile_distance(Dude_tile, v1) <= Outer_ring) and (fallout.tile_distance(Dude_tile, v1) >= Inner_ring) then
        Critter_tile = fallout.tile_num_in_direction(Critter_tile, v0, v2 // 2)
    end
    fallout.critter_attempt_placement(Critter, Critter_tile, 0)
end

function hunters()
    Inner_ring = 8
    Outer_ring = 5
    group_angle = fallout.random(0, 5)
    Critter_direction = group_angle + fallout.random(0, 3 * 2) - 3
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Critter_type = 16777349
    Critter_script = 241
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(23, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 4 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
    Item = fallout.create_object_sid(17, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(5, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    Item = fallout.create_object_sid(144, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2)
    Critter_direction = group_angle + fallout.random(0, 3 * 2) - 3
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Critter_type = 16777467
    Critter_script = 383
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(2, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.random(0, 2) == 0 then
        Item = fallout.item_caps_adjust(Critter, fallout.random(5, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    end
    Critter_direction = group_angle + fallout.random(0, 3 * 2) - 3
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Critter_type = 16777472
    Critter_script = 383
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(143, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(34, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 3 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
    Item = fallout.create_object_sid(2, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(14, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
    if fallout.random(0, 2) == 0 then
        Item = fallout.item_caps_adjust(Critter, fallout.random(5, 40) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    end
    Critter_direction = group_angle + fallout.random(0, 3 * 2) - 3
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Critter_type = 16777462
    Critter_script = 383
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(18, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(31, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
    Item = fallout.create_object_sid(2, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.random(0, 2) == 0 then
        Item = fallout.item_caps_adjust(Critter, fallout.random(5, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    end
    stranger()
end

function City1()
    fallout.display_msg(fallout.message_str(244, 100))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 8
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Tot_Critter_A = fallout.random(2, 3)
    group_angle = fallout.random(0, 5)
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2 * 2) - 2)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if fallout.random(0, 2) == 0 then
            if fallout.random(0, 1) == 1 then
                Item = fallout.create_object_sid(11, 0, 0, -1)
            else
                Item = fallout.create_object_sid(12, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(234, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 1)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(5, 20) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Item = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 1 + fallout.has_trait(0, fallout.dude_obj(), 40))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if fallout.random(0, 2) == 0 then
        Critter_direction = fallout.random(0, 5)
        Critter_script = 854
        Critter_type = 16777241
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, fallout.random(5, 20) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    end
    stranger()
end

function City2()
    local v0 = 0
    fallout.display_msg(fallout.message_str(244, 101))
    group_angle = fallout.random(0, 5)
    if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, group_angle, 4)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        if group_angle == 0 then
            Item = 3
        else
            if group_angle == 1 then
                Item = 4
            else
                if group_angle == 2 then
                    Item = 5
                else
                    if group_angle == 3 then
                        Item = 0
                    else
                        if group_angle == 4 then
                            Item = 1
                        else
                            if group_angle == 5 then
                                Item = 2
                            end
                        end
                    end
                end
            end
        end
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, Item, 4)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
    end
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Tot_Critter_A = fallout.random(3, 6)
    Tot_Critter_B = fallout.random(3, 5)
    Critter_type = 16777419
    Critter_script = 749
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if group_angle == 0 then
            Critter_direction = 3
        else
            if group_angle == 1 then
                Critter_direction = 4
            else
                if group_angle == 2 then
                    Critter_direction = 5
                else
                    if group_angle == 3 then
                        Critter_direction = 0
                    else
                        if group_angle == 4 then
                            Critter_direction = 1
                        else
                            if group_angle == 5 then
                                Critter_direction = 2
                            end
                        end
                    end
                end
            end
        end
        if fallout.random(0, 2) == 0 then
            Critter_direction = Critter_direction + (fallout.random(0, 2) - 1)
            while Critter_direction < 0 do
                Critter_direction = Critter_direction + 6
            end
            if Critter_direction > 5 then
                Critter_direction = Critter_direction % 6
            end
        end
        fallout.anim(Critter, 1000, Critter_direction)
        v0 = fallout.random(0, 2)
        if v0 == 0 then
            Item = fallout.create_object_sid(18, 0, 0, -1)
        else
            if v0 == 1 then
                Item = fallout.create_object_sid(21, 0, 0, -1)
            else
                Item = fallout.create_object_sid(8, 0, 0, -1)
            end
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(5, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    Critter_type = 16777472
    Critter_script = 751
    if group_angle == 0 then
        group_angle = 3
    else
        if group_angle == 1 then
            group_angle = 4
        else
            if group_angle == 2 then
                group_angle = 5
            else
                if group_angle == 3 then
                    group_angle = 0
                else
                    if group_angle == 4 then
                        group_angle = 1
                    else
                        if group_angle == 5 then
                            group_angle = 2
                        end
                    end
                end
            end
        end
    end
    while Tot_Critter_B do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if group_angle == 0 then
            Critter_direction = 3
        else
            if group_angle == 1 then
                Critter_direction = 4
            else
                if group_angle == 2 then
                    Critter_direction = 5
                else
                    if group_angle == 3 then
                        Critter_direction = 0
                    else
                        if group_angle == 4 then
                            Critter_direction = 1
                        else
                            if group_angle == 5 then
                                Critter_direction = 2
                            end
                        end
                    end
                end
            end
        end
        if fallout.random(0, 2) == 0 then
            Critter_direction = Critter_direction + (fallout.random(0, 2) - 1)
            while Critter_direction < 0 do
                Critter_direction = Critter_direction + 6
            end
            if Critter_direction > 5 then
                Critter_direction = Critter_direction % 6
            end
        end
        fallout.anim(Critter, 1000, Critter_direction)
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(4, 0, 0, -1)
        else
            Item = fallout.create_object_sid(7, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(4, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(Critter, victim)
    stranger()
end

function City3()
    fallout.display_msg(fallout.message_str(244, 102))
    Tot_Critter_A = fallout.random(2, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    group_angle = fallout.random(0, 5)
    Critter_type = 16777419
    Critter_script = 749
    while Tot_Critter_A do
        Critter_direction = group_angle + fallout.random(0, 2 * 2) - 2
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if Critter_direction == 0 then
            Critter_direction = 3
        else
            if Critter_direction == 1 then
                Critter_direction = 4
            else
                if Critter_direction == 2 then
                    Critter_direction = 5
                else
                    if Critter_direction == 3 then
                        Critter_direction = 0
                    else
                        if Critter_direction == 4 then
                            Critter_direction = 1
                        else
                            if Critter_direction == 5 then
                                Critter_direction = 2
                            end
                        end
                    end
                end
            end
        end
        fallout.anim(Critter, 1000, Critter_direction)
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(8, 0, 0, -1)
        else
            Item = fallout.create_object_sid(9, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(4, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_direction = group_angle + fallout.random(0, 2 * 2) - 2
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Place_critter()
    if Critter_direction == 0 then
        Critter_direction = 3
    else
        if Critter_direction == 1 then
            Critter_direction = 4
        else
            if Critter_direction == 2 then
                Critter_direction = 5
            else
                if Critter_direction == 3 then
                    Critter_direction = 0
                else
                    if Critter_direction == 4 then
                        Critter_direction = 1
                    else
                        if Critter_direction == 5 then
                            Critter_direction = 2
                        end
                    end
                end
            end
        end
    end
    fallout.anim(Critter, 1000, Critter_direction)
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(18, 150) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(38, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(38, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
    end
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(6, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(31, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(31, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
    end
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if start_attack == 0 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    start_attack = 1
    stranger()
end

function City4()
    fallout.display_msg(fallout.message_str(244, 103))
    Tot_Critter_A = fallout.random(5, 15)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 1
    group_angle = fallout.random(0, 5)
    Item = fallout.random(0, 1)
    Critter_type = 16777264
    Critter_script = 222
    while Tot_Critter_A do
        Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if Item then
            if fallout.random(0, 1) then
                Critter_direction = 3
            else
                Critter_direction = 4
            end
            fallout.anim(Critter, 1000, Critter_direction)
            continue
        end
        if fallout.random(0, 1) then
            Critter_direction = 1
        else
            Critter_direction = 2
        end
        fallout.anim(Critter, 1000, Critter_direction)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if start_attack == 0 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    start_attack = 1
    stranger()
end

function City5()
    fallout.display_msg(fallout.message_str(244, 104))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Tot_Critter_A = fallout.random(3, 5)
    group_angle = fallout.random(0, 5)
    Critter_type = 16777419
    Critter_script = 749
    while Tot_Critter_A do
        Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(8, 0, 0, -1)
        else
            Item = fallout.create_object_sid(10, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(4, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777254
    Critter_script = 749
    Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(19, 135) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(38, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
    end
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(6, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(31, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
    end
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if start_attack == 0 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    start_attack = 1
    stranger()
end

function City6()
    fallout.display_msg(fallout.message_str(244, 105))
    Tot_Critter_A = fallout.random(3, 4)
    if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
        Outer_ring = 4
        Inner_ring = 2
    else
        Outer_ring = 3
        Inner_ring = 2
    end
    Critter_type = 16777264
    Critter_script = 222
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if start_attack == 0 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    start_attack = 1
    stranger()
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

function Darkness()
    fallout.set_light_level(40)
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
