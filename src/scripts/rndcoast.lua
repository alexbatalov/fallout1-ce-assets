local fallout = require("fallout")

local start
local stranger
local Lighting
local Place_critter
local hunters
local Coast1
local Coast2
local Coast3
local Coast4
local Coast5
local Coast6
local choose_start
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
local victim = 0
local restrict_range = 0
local Critter_tile = 0
local MapX = 0
local MapY = 0

local Darkness
local Invasion

function start()
    if fallout.script_action() == 15 then
        dude_pos = fallout.random(0, 2)
        dude_rot = fallout.random(0, 5)
        if (fallout.global_var(32) ~= 1) and fallout.metarule(14, 0) then
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
                    if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 4) or (Encounter_Num == 5) or (Encounter_Num == 7) then
                        Encounter_Num = 0
                    end
                    Ranger_rerolls = Ranger_rerolls - 1
                end
            end
            if fallout.global_var(295) > 0 then
                Encounter_Num = fallout.global_var(295)
                fallout.set_global_var(295, 0)
                fallout.debug_msg("Coast encounter type: " + Encounter_Num)
            end
            choose_start()
            Dude_tile = fallout.tile_num(fallout.dude_obj())
            if Encounter_Num == 1 then
                Coast1()
            else
                if Encounter_Num == 2 then
                    Coast2()
                else
                    if Encounter_Num == 3 then
                        Coast3()
                    else
                        if Encounter_Num == 4 then
                            Coast4()
                        else
                            if Encounter_Num == 5 then
                                Coast5()
                            else
                                if Encounter_Num == 6 then
                                    Coast6()
                                else
                                    hunters()
                                end
                            end
                        end
                    end
                end
            end
        else
            if fallout.metarule(14, 0) then
                if dude_pos == 0 then
                    fallout.override_map_start(92, 98, 0, dude_rot)
                else
                    if dude_pos == 1 then
                        fallout.override_map_start(95, 109, 0, dude_rot)
                    else
                        fallout.override_map_start(92, 101, 0, dude_rot)
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
        Critter_direction = fallout.random(0, 1)
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
        Item = fallout.create_object_sid(116, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, fallout.random(7, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        fallout.set_global_var(288, 12)
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
    if restrict_range then
        v0 = fallout.random(0, 2)
    else
        v0 = fallout.random(0, 5)
    end
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

function Coast1()
    fallout.display_msg(fallout.message_str(245, 100))
    fallout.display_msg(fallout.message_str(245, 104))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 7
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Tot_Critter_A = fallout.random(2, 4)
    Critter_type = 16777261
    Critter_script = 953
    if restrict_range then
        group_angle = fallout.random(0, 1)
    else
        group_angle = fallout.random(0, 5)
    end
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 1 * 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Outer_ring = 3
    Inner_ring = 2
    Critter_type = 16777261
    Critter_script = 953
    if restrict_range then
        Critter_direction = fallout.random(0, 1)
    else
        Critter_direction = group_angle + (fallout.random(0, 1 * 2) - 1)
    end
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Outer_ring = 6
    Inner_ring = 3
    Critter_type = 16777254
    Critter_script = -1
    if restrict_range then
        Critter_direction = fallout.random(0, 1)
    else
        Critter_direction = fallout.random(0, 5)
    end
    Place_critter()
    Item = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(34, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
    Item = fallout.item_caps_adjust(Critter, fallout.random(4, 25) * (1 + (2 * fallout.has_trait(0, fallout.dude_obj(), 20))))
    fallout.kill_critter(Critter, 61)
    stranger()
end

function Coast2()
    fallout.display_msg(fallout.message_str(112, 313))
    Tot_Critter_A = fallout.random(4, 7)
    if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
        Outer_ring = 6
        Inner_ring = 3
    else
        Outer_ring = 4
        Inner_ring = 3
    end
    Critter_type = 16777284
    Critter_script = 735
    while Tot_Critter_A do
        Critter_direction = fallout.random(1, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function Coast3()
    fallout.display_msg(fallout.message_str(245, 101))
    Outer_ring = 4
    Inner_ring = 1
    Tot_Critter_A = fallout.random(8, 12)
    Critter_type = 16777264
    Critter_script = 222
    if restrict_range then
        group_angle = fallout.random(0, 1)
    else
        group_angle = fallout.random(0, 5)
    end
    while Tot_Critter_A do
        if restrict_range then
            Critter_direction = group_angle
        else
            Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
        end
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function Coast4()
    fallout.display_msg(fallout.message_str(245, 102))
    fallout.set_global_var(290, 0)
    fallout.set_global_var(291, 0)
    fallout.set_global_var(292, 0)
    group_angle = fallout.random(0, 2)
    MapX = (Dude_tile % 200) + 8
    MapY = (Dude_tile // 200) + 6
    if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
        Critter = fallout.create_object_sid(33555044, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX - 2), 0)
        Critter = fallout.create_object_sid(33555044, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 4), 0)
        Critter = fallout.create_object_sid(33554640, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 5) * 200) + (MapX - 4), 0)
        Critter = fallout.create_object_sid(33554640, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX - 7), 0)
        Critter = fallout.create_object_sid(33554641, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 7) * 200) + MapX, 0)
        Critter = fallout.create_object_sid(33554640, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(93, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 3) * 200) + (MapX + 3), 0)
    else
        Critter = fallout.create_object_sid(33554710, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX - 3), 0)
        Critter = fallout.create_object_sid(33554711, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX - 3), 0)
        Critter = fallout.create_object_sid(33554712, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX - 3), 0)
        Critter = fallout.create_object_sid(33554866, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX - 3), 0)
        Critter = fallout.create_object_sid(33554710, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 4), 0)
        Critter = fallout.create_object_sid(33554711, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 4), 0)
        Critter = fallout.create_object_sid(33554712, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 4), 0)
        Critter = fallout.create_object_sid(33554866, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 4), 0)
        Critter = fallout.create_object_sid(33554435, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 5) * 200) + (MapX + 1), 0)
        Critter = fallout.create_object_sid(33554529, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 5) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554530, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 7) * 200) + (MapX + 1), 0)
        Critter = fallout.create_object_sid(33554528, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 2) * 200) + MapX, 0)
        Critter = fallout.create_object_sid(33554527, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 5) * 200) + (MapX - 1), 0)
        Critter = fallout.create_object_sid(33554833 + 1, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 2) * 200) + (MapX - 3), 0)
        Critter = fallout.create_object_sid(33554833 + 1, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 8) * 200) + (MapX + 5), 0)
        Critter = fallout.create_object_sid(33554833 + 2, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX + 4), 0)
        Critter = fallout.create_object_sid(46, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 7) * 200) + (MapX + 3), 0)
        Critter = fallout.create_object_sid(93, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 3) * 200) + (MapX + 3), 0)
    end
    Outer_ring = 9
    Inner_ring = 6
    Tot_Critter_A = fallout.random(3, 4)
    fallout.set_global_var(289, Tot_Critter_A)
    Critter_script = 750
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            Critter_type = 16777247
            Item = fallout.create_object_sid(7, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        else
            Critter_type = 16777419
            Item = fallout.create_object_sid(21, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
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
        if fallout.random(0, 1) == 0 then
            Critter_direction = Critter_direction + (fallout.random(0, 2) - 1)
            while Critter_direction < 0 do
                Critter_direction = Critter_direction + 6
            end
            if Critter_direction > 5 then
                Critter_direction = Critter_direction % 6
            end
        end
        fallout.anim(Critter, 1000, Critter_direction)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(6, 15) * (1 + (1 * fallout.has_trait(0, fallout.dude_obj(), 20))))
        end
        if fallout.random(0, 1) then
            if fallout.random(0, 2) == 0 then
                Item = fallout.create_object_sid(125, 0, 0, -1)
            else
                Item = fallout.create_object_sid(124, 0, 0, -1)
            end
            fallout.add_obj_to_inven(Critter, Item)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    Critter_script = 713
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
    Tot_Critter_A = fallout.random(3, 5)
    fallout.set_global_var(288, 6)
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        if Critter_direction == 0 then
            Critter_type = 16777386
        else
            if Critter_direction == 1 then
                Critter_type = 16777248
            else
                if Critter_direction == 2 then
                    Critter_type = 16777387
                else
                    if Critter_direction == 3 then
                        Critter_type = 16777388
                    else
                        Critter_type = 16777236
                    end
                end
            end
        end
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(46, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(2, 4) * (1 + (1 * fallout.has_trait(0, fallout.dude_obj(), 20))))
        end
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777258
    Critter_script = 713
    fallout.set_global_var(288, 68)
    Tot_Critter_A = fallout.random(1, 2)
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if fallout.random(0, 2) == 0 then
            Item = fallout.create_object_sid(163, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(2, 4) * (1 + (1 * fallout.has_trait(0, fallout.dude_obj(), 20))))
        end
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777252
    Critter_script = 713
    fallout.set_global_var(288, 8)
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
    fallout.attack_setup(victim, Critter)
    stranger()
end

function Coast5()
    fallout.display_msg(fallout.message_str(112, 313))
    Outer_ring = 6
    Inner_ring = 4
    Tot_Critter_A = fallout.random(4, 6)
    Critter_type = 16777284
    Critter_script = 735
    if restrict_range then
        group_angle = fallout.random(1, 2)
    else
        group_angle = fallout.random(0, 5)
    end
    while Tot_Critter_A do
        if restrict_range then
            Critter_direction = group_angle
        else
            Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
        end
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function Coast6()
    fallout.display_msg(fallout.message_str(245, 103))
    if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
        Critter = fallout.create_object_sid(33554640, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 4) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554641, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 2) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33555044, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 1) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554747, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 6), 0)
    else
        Critter = fallout.create_object_sid(33554833 + 1, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 3) * 200) + (MapX + 3), 0)
        Critter = fallout.create_object_sid(33554833 + 1, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 2) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554710, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 1) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554711, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 1) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554712, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 1) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554866, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY - 1) * 200) + (MapX + 2), 0)
        Critter = fallout.create_object_sid(33554747, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((MapY + 6) * 200) + (MapX + 6), 0)
    end
    Critter = fallout.create_object_sid(16777229, 0, 0, 644)
    fallout.critter_attempt_placement(Critter, ((MapY + 2) * 200) + (MapX + 11), 0)
    fallout.anim(Critter, 1000, 3)
    Item = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(109, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(18, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(31, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2)
    Item = fallout.item_caps_adjust(Critter, fallout.random(50, 100) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    Item = fallout.create_object_sid(81, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 3)
    Critter = fallout.create_object_sid(16777258, 0, 0, 645)
    fallout.critter_attempt_placement(Critter, ((MapY + 4) * 200) + (MapX + 10), 0)
    fallout.anim(Critter, 1000, 3)
    Item = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(103, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(2, 3) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
end

function choose_start()
    if (Encounter_Num == 2) or (Encounter_Num == 5) then
        fallout.override_map_start(92, 97, 0, dude_rot)
    else
        if Encounter_Num == 6 then
            if fallout.cur_map_index() == 20 then
                MapX = 113
                MapY = 93
                fallout.override_map_start(MapX, MapY, 0, dude_rot)
            else
                MapX = 103
                MapY = 94
                fallout.override_map_start(MapX, MapY, 0, dude_rot)
            end
        else
            if (Encounter_Num == 4) or (Encounter_Num == 7) then
                fallout.override_map_start(94, 98, 0, dude_rot)
            else
                if dude_pos == 0 then
                    fallout.override_map_start(99, 102, 0, dude_rot)
                else
                    restrict_range = 1
                    if dude_pos == 1 then
                        fallout.override_map_start(108, 94, 0, dude_rot)
                    else
                        fallout.override_map_start(111, 104, 0, dude_rot)
                    end
                end
            end
        end
    end
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
