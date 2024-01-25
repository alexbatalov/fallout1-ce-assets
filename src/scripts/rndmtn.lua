local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_exit_p_proc
local map_update_p_proc
local stranger
local Place_critter
local choose_start
local Patrick
local North_table
local South_table
local Vault_table
local North1
local North2
local North3
local North4
local North5
local North6
local South1
local South2
local South3
local South4
local South5
local South6
local Vault1
local Vault2
local Vault3
local Vault4
local Vault5
local Vault6
local hunters

local party_elevation = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

fallout.set_external_var("Ian_ptr", nil)
fallout.set_external_var("Dog_ptr", nil)
fallout.set_external_var("Tycho_ptr", nil)
fallout.set_external_var("Katja_ptr", nil)
fallout.set_external_var("Tandi_ptr", nil)

local Dude_tile = 0
local Critter_tile = 0
local Critter = nil
local Inner_ring = 0
local Outer_ring = 0
local Critter_direction = 0
local Encounter_Num = 0
local Tot_Critter_A = 0
local Item = nil
local Critter_type = 0
local Critter_script = -1
local Ranger_rerolls = 0
local victim = nil
local dude_pos = 0
local dude_rot = 0
local group_angle = 0
local CritterXpos = 0
local CritterYpos = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    dude_rot = fallout.random(0, 5)
    if fallout.global_var(32) ~= 1 and fallout.metarule(14, 0) ~= 0 then
        Ranger_rerolls = fallout.has_trait(0, fallout.dude_obj(), 47)
        fallout.set_global_var(334, 0)
        while Encounter_Num == 0 do
            Encounter_Num = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
            if fallout.get_critter_stat(fallout.dude_obj(), 6) > 8 then
                Encounter_Num = Encounter_Num + 2
            elseif fallout.get_critter_stat(fallout.dude_obj(), 6) > 7 then
                Encounter_Num = Encounter_Num + 1
            elseif fallout.get_critter_stat(fallout.dude_obj(), 6) < 3 then
                Encounter_Num = Encounter_Num - 1
            end
            if fallout.global_var(123) ~= 3 and fallout.global_var(158) > 2 and fallout.random(0, 1) ~= 0 then
                Encounter_Num = 7
            elseif Encounter_Num <= 3 then
                Encounter_Num = 1
            elseif Encounter_Num <= 5 then
                Encounter_Num = 2
            elseif Encounter_Num <= 8 then
                Encounter_Num = 3
            elseif Encounter_Num <= 12 then
                Encounter_Num = 4
            elseif Encounter_Num <= 15 then
                Encounter_Num = 5
            else
                Encounter_Num = 6
            end
            if fallout.global_var(65) == 2 then
                North_table()
            elseif fallout.global_var(65) == 3 then
                South_table()
            else
                Vault_table()
            end
        end
    else
        if fallout.metarule(14, 0) then
            dude_pos = fallout.random(0, 2)
            if dude_pos == 0 then
                fallout.override_map_start(78, 92, 0, dude_rot)
            elseif dude_pos == 1 then
                fallout.override_map_start(95, 86, 0, dude_rot)
            else
                fallout.override_map_start(94, 90, 0, dude_rot)
            end
        end
    end
    light.lighting()
    party_elevation = party.add_party()
end

function map_exit_p_proc()
    party.remove_party()
end

function map_update_p_proc()
    light.lighting()
end

