local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local stranger
local Place_critter
local hunters
local City1
local City2
local City3
local City4
local City5
local City6

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

local Tot_Critter_A = 0
local Tot_Critter_B = 0
local Encounter_Num = 0
local dude_pos = 0
local dude_rot = 0
local Item = nil
local Dude_tile = 0
local group_angle = 0
local Ranger_rerolls = 0
local Critter = nil
local Inner_ring = 0
local Outer_ring = 0
local Critter_direction = 0
local Critter_type = 0
local Critter_script = -1
local start_attack = 0
local victim = nil
local Critter_tile = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function map_enter_p_proc()
    if misc.map_first_run() then
        dude_pos = fallout.random(0, 2)
        dude_rot = fallout.random(0, 5)
        if dude_pos == 0 then
            fallout.override_map_start(100, 100, 0, dude_rot)
        elseif dude_pos == 1 then
            fallout.override_map_start(116, 83, 0, dude_rot)
        else
            fallout.override_map_start(92, 110, 0, dude_rot)
        end
    end
    if fallout.global_var(32) ~= 1 and misc.map_first_run() then
        Dude_tile = fallout.tile_num(fallout.dude_obj())
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
            if Ranger_rerolls ~= 0 then
                if Encounter_Num == 1 or Encounter_Num == 2 or Encounter_Num == 3 or Encounter_Num == 3 or Encounter_Num == 5 or Encounter_Num == 7 then
                    Encounter_Num = 0
                end
                Ranger_rerolls = Ranger_rerolls - 1
            end
        end
        if fallout.global_var(295) ~= 0 then
            Encounter_Num = fallout.global_var(295)
            fallout.set_global_var(295, 0)
            fallout.display_msg("City encounter type: " .. Encounter_Num)
        end
        if Encounter_Num == 1 then
            City1()
        elseif Encounter_Num == 2 then
            City2()
        elseif Encounter_Num == 3 then
            City3()
        elseif Encounter_Num == 4 then
            City4()
        elseif Encounter_Num == 5 then
            City5()
        elseif Encounter_Num == 6 then
            City6()
        else
            hunters()
        end
    end
    light.lighting()
end

function map_update_p_proc()
    light.lighting()
end