function stranger()
    if fallout.has_trait(0, fallout.dude_obj(), 46) and (fallout.global_var(601) == 0) and fallout.random(0, 1) ~= 0 then
        Critter_type = 16777520
        Critter_script = 856
        Critter_direction = fallout.random(0, 5)
        Outer_ring = 7
        Inner_ring = 4
        Critter = Place_critter()
        Critter_direction = dude_rot + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        fallout.anim(Critter, 1000, Critter_direction)
        Item = fallout.create_object_sid(113, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 2)
        Item = fallout.item_caps_adjust(Critter,
            fallout.random(7, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        fallout.set_global_var(288, 10)
    end
end

function Place_critter()
    local critter_obj = fallout.create_object_sid(Critter_type, 0, 0, Critter_script)
    local distance = fallout.random(Inner_ring, Outer_ring)
    local rotation = fallout.random(0, 5)
    Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, distance)
    local v1 = fallout.tile_num_in_direction(Critter_tile, rotation, distance // 2)
    if fallout.tile_distance(Dude_tile, v1) <= Outer_ring and fallout.tile_distance(Dude_tile, v1) >= Inner_ring then
        Critter_tile = fallout.tile_num_in_direction(Critter_tile, rotation, distance // 2)
    end
    fallout.critter_attempt_placement(critter_obj, Critter_tile, 0)
    return critter_obj
end

function choose_start()
    if fallout.global_var(65) == 2 then
        if Encounter_Num == 1 then
            fallout.override_map_start(99, 87, 0, 2)
        elseif Encounter_Num == 6 then
            fallout.override_map_start(81, 88, 0, 2)
        else
            fallout.override_map_start(88, 93, 0, dude_rot)
        end
    elseif fallout.global_var(65) == 3 then
        if Encounter_Num == 1 then
            fallout.override_map_start(99, 87, 0, 2)
        elseif Encounter_Num == 5 then
            fallout.override_map_start(82, 95, 0, 2)
        elseif Encounter_Num == 6 then
            fallout.override_map_start(81, 88, 0, 2)
        else
            fallout.override_map_start(88, 93, 0, dude_rot)
        end
    else
        if Encounter_Num == 5 then
            fallout.override_map_start(99, 87, 0, 2)
        elseif Encounter_Num == 6 then
            fallout.override_map_start(92, 93, 0, 2)
        else
            fallout.override_map_start(88, 93, 0, dude_rot)
        end
    end
    Dude_tile = fallout.tile_num(fallout.dude_obj())
end

function Patrick()
    fallout.display_msg(fallout.message_str(246, 121))
    Critter = fallout.create_object_sid(16777247, 0, 0, 667)
    fallout.critter_attempt_placement(Critter, Dude_tile - 4, 0)
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    CritterXpos = (Dude_tile % 200) - 4
    CritterYpos = Dude_tile // 200
    Critter = fallout.create_object_sid(33554810, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, (CritterYpos * 200) + (CritterXpos - 3), 0)
    Critter = fallout.create_object_sid(33554800, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, ((CritterYpos - 1) * 200) + (CritterXpos - 3), 0)
    Critter = fallout.create_object_sid(33554804, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, ((CritterYpos + 1) * 200) + (CritterXpos - 3), 0)
    Critter = fallout.create_object_sid(180, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, (CritterYpos * 200) + (CritterXpos - 2), 0)
    Item = fallout.item_caps_adjust(Critter, fallout.random(2, 6) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(81, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    Critter = fallout.create_object_sid(33555207, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, (CritterYpos * 200) + (CritterXpos - 4), 0)
    Critter = fallout.create_object_sid(33554745, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, ((CritterYpos + 1) * 200) + (CritterXpos - 2), 0)
    Critter = fallout.create_object_sid(180, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, ((CritterYpos - 2) * 200) + (CritterXpos - 2), 0)
    Item = fallout.create_object_sid(106, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 2))
    Item = fallout.create_object_sid(124, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 2))
    Critter = fallout.create_object_sid(33554744, 0, 0, -1)
    fallout.critter_attempt_placement(Critter, ((CritterYpos - 1) * 200) + (CritterXpos - 5), 0)
    if time.is_night() then
        Critter = fallout.create_object_sid(33555044, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 4) * 200) + (CritterXpos - 2), 0)
        Critter = fallout.create_object_sid(33554640, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 4) * 200) + (CritterXpos - 4), 0)
        Critter = fallout.create_object_sid(124, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 5) * 200) + (CritterXpos - 1), 0)
    else
        Critter = fallout.create_object_sid(33554710, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 4) * 200) + (CritterXpos - 2), 0)
        Critter = fallout.create_object_sid(33554711, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 4) * 200) + (CritterXpos - 2), 0)
        Critter = fallout.create_object_sid(33554712, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 4) * 200) + (CritterXpos - 2), 0)
        Critter = fallout.create_object_sid(33554866, 0, 0, -1)
        fallout.critter_attempt_placement(Critter, ((CritterYpos + 4) * 200) + (CritterXpos - 2), 0)
    end
    Item = fallout.create_object_sid(18, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(31, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.has_trait(0, fallout.dude_obj(), 40) then
        Item = fallout.create_object_sid(30, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    Item = fallout.create_object_sid(1, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(25, 50) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    Item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(20, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(45, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2)
    Item = fallout.create_object_sid(46, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(79, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2)
    Item = fallout.create_object_sid(75, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(144, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2)
end

function North_table()
    if Encounter_Num == 3 and fallout.global_var(297) ~= 0 then
        Encounter_Num = 4
    end
    if Ranger_rerolls ~= 0 then
        Ranger_rerolls = Ranger_rerolls - 1
        if Encounter_Num == 1 or Encounter_Num == 2 or Encounter_Num == 4 or Encounter_Num == 6 or Encounter_Num == 7 then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) ~= 0 then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Northern mountain encounter type: " .. Encounter_Num)
    end
    if Encounter_Num ~= 0 then
        if Encounter_Num == 1 then
            North1()
        elseif Encounter_Num == 2 then
            North2()
        elseif Encounter_Num == 3 then
            North3()
        elseif Encounter_Num == 4 then
            North4()
        elseif Encounter_Num == 5 then
            North5()
        elseif Encounter_Num == 6 then
            North6()
        else
            hunters()
        end
    end
end

function South_table()
    if (Encounter_Num == 4) and (fallout.global_var(297) ~= 0) then
        Encounter_Num = 5
    end
    if Ranger_rerolls ~= 0 then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 5) or (Encounter_Num == 6) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) ~= 0 then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Southern Mountain encounter type: " .. Encounter_Num)
    end
    if Encounter_Num ~= 0 then
        if Encounter_Num == 1 then
            South1()
        elseif Encounter_Num == 2 then
            South2()
        elseif Encounter_Num == 3 then
            South3()
        elseif Encounter_Num == 4 then
            South4()
        elseif Encounter_Num == 5 then
            South5()
        elseif Encounter_Num == 6 then
            South6()
        else
            hunters()
        end
    end
end

function Vault_table()
    if Ranger_rerolls ~= 0 then
        Ranger_rerolls = Ranger_rerolls - 1
        if Encounter_Num == 1 or Encounter_Num == 3 or Encounter_Num == 5 or Encounter_Num == 6 or Encounter_Num == 7 then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) ~= 0 then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Vault Mountain encounter type: " .. Encounter_Num)
    end
    if Encounter_Num ~= 0 then
        choose_start()
        if Encounter_Num <= 1 then
            Vault1()
        elseif Encounter_Num <= 2 then
            Vault2()
        elseif Encounter_Num <= 3 then
            Vault3()
        elseif Encounter_Num <= 4 then
            Vault4()
        elseif Encounter_Num <= 5 then
            Vault5()
        elseif Encounter_Num <= 6 then
            Vault6()
        else
            hunters()
        end
    end
end

function North1()
    fallout.display_msg(fallout.message_str(246, 114))
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(246, 115))
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(246, 116))
            fallout.critter_heal(fallout.dude_obj(), fallout.random(1, 3))
        end
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(246, 117))
            fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 6) + 3, 0)
            fallout.critter_injure(fallout.dude_obj(), 2)
        else
            fallout.display_msg(fallout.message_str(246, 118))
            fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 4), 0)
            fallout.critter_injure(fallout.dude_obj(), 2)
        end
    end
end

function North2()
    fallout.display_msg(fallout.message_str(246, 105))
    Tot_Critter_A = fallout.random(2, 3)
    if time.is_night() then
        Outer_ring = 5
        Inner_ring = 3
    else
        Outer_ring = 8
        Inner_ring = 6
    end
    Critter_type = 16777227
    Critter_script = 12
    group_angle = fallout.random(0, 3)
    if group_angle == 3 then
        group_angle = 4
    end
    if group_angle == 2 then
        group_angle = 4
    end
    while Tot_Critter_A > 0 do
        Critter_direction = group_angle
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function North3()
    Patrick()
end

function North4()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(246, 106))
        Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
        Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 1
    else
        fallout.display_msg(fallout.message_str(246, 107))
        Outer_ring = 2
        Inner_ring = 1
    end
    Critter_direction = dude_rot
    Critter_type = 16777227
    Critter_script = 12
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    fallout.critter_injure(fallout.dude_obj(), 2)
    stranger()
end

function North5()
    local v0 = 1
    fallout.display_msg(fallout.message_str(246, 108))
    if fallout.random(0, 1) ~= 0 then
        Tot_Critter_A = fallout.random(1, 2)
    else
        Tot_Critter_A = fallout.random(2, 4)
    end
    Outer_ring = 5
    Inner_ring = 3
    Critter_script = 222
    while Tot_Critter_A > 0 do
        if fallout.random(0, 4) == 4 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
        end
        Critter_direction = fallout.random(0, 2)
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if v0 ~= 0 then
            v0 = fallout.random(2, 4)
            while v0 > 0 do
                Item = fallout.create_object_sid(71,
                    fallout.tile_num_in_direction(fallout.tile_num(Critter), fallout.random(0, 5), fallout.random(2, 4)),
                    0, -1)
                v0 = v0 - 1
            end
            v0 = 0
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function North6()
    local v0 = 0
    local v1 = 0
    fallout.display_msg(fallout.message_str(246, 100))
    Tot_Critter_A = 8
    while Tot_Critter_A > 0 do
        v0 = fallout.random(0, 5)
        if v0 == 4 then
            v1 = 33554864
        elseif v0 == 5 then
            v1 = 33554864 + 1
        else
            v1 = 33554866
        end
        v0 = fallout.random(0, 5)
        if v0 == 5 or v0 == 0 then
            Item = fallout.create_object_sid(v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, v0, fallout.random(1, 6)), 0, -1)
        else
            Item = fallout.create_object_sid(v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, v0, fallout.random(1, 9)), 0, -1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Tot_Critter_A = 10
    while Tot_Critter_A > 0 do
        v1 = fallout.random(0, 3)
        if v1 == 3 then
            v1 = 6
        end
        v0 = fallout.random(0, 5)
        if v0 == 5 or v0 == 0 then
            Item = fallout.create_object_sid(33554861 + v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(1, 6)), 0, -1)
        else
            Item = fallout.create_object_sid(33554861 + v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(1, 9)), 0, -1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Tot_Critter_A = 3
    while Tot_Critter_A > 0 do
        v0 = fallout.random(0, 5)
        if v0 == 5 or v0 == 0 then
            Item = fallout.create_object_sid(33554860,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(3, 6)), 0, -1)
        else
            Item = fallout.create_object_sid(33554860,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(3, 9)), 0, -1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    v0 = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if 1 == 1 then
        fallout.display_msg(fallout.message_str(246, 101))
        fallout.critter_injure(fallout.dude_obj(), 2)
        if 1 == 1 then
            fallout.display_msg(fallout.message_str(246, 102))
            Critter_type = 16777527
            Critter_script = -1
            Outer_ring = 10
            Inner_ring = 10
            Critter_direction = 2
            Critter = Place_critter()
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(10, 60) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(40, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(8, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(29, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Critter, Item, 1 + fallout.has_trait(0, fallout.dude_obj(), 40))
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(1, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(90, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            fallout.kill_critter(Critter, 48)
        else
            if fallout.is_critical(v0) then
                fallout.display_msg(fallout.message_str(246, 103))
                fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 6) + 2, 0)
                if fallout.random(0, 1) ~= 0 then
                    fallout.critter_injure(fallout.dude_obj(), 4)
                else
                    fallout.critter_injure(fallout.dude_obj(), 8)
                end
            else
                fallout.display_msg(fallout.message_str(246, 104))
                fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 4), 0)
                fallout.critter_injure(fallout.dude_obj(), 2)
            end
        end
    end