function stranger()
    if fallout.has_trait(0, fallout.dude_obj(), 46) and fallout.global_var(601) == 0 and fallout.random(0, 1) ~= 0 then
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
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 2)
        Item = fallout.create_object_sid(25, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(21, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter,
            fallout.random(7, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        fallout.set_global_var(288, 23)
    end
end

function Place_critter()
    local v1 = 0
    local critter_obj = fallout.create_object_sid(Critter_type, 0, 0, Critter_script)
    local distance = fallout.random(Inner_ring, Outer_ring)
    local rotation = fallout.random(0, 5)
    Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, distance)
    v1 = fallout.tile_num_in_direction(Critter_tile, rotation, distance // 2)
    if fallout.tile_distance(Dude_tile, v1) <= Outer_ring and fallout.tile_distance(Dude_tile, v1) >= Inner_ring then
        Critter_tile = fallout.tile_num_in_direction(Critter_tile, rotation, distance // 2)
    end
    fallout.critter_attempt_placement(critter_obj, Critter_tile, 0)
    return critter_obj
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

function City1()
    fallout.display_msg(fallout.message_str(244, 100))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 8
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Tot_Critter_A = fallout.random(2, 3)
    group_angle = fallout.random(0, 5)
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A > 0 do
        Critter_direction = group_angle + (fallout.random(0, 2 * 2) - 2)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
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
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(5, 20) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Item = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 1 + fallout.has_trait(0, fallout.dude_obj(), 40))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if fallout.random(0, 2) == 0 then
        Critter_direction = fallout.random(0, 5)
        Critter_script = 854
        Critter_type = 16777241
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter,
            fallout.random(5, 20) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    end
    stranger()
end

function City2()
    local v0 = 0
    fallout.display_msg(fallout.message_str(244, 101))
    group_angle = fallout.random(0, 5)
    if time.is_night() then
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, group_angle, 4)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        if group_angle == 0 then
            Critter_direction = 3
        elseif group_angle == 1 then
            Critter_direction = 4
        elseif group_angle == 2 then
            Critter_direction = 5
        elseif group_angle == 3 then
            Critter_direction = 0
        elseif group_angle == 4 then
            Critter_direction = 1
        elseif group_angle == 5 then
            Critter_direction = 2
        end
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, 4)
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
        Critter = Place_critter()
        if group_angle == 0 then
            Critter_direction = 3
        elseif group_angle == 1 then
            Critter_direction = 4
        elseif group_angle == 2 then
            Critter_direction = 5
        elseif group_angle == 3 then
            Critter_direction = 0
        elseif group_angle == 4 then
            Critter_direction = 1
        elseif group_angle == 5 then
            Critter_direction = 2
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
        elseif v0 == 1 then
            Item = fallout.create_object_sid(21, 0, 0, -1)
        else
            Item = fallout.create_object_sid(8, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(5, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    Critter_type = 16777472
    Critter_script = 751
    if group_angle == 0 then
        group_angle = 3
    elseif group_angle == 1 then
        group_angle = 4
    elseif group_angle == 2 then
        group_angle = 5
    elseif group_angle == 3 then
        group_angle = 0
    elseif group_angle == 4 then
        group_angle = 1
    elseif group_angle == 5 then
        group_angle = 2
    end
    while Tot_Critter_B > 0 do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Critter = Place_critter()
        if group_angle == 0 then
            Critter_direction = 3
        elseif group_angle == 1 then
            Critter_direction = 4
        elseif group_angle == 2 then
            Critter_direction = 5
        elseif group_angle == 3 then
            Critter_direction = 0
        elseif group_angle == 4 then
            Critter_direction = 1
        elseif group_angle == 5 then
            Critter_direction = 2
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
        if fallout.random(0, 1) ~= 0 then
            Item = fallout.create_object_sid(4, 0, 0, -1)
        else
            Item = fallout.create_object_sid(7, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(4, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    while Tot_Critter_A > 0 do
        Critter_direction = group_angle + fallout.random(0, 2 * 2) - 2
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Critter = Place_critter()
        if Critter_direction == 0 then
            Critter_direction = 3
        elseif Critter_direction == 1 then
            Critter_direction = 4
        elseif Critter_direction == 2 then
            Critter_direction = 5
        elseif Critter_direction == 3 then
            Critter_direction = 0
        elseif Critter_direction == 4 then
            Critter_direction = 1
        elseif Critter_direction == 5 then
            Critter_direction = 2
        end
        fallout.anim(Critter, 1000, Critter_direction)
        if fallout.random(0, 1) ~= 0 then
            Item = fallout.create_object_sid(8, 0, 0, -1)
        else
            Item = fallout.create_object_sid(9, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(4, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    Critter = Place_critter()
    if Critter_direction == 0 then
        Critter_direction = 3
    elseif Critter_direction == 1 then
        Critter_direction = 4
    elseif Critter_direction == 2 then
        Critter_direction = 5
    elseif Critter_direction == 3 then
        Critter_direction = 0
    elseif Critter_direction == 4 then
        Critter_direction = 1
    elseif Critter_direction == 5 then
        Critter_direction = 2
    end
    fallout.anim(Critter, 1000, Critter_direction)
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(18, 150) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(38, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(38, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
    end
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(6, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(31, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(31, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
    end
    if fallout.random(0, 1) ~= 0 then
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
    local v0 = fallout.random(0, 1)
    Critter_type = 16777264
    Critter_script = 222
    while Tot_Critter_A > 0 do
        Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Critter = Place_critter()
        if v0 ~= 0 then
            if fallout.random(0, 1) ~= 0 then
                Critter_direction = 3
            else
                Critter_direction = 4
            end
            fallout.anim(Critter, 1000, Critter_direction)
        else
            if fallout.random(0, 1) ~= 0 then
                Critter_direction = 1
            else
                Critter_direction = 2
            end
            fallout.anim(Critter, 1000, Critter_direction)
        end
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
    while Tot_Critter_A > 0 do
        Critter_direction = group_angle + fallout.random(0, 1 * 2) - 1
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if fallout.random(0, 1) ~= 0 then
            Item = fallout.create_object_sid(8, 0, 0, -1)
        else
            Item = fallout.create_object_sid(10, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter,
                fallout.random(4, 25) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    Critter = Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter,
        fallout.random(19, 135) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(38, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
    end
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(6, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(0, 1) ~= 0 then
        Item = fallout.create_object_sid(31, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
    end
    if fallout.random(0, 1) ~= 0 then
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
    if time.is_day() then
        Outer_ring = 4
        Inner_ring = 2
    else
        Outer_ring = 3
        Inner_ring = 2
    end
    Critter_type = 16777264
    Critter_script = 222
    while Tot_Critter_A > 0 do
        Critter_direction = fallout.random(0, 5)
        Critter = Place_critter()
        fallout.anim(Critter, 1000,
            fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if start_attack == 0 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    start_attack = 1
    stranger()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