end

function South1()
    fallout.display_msg(fallout.message_str(246, 114))
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(246, 115))
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(246, 116))
            fallout.critter_heal(fallout.dude_obj(), fallout.random(1, 3))
        end
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(246, 117))
            fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 6) + 3, 0)
            fallout.critter_injure(fallout.dude_obj(), 2)
        else
            fallout.display_msg(fallout.message_str(246, 118))
            fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 6) - 2, 0)
            fallout.critter_injure(fallout.dude_obj(), 2)
        end
    end
end

function South2()
    fallout.display_msg(fallout.message_str(246, 136))
    Tot_Critter_A = fallout.random(2, 6)
    Outer_ring = 7
    Inner_ring = 4
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A > 0 do
        Critter_direction = fallout.random(0, 4)
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function South3()
    fallout.display_msg(fallout.message_str(246, 120))
    Tot_Critter_A = fallout.random(3, 8)
    Outer_ring = 5
    Inner_ring = 2
    Critter_type = 16777264
    Critter_script = 222
    while Tot_Critter_A > 0 do
        Critter_direction = fallout.random(0, 4)
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function South4()
    Patrick()
end

function South5()
    fallout.display_msg(fallout.message_str(246, 122))
    Tot_Critter_A = 9
    Outer_ring = 7
    Inner_ring = 0
    while Tot_Critter_A > 0 do
        if fallout.random(0, 2) == 0 then
            Critter_type = 33554711
        else
            Critter_type = 33554866
        end
        Item = fallout.create_object_sid(Critter_type,
            fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                fallout.random(0, 11)), 0, -1)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Item = fallout.create_object_sid(33554514,
        fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, fallout.random(0, 5), fallout.random(1, 8)),
        0, -1)
    Item = fallout.create_object_sid(33554515,
        fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(2, 7)),
        0, -1)
    Item = fallout.create_object_sid(7,
        fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, fallout.random(0, 5), fallout.random(3, 7)),
        0, -1)
    Item = fallout.create_object_sid(4,
        fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, fallout.random(0, 5), fallout.random(2, 9)),
        0, -1)
    Item = fallout.create_object_sid(4,
        fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(2, 7)),
        0, -1)
    Outer_ring = 9
    Inner_ring = 3
    Critter_script = -1
    Critter_type = 16777234
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 48)
    Critter_type = 16777234
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 57)
    Critter_type = 16777229
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 57)
    Critter_type = 16777229
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 48)
    Critter_type = 16777255
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 48)
    Critter_type = 16777247
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 48)
    Critter_type = 16777230
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 48)
    Critter_type = 16777229
    Critter_direction = fallout.random(0, 5)
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 57)
    if fallout.get_critter_stat(fallout.dude_obj(), 6) >= 4 then
        Critter_type = 16777243
        Critter_direction = fallout.random(0, 5)
        Critter = Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Item = fallout.create_object_sid(30, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(29, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        fallout.kill_critter(Critter, 48)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 6) >= 4 then
        if fallout.random(0, 1) ~= 0 then
            Item = fallout.create_object_sid(29,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                    fallout.random(3, 6)), 0, -1)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                Item = fallout.create_object_sid(29,
                    fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                        fallout.random(3, 6)), 0, -1)
            end
        end
        if fallout.random(0, 1) ~= 0 then
            Item = fallout.create_object_sid(30,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                    fallout.random(3, 6)), 0, -1)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                Item = fallout.create_object_sid(30,
                    fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                        fallout.random(3, 6)), 0, -1)
            end
        end
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 6) >= 9 then
        if fallout.random(0, 1) ~= 0 then
            Item = fallout.create_object_sid(8,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                    fallout.random(3, 6)), 0, -1)
        else
            if fallout.random(0, 1) ~= 0 then
                Item = fallout.create_object_sid(10,
                    fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                        fallout.random(3, 6)), 0, -1)
            else
                Item = fallout.create_object_sid(94,
                    fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5),
                        fallout.random(3, 6)), 0, -1)
            end
        end
    end
    Tot_Critter_A = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 6) <= 3 then
        Tot_Critter_A = fallout.random(2, 4)
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) < 7 then
            Tot_Critter_A = fallout.random(1, 2)
        end
    end
    Outer_ring = 7
    Inner_ring = 4
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A > 0 do
        Critter_direction = fallout.random(1, 2)
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
end

function South6()
    local v0 = 0
    local v1 = 0
    fallout.display_msg(fallout.message_str(246, 100))
    Tot_Critter_A = 8
    while Tot_Critter_A > 0 do
        v0 = fallout.random(0, 5)
        if v0 == 4 then
            v1 = 33554864
        else
            if v0 == 5 then
                v1 = 33554864 + 1
            else
                v1 = 33554866
            end
        end
        v0 = fallout.random(0, 5)
        if v0 == 5 or v0 == 0 then
            Item = fallout.create_object_sid(v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, v0, fallout.random(1, 6)), 0, -1)
        else
            Item = fallout.create_object_sid(v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, v0, fallout.random(1, 9)), 0, -1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Tot_Critter_A = 10
    while Tot_Critter_A > 0 do
        v1 = fallout.random(0, 3)
        if v1 == 3 then
            v1 = 6
        end
        v0 = fallout.random(0, 5)
        if v0 == 5 or v0 == 0 then
            Item = fallout.create_object_sid(33554861 + v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(1, 6)), 0, -1)
        else
            Item = fallout.create_object_sid(33554861 + v1,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(1, 9)), 0, -1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Tot_Critter_A = 3
    while Tot_Critter_A > 0 do
        v0 = fallout.random(0, 5)
        if v0 == 5 or v0 == 0 then
            Item = fallout.create_object_sid(33554860,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(3, 6)), 0, -1)
        else
            Item = fallout.create_object_sid(33554860,
                fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 4) - 2, v0, fallout.random(3, 9)), 0, -1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    v0 = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.is_success(v0) then
        fallout.display_msg(fallout.message_str(246, 101))
        fallout.critter_injure(fallout.dude_obj(), 2)
        if fallout.is_critical(v0) then
            fallout.display_msg(fallout.message_str(246, 102))
            Critter_type = 16777527
            Critter_script = -1
            Outer_ring = 10
            Inner_ring = 10
            Critter_direction = 2
            Critter = Place_critter()
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(10, 60) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(40, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(8, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(29, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Critter, Item, 1 + fallout.has_trait(0, fallout.dude_obj(), 40))
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(1, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            if fallout.random(1, 4) == 4 then
                Item = fallout.create_object_sid(90, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            fallout.kill_critter(Critter, 48)
        else
            if fallout.is_critical(v0) then
                fallout.display_msg(fallout.message_str(246, 103))
                fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 6) + 2, 0)
                if fallout.random(0, 1) ~= 0 then
                    fallout.critter_injure(fallout.dude_obj(), 4)
                else
                    fallout.critter_injure(fallout.dude_obj(), 8)
                end
            else
                fallout.display_msg(fallout.message_str(246, 104))
                fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 4), 0)
                fallout.critter_injure(fallout.dude_obj(), 2)
            end
        end
    end
end

function Vault1()
    fallout.display_msg(fallout.message_str(246, 128))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 4) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 4) + 4
    Critter_direction = fallout.random(0, 4)
    Critter_type = 16777227
    Critter_script = 928
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    stranger()
end

function Vault2()
    fallout.display_msg(fallout.message_str(246, 135))
    Critter_type = 16777527
    Critter_script = -1
    Outer_ring = 6
    Inner_ring = 4
    Critter_direction = 1
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 48)
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(29, 0, 0, -1)
        fallout.critter_attempt_placement(Item, fallout.tile_num(Critter), 0)
    end
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.critter_attempt_placement(Item, fallout.tile_num(Critter), 0)
    end
end

function Vault3()
    fallout.display_msg(fallout.message_str(246, 129))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    Tot_Critter_A = fallout.random(2, 3)
    Critter_script = 222
    while Tot_Critter_A > 0 do
        if fallout.random(0, 3) == 3 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
        end
        Critter_direction = fallout.random(0, 4)
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function Vault4()
    fallout.display_msg(fallout.message_str(246, 130))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 1
    Tot_Critter_A = fallout.random(4, 8)
    Critter_type = 16777264
    Critter_script = 222
    while Tot_Critter_A > 0 do
        Critter_direction = fallout.random(0, 5)
        Critter = Place_critter()
        if fallout.random(0, 1) ~= 0 then
            fallout.anim(Critter, 1000, fallout.random(0, 5))
        else
            fallout.anim(Critter, 1000,
                fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    stranger()
end

function Vault5()
    local roll = fallout.do_check(fallout.dude_obj(), 5, 0)
    if not (fallout.is_success(roll)) then
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(246, 132))
            fallout.critter_dmg(fallout.dude_obj(), fallout.random(1, 3), 0)
            fallout.critter_injure(fallout.dude_obj(), 2)
        else
            fallout.display_msg(fallout.message_str(246, 133))
            fallout.critter_dmg(fallout.dude_obj(), 1, 0)
            fallout.critter_injure(fallout.dude_obj(), 2)
        end
    else
        fallout.display_msg(fallout.message_str(246, 131))
        fallout.critter_injure(fallout.dude_obj(), 2)
    end
end

function Vault6()
    fallout.display_msg(fallout.message_str(246, 134))
    Outer_ring = 6
    Inner_ring = 4
    Tot_Critter_A = fallout.random(4, 6)
    Critter_type = 16777264
    Critter_script = 934
    while Tot_Critter_A > 0 do
        Critter_direction = 1
        Critter = Place_critter()
        fallout.anim(Critter, 1000, 4)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    if time.is_night() then
        Critter_type = 16777227
        Critter_script = 12
        Outer_ring = 10
        Inner_ring = 9
        Critter_direction = 1
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    end
    stranger()
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
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(23, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 4 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
    Item = fallout.create_object_sid(17, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter,
        fallout.random(5, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(2, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.random(0, 2) == 0 then
        Item = fallout.item_caps_adjust(Critter,
            fallout.random(5, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    Critter = Place_critter()
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
        Item = fallout.item_caps_adjust(Critter,
            fallout.random(5, 40) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(18, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(31, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
    Item = fallout.create_object_sid(2, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.random(0, 2) == 0 then
        Item = fallout.item_caps_adjust(Critter,
            fallout.random(5, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    end
    stranger()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
