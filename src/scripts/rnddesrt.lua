local fallout = require("fallout")
local light = require("lib.light")
local time = require("lib.time")

local start
local stranger
local choose_start
local North_table
local South_table
local Shady_table
local Raider_table
local Junk_table
local Hub_table
local Necrop_table
local Steel_table
local Vats_table
local Glow_table
local Bone_table
local Death_table
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
local Shady1
local Shady2
local Shady3
local Shady4
local Shady5
local Shady6
local Raider1
local Raider2
local Raider3
local Raider4
local Raider5
local Raider6
local Junk1
local Junk2
local Junk3
local Junk4
local Junk5
local Junk6
local Hub1
local Hub2
local Hub3
local Hub4
local Hub5
local Hub6
local Necrop1
local Necrop2
local Necrop3
local Necrop4
local Necrop5
local Necrop6
local Steel1
local Steel2
local Steel3
local Steel4
local Steel5
local Steel6
local Vats1
local Vats2
local Vats3
local Vats4
local Vats5
local Vats6
local Glow1
local Glow2
local Glow3
local Glow4
local Glow5
local Glow6
local Death1
local Death2
local Death3
local Death4
local Death5
local Death6
local Bone1
local Bone2
local Bone3
local Bone4
local Bone5
local Bone6
local Scenes
local Place_critter
local hunters
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

local Dude_tile = 0
local Place_Holder = 0
local Encounter_Num = 0
local Tot_Critter_A = 0
local Tot_Critter_B = 0
local Scorpions_Killed = 0
local Skill_roll = 0
local Item = 0
local money = 0
local Ranger_rerolls = 0
local victim = 0
local Critter = 0
local Inner_ring = 0
local Outer_ring = 0
local Critter_direction = 0
local Critter_tile = 0
local Critter_type = 0
local Critter_script = -1
local dude_pos = 0
local dude_rot = 0
local group_angle = 0
local Range = 0

fallout.create_external_var("random_seed_1")
fallout.create_external_var("random_seed_2")
fallout.create_external_var("random_seed_3")

function start()
    if fallout.script_action() == 15 then
        dude_rot = fallout.random(0, 5)
        fallout.set_global_var(335, 0)
        if (fallout.global_var(32) ~= 1) and fallout.metarule(14, 0) then
            Ranger_rerolls = fallout.has_trait(0, fallout.dude_obj(), 47)
            fallout.set_global_var(334, 0)
            while Encounter_Num == 0 do
                Encounter_Num = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
                if fallout.get_critter_stat(fallout.dude_obj(), 6) > 8 then
                    Encounter_Num = Encounter_Num + 2
                else
                    if fallout.get_critter_stat(fallout.dude_obj(), 6) > 6 then
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
                if fallout.global_var(65) == 0 then
                    North_table()
                else
                    if fallout.global_var(65) == 1 then
                        South_table()
                    else
                        if fallout.global_var(65) == 5 then
                            Shady_table()
                        else
                            if fallout.global_var(65) == 6 then
                                Raider_table()
                            else
                                if fallout.global_var(65) == 7 then
                                    Junk_table()
                                else
                                    if fallout.global_var(65) == 8 then
                                        Hub_table()
                                    else
                                        if fallout.global_var(65) == 9 then
                                            Necrop_table()
                                        else
                                            if fallout.global_var(65) == 10 then
                                                Steel_table()
                                            else
                                                if fallout.global_var(65) == 11 then
                                                    Vats_table()
                                                else
                                                    if fallout.global_var(65) == 12 then
                                                        Glow_table()
                                                    else
                                                        if fallout.global_var(65) == 14 then
                                                            Death_table()
                                                        else
                                                            if fallout.global_var(65) == 13 then
                                                                Bone_table()
                                                            else
                                                                if fallout.random(0, 1) then
                                                                    North_table()
                                                                else
                                                                    South_table()
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if fallout.metarule(14, 0) then
                dude_pos = fallout.random(0, 3)
                Dude_tile = fallout.tile_num(fallout.dude_obj())
                Scenes()
                if dude_pos == 0 then
                    fallout.override_map_start(109, 72, 0, dude_rot)
                else
                    if dude_pos == 1 then
                        fallout.override_map_start(131, 102, 0, dude_rot)
                    else
                        if dude_pos == 2 then
                            fallout.override_map_start(90, 112, 0, dude_rot)
                        else
                            fallout.override_map_start(80, 86, 0, dude_rot)
                        end
                    end
                end
            end
        end
        light.lighting()
    else
        if fallout.script_action() == 23 then
            light.lighting()
        else
            if fallout.script_action() == 16 then
                Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 0)
                if Scorpions_Killed == 1 then
                    if fallout.is_success(Skill_roll) then
                        if fallout.is_critical(Skill_roll) then
                            fallout.display_msg(fallout.message_str(112, 100))
                        else
                            fallout.display_msg(fallout.message_str(112, 101))
                        end
                    else
                        if fallout.is_critical(Skill_roll) then
                            fallout.display_msg(fallout.message_str(112, 102))
                        else
                            fallout.display_msg(fallout.message_str(112, 103))
                        end
                    end
                end
            end
        end
    end
end

function stranger()
    local v0 = 1
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
        Item = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 2)
        Item = fallout.item_caps_adjust(Critter, fallout.random(7, 30) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        v0 = fallout.global_var(288)
        if v0 == 1 then
            fallout.set_global_var(288, 10)
        else
            if v0 == 2 then
                fallout.set_global_var(288, 9)
            else
                fallout.set_global_var(288, 15)
            end
        end
    end
end

function choose_start()
    dude_pos = fallout.random(0, 3)
    if fallout.global_var(65) == 1 then
        if Encounter_Num == 1 then
            fallout.override_map_start(93, 91, 0, 1)
        else
            if dude_pos == 0 then
                fallout.override_map_start(109, 72, 0, dude_rot)
            else
                if dude_pos == 1 then
                    fallout.override_map_start(131, 102, 0, dude_rot)
                else
                    if dude_pos == 2 then
                        fallout.override_map_start(90, 112, 0, dude_rot)
                    else
                        fallout.override_map_start(80, 86, 0, dude_rot)
                    end
                end
            end
        end
    else
        if fallout.global_var(65) == 10 then
            if (Encounter_Num == 1) or (Encounter_Num == 5) or (Encounter_Num == 6) then
                fallout.override_map_start(100, 100, 0, dude_rot)
            else
                if dude_pos == 0 then
                    fallout.override_map_start(109, 72, 0, dude_rot)
                else
                    if dude_pos == 1 then
                        fallout.override_map_start(131, 102, 0, dude_rot)
                    else
                        if dude_pos == 2 then
                            fallout.override_map_start(90, 112, 0, dude_rot)
                        else
                            fallout.override_map_start(80, 86, 0, dude_rot)
                        end
                    end
                end
            end
        else
            if dude_pos == 0 then
                fallout.override_map_start(109, 72, 0, dude_rot)
            else
                if dude_pos == 1 then
                    fallout.override_map_start(131, 102, 0, dude_rot)
                else
                    if dude_pos == 2 then
                        fallout.override_map_start(90, 112, 0, dude_rot)
                    else
                        fallout.override_map_start(80, 86, 0, dude_rot)
                    end
                end
            end
        end
    end
    Dude_tile = fallout.tile_num(fallout.dude_obj())
    Scenes()
end

function North_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 3) or (Encounter_Num == 4) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Northern Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            North1()
        else
            if Encounter_Num == 2 then
                North2()
            else
                if Encounter_Num == 3 then
                    North3()
                else
                    if Encounter_Num == 4 then
                        North4()
                    else
                        if Encounter_Num == 5 then
                            North5()
                        else
                            if Encounter_Num == 6 then
                                North6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function South_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 2) or (Encounter_Num == 4) or (Encounter_Num == 5) or (Encounter_Num == 6) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Southern Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            South1()
        else
            if Encounter_Num == 2 then
                South2()
            else
                if Encounter_Num == 3 then
                    South3()
                else
                    if Encounter_Num == 4 then
                        South4()
                    else
                        if Encounter_Num == 5 then
                            South5()
                        else
                            if Encounter_Num == 6 then
                                South6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Shady_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 3) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Shady Sands Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Shady1()
        else
            if Encounter_Num == 2 then
                Shady2()
            else
                if Encounter_Num == 3 then
                    Shady3()
                else
                    if Encounter_Num == 4 then
                        Shady4()
                    else
                        if Encounter_Num == 5 then
                            Shady5()
                        else
                            if Encounter_Num == 6 then
                                Shady6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Raider_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 3) or (Encounter_Num == 4) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Raiders Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Raider1()
        else
            if Encounter_Num == 2 then
                Raider2()
            else
                if Encounter_Num == 3 then
                    Raider3()
                else
                    if Encounter_Num == 4 then
                        Raider4()
                    else
                        if Encounter_Num == 5 then
                            Raider5()
                        else
                            if Encounter_Num == 6 then
                                Raider6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Junk_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 3) or (Encounter_Num == 4) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Junk Town Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Junk1()
        else
            if Encounter_Num == 2 then
                Junk2()
            else
                if Encounter_Num == 3 then
                    Junk3()
                else
                    if Encounter_Num == 4 then
                        Junk4()
                    else
                        if Encounter_Num == 5 then
                            Junk5()
                        else
                            if Encounter_Num == 6 then
                                Junk6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Hub_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 2) or (Encounter_Num == 3) or (Encounter_Num == 4) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Hub Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Hub1()
        else
            if Encounter_Num == 2 then
                Hub2()
            else
                if Encounter_Num == 3 then
                    Hub3()
                else
                    if Encounter_Num == 4 then
                        Hub4()
                    else
                        if Encounter_Num == 5 then
                            Hub5()
                        else
                            if Encounter_Num == 6 then
                                Hub6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Necrop_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 2) or (Encounter_Num == 3) or (Encounter_Num == 5) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Necropolis Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Necrop1()
        else
            if Encounter_Num == 2 then
                Necrop2()
            else
                if Encounter_Num == 3 then
                    Necrop3()
                else
                    if Encounter_Num == 4 then
                        Necrop4()
                    else
                        if Encounter_Num == 5 then
                            Necrop5()
                        else
                            if Encounter_Num == 6 then
                                Necrop6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Steel_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 4) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Brotherhood of Steel Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Steel1()
        else
            if Encounter_Num == 2 then
                Steel2()
            else
                if Encounter_Num == 3 then
                    Steel3()
                else
                    if Encounter_Num == 4 then
                        Steel4()
                    else
                        if Encounter_Num == 5 then
                            Steel5()
                        else
                            if Encounter_Num == 6 then
                                Steel6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Vats_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 3) or (Encounter_Num == 4) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Vats Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Vats1()
        else
            if Encounter_Num == 2 then
                Vats2()
            else
                if Encounter_Num == 3 then
                    Vats3()
                else
                    if Encounter_Num == 4 then
                        Vats4()
                    else
                        if Encounter_Num == 5 then
                            Vats5()
                        else
                            if Encounter_Num == 6 then
                                Vats6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Glow_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 3) or (Encounter_Num == 4) or (Encounter_Num == 5) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Glow Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Glow1()
        else
            if Encounter_Num == 2 then
                Glow2()
            else
                if Encounter_Num == 3 then
                    Glow3()
                else
                    if Encounter_Num == 4 then
                        Glow4()
                    else
                        if Encounter_Num == 5 then
                            Glow5()
                        else
                            if Encounter_Num == 6 then
                                Glow6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Bone_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 3) or (Encounter_Num == 5) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Bone Desert encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Bone1()
        else
            if Encounter_Num == 2 then
                Bone2()
            else
                if Encounter_Num == 3 then
                    Bone3()
                else
                    if Encounter_Num == 4 then
                        Bone4()
                    else
                        if Encounter_Num == 5 then
                            Bone5()
                        else
                            if Encounter_Num == 6 then
                                Bone6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function Death_table()
    if Ranger_rerolls then
        Ranger_rerolls = Ranger_rerolls - 1
        if (Encounter_Num == 1) or (Encounter_Num == 2) or (Encounter_Num == 4) or (Encounter_Num == 6) or (Encounter_Num == 7) then
            Encounter_Num = 0
        end
    end
    if fallout.global_var(295) then
        Encounter_Num = fallout.global_var(295)
        fallout.set_global_var(295, 0)
        fallout.debug_msg("Death Claw encounter type: " .. Encounter_Num)
    end
    if Encounter_Num then
        choose_start()
        if Encounter_Num == 1 then
            Death1()
        else
            if Encounter_Num == 2 then
                Death2()
            else
                if Encounter_Num == 3 then
                    Death3()
                else
                    if Encounter_Num == 4 then
                        Death4()
                    else
                        if Encounter_Num == 5 then
                            Death5()
                        else
                            if Encounter_Num == 6 then
                                Death6()
                            else
                                hunters()
                            end
                        end
                    end
                end
            end
        end
    end
end

function North1()
    fallout.display_msg(fallout.message_str(112, 104))
    Tot_Critter_A = fallout.random(3, 6)
    Tot_Critter_B = fallout.random(4, 8)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    group_angle = fallout.random(0, 5)
    Critter_type = 16777227
    Critter_script = 12
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    Critter_script = 222
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
        if fallout.random(0, 3) == 3 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
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
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(fallout.dude_obj(), victim)
    fallout.attack_setup(fallout.dude_obj(), Critter)
    fallout.attack_setup(Critter, victim)
    fallout.set_global_var(288, 1)
    stranger()
end

function North2()
    local v0 = 0
    Tot_Critter_A = fallout.random(1, 2)
    Tot_Critter_B = fallout.random(3, 5)
    group_angle = fallout.random(0, 5)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, -2)) or fallout.has_trait(0, fallout.dude_obj(), 0) then
        fallout.display_msg(fallout.message_str(112, 197))
        Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 7
        Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    else
        fallout.display_msg(fallout.message_str(112, 105))
        v0 = 1
        Outer_ring = 5
        Inner_ring = 2
    end
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
        if v0 then
            fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        else
            fallout.anim(Critter, 1000, fallout.random(0, 5))
        end
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Item = fallout.create_object_sid(18, 0, 0, -1)
            else
                Item = fallout.create_object_sid(8, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(4, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, (fallout.random(1, 20) * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Outer_ring = Outer_ring + 2
    Inner_ring = Inner_ring + 2
    while Tot_Critter_B do
        if fallout.random(0, 1) then
            Critter_type = 16777449
        else
            Critter_type = 16777432
        end
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if v0 then
            fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        else
            fallout.anim(Critter, 1000, fallout.random(0, 5))
        end
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Item = fallout.create_object_sid(18, 0, 0, -1)
            else
                Item = fallout.create_object_sid(8, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(4, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, fallout.random(1, 25) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function North3()
    fallout.display_msg(fallout.message_str(112, 106))
    Tot_Critter_A = fallout.random(4, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Critter_type = 16777227
    Critter_script = 12
    group_angle = fallout.random(0, 5)
    while Tot_Critter_A do
        Critter_direction = group_angle
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777229
    Critter_direction = fallout.random(0, 5)
    Outer_ring = 4
    Inner_ring = 2
    Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    Item = fallout.item_caps_adjust(Critter, fallout.random(40, 100) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    if fallout.random(0, 1) then
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    fallout.kill_critter(Critter, 61)
    fallout.set_global_var(288, 1)
    stranger()
end

function North4()
    fallout.display_msg(fallout.message_str(112, 107))
    Tot_Critter_A = fallout.random(2, 4)
    group_angle = fallout.random(0, 5)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Inner_ring = fallout.get_critter_stat(fallout.dude_obj(), 1) // 2
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 3 * 2) - 3)
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
    fallout.set_global_var(288, 1)
    stranger()
end

function North5()
    fallout.display_msg(fallout.message_str(112, 108))
    Tot_Critter_A = fallout.random(2, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 8
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Critter_script = 222
    while Tot_Critter_A do
        if fallout.random(0, 3) == 3 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
        end
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function North6()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function South1()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 131))
    Tot_Critter_A = fallout.random(6, 10)
    Outer_ring = 7
    Inner_ring = 10
    Critter_type = 16777244
    Critter_script = 941
    while Tot_Critter_A do
        Critter_direction = 1
        Place_critter()
        fallout.anim(Critter, 1000, 4)
        Tot_Critter_A = Tot_Critter_A - 1
    end
end

function South2()
    fallout.display_msg(fallout.message_str(112, 132))
    Tot_Critter_A = fallout.random(4, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_type = 16777227
    Critter_script = 12
    group_angle = fallout.random(0, 5)
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function South3()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function South4()
    fallout.display_msg(fallout.message_str(112, 143))
    Tot_Critter_A = fallout.random(2, 5)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_script = 749
    group_angle = fallout.random(0, 5)
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            Critter_type = 16777449
        else
            Critter_type = 16777432
        end
        Critter_direction = group_angle + (fallout.random(0, 1 * 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Item = fallout.create_object_sid(34, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
                if fallout.has_trait(0, fallout.dude_obj(), 40) then
                    Item = fallout.create_object_sid(34, 0, 0, -1)
                    fallout.add_obj_to_inven(Critter, Item)
                end
                Item = fallout.create_object_sid(10, 0, 0, -1)
            else
                Item = fallout.create_object_sid(29, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
                Item = fallout.create_object_sid(8, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(7, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, fallout.random(10, 30) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function South5()
    fallout.display_msg(fallout.message_str(112, 144))
    Tot_Critter_A = fallout.random(4, 8)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 7
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Critter_script = 943
    group_angle = fallout.random(0, 5)
    while Tot_Critter_A do
        if fallout.random(0, 4) == 4 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
        end
        Critter_direction = group_angle + (fallout.random(0, 2 * 2) - 2)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function South6()
    fallout.display_msg(fallout.message_str(112, 145))
    Tot_Critter_A = fallout.random(3, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    group_angle = fallout.random(0, 5)
    Critter_type = 16777227
    Critter_script = 12
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Shady1()
    fallout.display_msg(fallout.message_str(112, 146))
    Tot_Critter_A = 2
    Tot_Critter_B = fallout.random(2, 3)
    fallout.set_global_var(290, 0)
    fallout.set_global_var(291, 0)
    fallout.set_global_var(292, 0)
    fallout.set_global_var(289, Tot_Critter_B)
    fallout.set_global_var(288, 6)
    group_angle = fallout.random(0, 5)
    Outer_ring = 11
    Inner_ring = 8
    Critter_type = 16777255
    Critter_script = 713
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
        Item = fallout.item_caps_adjust(Critter, (fallout.random(1, 12) * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    Critter_type = 16777449
    Critter_script = 749
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
        Item = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, (fallout.random(1, 13) * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1)
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(Critter, victim)
    fallout.set_global_var(288, 1)
    stranger()
end

function Shady2()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                end
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Shady3()
    fallout.display_msg(fallout.message_str(112, 169))
    Scorpions_Killed = 1
    Tot_Critter_A = fallout.random(1, 3)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 4)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Shady4()
    if not(fallout.global_var(331)) then
        fallout.display_msg(fallout.message_str(112, 170))
    else
        fallout.display_msg(fallout.message_str(112, 305))
    end
    Tot_Critter_B = fallout.random(4, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 7
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    group_angle = dude_rot
    fallout.set_global_var(289, 0)
    if not(fallout.global_var(331)) then
        Critter_type = 16777246
        Critter_script = 243
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(71, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(29, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
        Item = fallout.create_object_sid(30, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 1 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
        Item = fallout.create_object_sid(34, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 4))
        Item = fallout.create_object_sid(47, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 1))
        Item = fallout.create_object_sid(81, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 3))
        Item = fallout.item_caps_adjust(Critter, fallout.random(25, 100) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        victim = Critter
    else
        fallout.set_global_var(289, 1)
    end
    Critter_type = 16777218
    Critter_script = 757
    while Tot_Critter_B do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if not(fallout.global_var(331)) then
            if fallout.random(0, 1) then
                Critter_direction = group_angle + (fallout.random(0, 4) - 2)
                while Critter_direction < 0 do
                    Critter_direction = Critter_direction + 6
                end
                if Critter_direction > 5 then
                    Critter_direction = Critter_direction % 6
                end
                fallout.anim(Critter, 1000, Critter_direction)
            else
                fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(victim)))
            end
        else
            fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        end
        Item = fallout.create_object_sid(10, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(34, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
        Item = fallout.item_caps_adjust(Critter, fallout.random(1, 6) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        Tot_Critter_B = Tot_Critter_B - 1
    end
end

function Shady5()
    fallout.display_msg(fallout.message_str(112, 171))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Critter_direction = dude_rot
    Critter_type = 16777246
    if fallout.random(0, 1) then
        Critter_type = 16777246
        Critter_script = 699
    else
        Critter_type = 16777218
        Critter_script = 749
    end
    Critter_script = -1
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(8, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(29, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, 1 + fallout.has_trait(0, fallout.dude_obj(), 40))
    Item = fallout.create_object_sid(7, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(81, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(8, 44) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    fallout.kill_critter(Critter, 61)
    Tot_Critter_A = fallout.random(4, 6)
    if time.is_day() then
        Outer_ring = 6
        Inner_ring = 4
    else
        Outer_ring = 4
        Inner_ring = 3
    end
    Critter_type = 16777284
    Critter_script = 735
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Shady6()
    local v0 = 2
    fallout.display_msg(fallout.message_str(112, 172))
    Critter_direction = fallout.random(0, 5)
    money = fallout.create_object_sid(41, 0, 0, -1)
    Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, 4)
    Item = fallout.create_object_sid(71, 0, 0, -1)
    fallout.critter_attempt_placement(Item, Critter_tile, 0)
    if fallout.get_critter_stat(fallout.dude_obj(), 6) == 8 then
        money = 0
        Item = fallout.create_object_sid(71, 0, 0, -1)
        fallout.critter_attempt_placement(Item, Critter_tile, 0)
        Item = fallout.create_object_sid(29, 0, 0, -1)
        fallout.critter_attempt_placement(Item, Critter_tile, 0)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(29, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
        end
        Item = fallout.create_object_sid(46, 0, 0, -1)
        fallout.critter_attempt_placement(Item, Critter_tile, 0)
        fallout.add_mult_objs_to_inven(Item, money, 6 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) > 8 then
            Item = fallout.create_object_sid(71, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                v0 = 4
            end
            while v0 do
                Item = fallout.create_object_sid(29, 0, 0, -1)
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
                v0 = v0 - 1
            end
            Item = fallout.create_object_sid(46, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Item, money, 122 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
            Item = fallout.create_object_sid(8, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
        else
            Item = fallout.create_object_sid(71, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
            Item = fallout.create_object_sid(46, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Item, money, 4 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
        end
    end
end

function Raider1()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 173))
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Tot_Critter_A = fallout.random(5, 7)
    Tot_Critter_B = fallout.random(2, 3)
    group_angle = fallout.random(0, 5)
    fallout.set_external_var("random_seed_1", Tot_Critter_A)
    fallout.set_external_var("random_seed_2", 0)
    fallout.set_external_var("random_seed_3", 0)
    v0 = fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(7, 12))
    Item = fallout.create_object_sid(33554959, v0, 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 0), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 1), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 2), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 3), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 4), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 5), 0, -1)
    if time.is_night() then
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, group_angle, 5)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
    end
    Critter_type = 16777244
    Critter_script = -1
    Critter_direction = fallout.random(0, 5)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 61)
    Critter_type = 16777244
    Critter_script = -1
    Critter_direction = fallout.random(0, 5)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 61)
    Critter_script = 750
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            Critter_type = 16777449
        else
            Critter_type = 16777432
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
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Item = fallout.create_object_sid(34, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
                Item = fallout.create_object_sid(10, 0, 0, -1)
            else
                Item = fallout.create_object_sid(29, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
                Item = fallout.create_object_sid(8, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(7, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    if fallout.random(0, 1) then
        Critter_type = 16777449
    else
        Critter_type = 16777432
    end
    Critter_script = -1
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
    Item = fallout.create_object_sid(1, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    fallout.kill_critter(Critter, 61)
    Critter_type = 16777219
    Critter_script = 755
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
        Item = fallout.create_object_sid(10, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(34, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            Item = fallout.create_object_sid(34, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(victim, Critter)
    Critter_type = 16777219
    Critter_script = -1
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
    Item = fallout.create_object_sid(2, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(10, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(34, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    fallout.kill_critter(Critter, 61)
    Critter_type = 16777229
    Critter_script = 753
    Critter_direction = fallout.random(0, 5)
    Place_critter()
    fallout.critter_dmg(Critter, 5, 0)
    Item = fallout.item_caps_adjust(Critter, fallout.random(100, 300) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    if fallout.random(1, 10) > 6 then
        Item = fallout.create_object_sid(47, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(1, 10) > 6 then
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(1, 10) > 6 then
        Item = fallout.create_object_sid(78, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    if fallout.random(1, 10) > 6 then
        Item = fallout.create_object_sid(84, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Raider2()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                end
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Raider3()
    fallout.display_msg(fallout.message_str(112, 196))
    Tot_Critter_A = fallout.random(3, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = fallout.random(4, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Raider4()
    fallout.display_msg(fallout.message_str(112, 197))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    Tot_Critter_A = fallout.random(4, 6)
    group_angle = fallout.random(0, 5)
    Critter_script = 749
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Critter_type = 16777449
            else
                Critter_type = 16777432
            end
        else
            Critter_type = 16777319
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
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Item = fallout.create_object_sid(10, 0, 0, -1)
            else
                Item = fallout.create_object_sid(18, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(8, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(124, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Raider5()
    fallout.display_msg(fallout.message_str(112, 198))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_direction = dude_rot
    Critter_type = 16777254
    Critter_script = 700
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(4, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.random(0, 1) then
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(10, 0, 0, -1)
        else
            Item = fallout.create_object_sid(18, 0, 0, -1)
        end
    else
        Item = fallout.create_object_sid(8, 0, 0, -1)
    end
    fallout.add_obj_to_inven(Critter, Item)
    if fallout.random(0, 1) then
        Item = fallout.item_caps_adjust(Critter, fallout.random(5, 10) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    end
end

function Raider6()
    fallout.display_msg(fallout.message_str(112, 199))
    Tot_Critter_A = fallout.random(3, 5)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_script = -1
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Critter_type = 16777449
            else
                Critter_type = 16777432
            end
        else
            Critter_type = 16777319
        end
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        fallout.kill_critter(Critter, 61)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777252
    Critter_direction = fallout.random(0, 5)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    fallout.kill_critter(Critter, 61)
end

function Junk1()
    fallout.display_msg(fallout.message_str(112, 200))
    Tot_Critter_A = fallout.random(3, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 4)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Junk2()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                end
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Junk3()
    fallout.display_msg(fallout.message_str(112, 223))
    Tot_Critter_A = fallout.random(4, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    group_angle = fallout.random(0, 5)
    Critter_type = 16777379
    Critter_script = 693
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Junk4()
    fallout.display_msg(fallout.message_str(112, 224))
    Tot_Critter_A = fallout.random(2, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_type = 16777452
    Critter_script = 437
    group_angle = fallout.random(0, 5)
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        if fallout.random(1, 3) == 1 then
            fallout.anim(Critter, 1000, fallout.random(0, 5))
        else
            fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        end
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(10, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            Item = fallout.create_object_sid(34, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Item = fallout.create_object_sid(100, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
end

function Junk5()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 225))
    Tot_Critter_A = fallout.random(1, 3)
    Tot_Critter_B = fallout.random(2, 12)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    group_angle = fallout.random(0, 5)
    v0 = fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(7, 12))
    Item = fallout.create_object_sid(33554959, v0, 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 0), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 1), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 2), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 3), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 4), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 5), 0, -1)
    v0 = fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(7, 12))
    Item = fallout.create_object_sid(33554960, v0, 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 0), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 1), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 2), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 3), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 4), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 5), 0, -1)
    Critter_type = 16777245
    Critter_script = 752
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Item = fallout.item_caps_adjust(Critter, fallout.random(50, 150) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        Item = fallout.create_object_sid(30, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 4))
        Item = fallout.create_object_sid(29, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 4))
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 4))
        Item = fallout.create_object_sid(71, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(4, 8))
        Item = fallout.create_object_sid(127, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 2))
        Item = fallout.create_object_sid(93, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 2))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777243
    Critter_script = 755
    while Tot_Critter_B do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(18, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            Item = fallout.create_object_sid(31, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
            continue
        end
        Item = fallout.create_object_sid(10, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(34, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 1)
        Tot_Critter_B = Tot_Critter_B - 1
    end
end

function Junk6()
    local v0 = 2
    local v1 = 0
    fallout.display_msg(fallout.message_str(112, 172))
    v1 = fallout.create_object_sid(41, 0, 0, -1)
    Critter_direction = fallout.random(0, 5)
    Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, 4)
    if fallout.get_critter_stat(fallout.dude_obj(), 6) < 3 then
        Item = fallout.create_object_sid(71, 0, 0, -1)
        fallout.critter_attempt_placement(Item, Critter_tile, 0)
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) == 8 then
            Item = fallout.create_object_sid(71, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
            Item = fallout.create_object_sid(29, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                Item = fallout.create_object_sid(29, 0, 0, -1)
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
            end
            Item = fallout.create_object_sid(46, 0, 0, -1)
            fallout.critter_attempt_placement(Item, Critter_tile, 0)
            fallout.add_mult_objs_to_inven(Item, v1, 6 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 6) > 8 then
                Item = fallout.create_object_sid(71, 0, 0, -1)
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
                if fallout.has_trait(0, fallout.dude_obj(), 40) then
                    v0 = 4
                end
                while v0 do
                    Item = fallout.create_object_sid(29, 0, 0, -1)
                    fallout.critter_attempt_placement(Item, Critter_tile, 0)
                    v0 = v0 - 1
                end
                Item = fallout.create_object_sid(46, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Item, v1, 122 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
                Item = fallout.create_object_sid(8, 0, 0, -1)
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
            else
                Item = fallout.create_object_sid(71, 0, 0, -1)
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
                Item = fallout.create_object_sid(46, 0, 0, -1)
                fallout.add_mult_objs_to_inven(Item, v1, 4 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
                fallout.critter_attempt_placement(Item, Critter_tile, 0)
            end
        end
    end
end

function Hub1()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6) + 2
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
            else
                v1 = fallout.random(2, 3)
            end
            fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
            fallout.critter_injure(fallout.dude_obj(), 2)
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Hub2()
    fallout.display_msg(fallout.message_str(112, 133))
    Tot_Critter_A = fallout.random(3, 6)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_script = 749
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Critter_type = 16777254
            else
                Critter_type = 16777235
            end
        else
            Critter_type = 16777243
        end
        Critter_direction = fallout.random(3, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 2))
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            if fallout.random(0, 1) then
                Item = fallout.create_object_sid(9, 0, 0, -1)
            else
                Item = fallout.create_object_sid(10, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(8, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, fallout.random(10, 30) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        if fallout.random(0, 3) == 3 then
            Item = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 3) == 3 then
            Item = fallout.create_object_sid(87, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 3) == 3 then
            Item = fallout.create_object_sid(81, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 3) == 3 then
            Item = fallout.create_object_sid(103, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Hub3()
    fallout.display_msg(fallout.message_str(112, 134))
    Tot_Critter_A = fallout.random(2, 3)
    Tot_Critter_B = fallout.random(1, 2)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 4)
        Place_critter()
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777382
    while Tot_Critter_B do
        Critter_direction = fallout.random(0, 4)
        Place_critter()
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Hub4()
    fallout.display_msg(fallout.message_str(112, 135))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Tot_Critter_A = fallout.random(4, 6)
    Critter_script = 573
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        if fallout.random(0, 1) then
            Critter_type = 16777243
        else
            Critter_type = 16777253
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(3, 5))
        Item = fallout.item_caps_adjust(Critter, fallout.random(20, 50) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(9, 0, 0, -1)
        else
            Item = fallout.create_object_sid(18, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
end

function Hub5()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 136))
    v0 = fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(7, 9))
    Item = fallout.create_object_sid(33554959, v0, 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 0), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 1), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 2), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 3), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 4), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 5), 0, -1)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Tot_Critter_A = fallout.random(5, 8)
    Critter_script = 755
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        if fallout.random(0, 1) then
            Critter_type = 16777243
        else
            Critter_type = 16777253
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(3, 5))
        Item = fallout.item_caps_adjust(Critter, fallout.random(20, 50) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(9, 0, 0, -1)
        else
            Item = fallout.create_object_sid(18, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Critter_type = 16777229
    Critter_script = 752
    Place_critter()
    Item = fallout.item_caps_adjust(Critter, fallout.random(100, 300) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    Item = fallout.create_object_sid(71, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 4))
    Item = fallout.create_object_sid(81, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 4))
    Item = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 2))
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 1))
    Item = fallout.create_object_sid(29, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 3))
    Item = fallout.create_object_sid(30, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 3))
    Item = fallout.create_object_sid(35, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 2))
    Item = fallout.create_object_sid(36, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 2))
end

function Hub6()
    fallout.display_msg(fallout.message_str(112, 137))
    Tot_Critter_A = fallout.random(2, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Critter_type = 16777244
    Critter_script = 34
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777386
    Critter_script = -1
    Place_critter()
end

function Necrop1()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                end
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Necrop2()
    fallout.display_msg(fallout.message_str(112, 126))
    Tot_Critter_A = fallout.random(2, 4)
    Tot_Critter_B = fallout.random(2, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    group_angle = fallout.random(0, 5)
    Critter_script = 12
    Dude_tile = Dude_tile + (200 * (fallout.random(0, 4) - 2))
    while Tot_Critter_A do
        if fallout.random(0, 3) == 3 then
            Critter_type = 16777382
        else
            Critter_type = 16777227
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
    victim = Critter
    Critter_script = 222
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
        if fallout.random(0, 2) == 2 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
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
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(Critter, victim)
    fallout.set_global_var(288, 1)
    stranger()
end

function Necrop3()
    fallout.display_msg(fallout.message_str(112, 127))
    Tot_Critter_A = fallout.random(2, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    group_angle = fallout.random(0, 5)
    Critter_type = 16777230
    Critter_script = 953
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
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
    fallout.set_global_var(288, 1)
    stranger()
end

function Necrop4()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    fallout.display_msg(fallout.message_str(112, 128))
    Item = fallout.create_object_sid(33554653, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 8)), 0, -1)
    Item = fallout.create_object_sid(33554654, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 8)), 0, -1)
    Item = fallout.create_object_sid(33554747, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 8)), 0, -1)
    if fallout.random(0, 3) == 3 then
        v1 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), fallout.random(0, 5))
        v2 = fallout.random(0, 4)
        if v2 == 0 then
            v0 = fallout.create_object_sid(29, v1, 0, -1)
        else
            if v2 == 1 then
                v0 = fallout.create_object_sid(30, v1, 0, -1)
            else
                if v2 == 2 then
                    v0 = fallout.create_object_sid(34, v1, 0, -1)
                else
                    if v2 == 3 then
                        v0 = fallout.create_object_sid(31, v1, 0, -1)
                    else
                        if v2 == 4 then
                            v0 = fallout.create_object_sid(111, v1, 0, -1)
                        end
                    end
                end
            end
        end
    end
    v1 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), fallout.random(3, 5))
    v0 = fallout.create_object_sid(33554541, v1, 0, -1)
    v1 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), fallout.random(3, 5))
    v0 = fallout.create_object_sid(33554437, v1, 0, -1)
    v1 = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), fallout.random(3, 5))
    v0 = fallout.create_object_sid(33554524, v1, 0, -1)
end

function Necrop5()
    fallout.display_msg(fallout.message_str(112, 127))
    Tot_Critter_A = fallout.random(1, 3)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    group_angle = fallout.random(0, 5)
    Critter_type = 16777230
    Critter_script = 953
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
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
    fallout.set_global_var(288, 1)
    stranger()
end

function Necrop6()
    local v0 = 0
    local v1 = 0
    fallout.display_msg(fallout.message_str(112, 130))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    if fallout.random(0, 1) then
        Critter_type = 16777254
    else
        Critter_type = 16777253
    end
    Critter_script = -1
    Critter_direction = fallout.random(0, 5)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.random(0, 5))
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.item_caps_adjust(v0, fallout.random(50, 100) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(90, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(10, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(1, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(127, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    if fallout.random(0, 3) == 3 then
        v1 = fallout.create_object_sid(51, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v1)
    end
    v1 = fallout.create_object_sid(106, 0, 0, -1)
    fallout.add_obj_to_inven(v0, v1)
    v1 = fallout.item_caps_adjust(v0, fallout.random(3, 9) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
    fallout.kill_critter(Critter, 61)
end

function Steel1()
    fallout.display_msg(fallout.message_str(112, 226))
    Tot_Critter_A = 2
    Tot_Critter_B = 6
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 8
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    group_angle = fallout.random(0, 5)
    fallout.set_external_var("random_seed_1", 0)
    Critter_script = 759
    if fallout.random(0, 1) then
        Critter_type = 16777491
    else
        Critter_type = 16777494
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
    Item = fallout.create_object_sid(28, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    victim = Critter
    Critter_script = 758
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            Critter_type = 16777490
        else
            Critter_type = 16777493
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
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(1, 3) == 1 then
            Item = fallout.create_object_sid(13, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            Item = fallout.create_object_sid(37, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 3))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777403
    Critter_script = 850
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
        if fallout.random(1, 3) == 1 then
            Item = fallout.create_object_sid(11, 0, 0, -1)
        else
            Item = fallout.create_object_sid(12, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(1, 2) == 1 then
            Item = fallout.create_object_sid(13, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            Item = fallout.create_object_sid(37, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 3))
        end
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(victim, Critter)
    fallout.set_global_var(288, 3)
    stranger()
end

function Steel2()
    fallout.display_msg(fallout.message_str(112, 227))
    Tot_Critter_A = fallout.random(6, 10)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 7
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = fallout.random(3, 5)
        Place_critter()
        if fallout.random(1, 3) == 1 then
            fallout.anim(Critter, 1000, fallout.random(0, 5))
            continue
        end
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Steel3()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 109))
            else
                fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
            end
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
                if v0 == 1 then
                    fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
                else
                    fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                v1 = fallout.random(1, 2)
                if v0 == 1 then
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 117))
                    else
                        fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                    end
                else
                    if v1 == 1 then
                        fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                    else
                        fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                    end
                    fallout.critter_injure(fallout.dude_obj(), 2)
                end
            end
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Steel4()
    fallout.display_msg(fallout.message_str(112, 250))
    Tot_Critter_A = fallout.random(5, 7)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    group_angle = dude_rot
    fallout.set_external_var("random_seed_1", 0)
    if fallout.random(0, 1) then
        Critter_type = 16777491
    else
        Critter_type = 16777494
    end
    Critter_script = 759
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
    Item = fallout.create_object_sid(28, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Critter_script = 758
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            Critter_type = 16777490
        else
            Critter_type = 16777493
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
        if fallout.random(1, 3) == 1 then
            Item = fallout.create_object_sid(32, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
end

function Steel5()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 251))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    v0 = fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(7, 12))
    Item = fallout.create_object_sid(33554959, v0, 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 0), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 1), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 2), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 3), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 4), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 5), 0, -1)
    v0 = fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(7, 12))
    Item = fallout.create_object_sid(33554960, v0, 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 0), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 1), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 2), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 3), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 4), 0, -1)
    Item = fallout.create_object_sid(33554499, fallout.tile_num_in_direction(v0, 1, 5), 0, -1)
    if time.is_night() then
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, fallout.random(0, 5), 5)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
        Critter = fallout.create_object_sid(33554433, 0, 0, -1)
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, fallout.random(0, 5), 5)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
    end
    Tot_Critter_A = fallout.random(1, 2)
    while Tot_Critter_A do
        Critter_type = 16777244
        Critter_script = 34
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Tot_Critter_A = fallout.random(2, 4)
    Critter_type = 16777245
    Critter_script = 752
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(71, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(29, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(30, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, 1 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(34, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, 2 * (fallout.has_trait(0, fallout.dude_obj(), 40) + 1))
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 4))
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(47, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 1))
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(81, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(0, 3))
        end
        Item = fallout.item_caps_adjust(Critter, fallout.random(12, 32) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Tot_Critter_B = fallout.random(6, 8)
    Critter_script = 755
    while Tot_Critter_B do
        Critter_direction = fallout.random(0, 5)
        if fallout.random(0, 1) then
            Critter_type = 16777243
        else
            Critter_type = 16777238
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(0, 5))
        Item = fallout.item_caps_adjust(Critter, fallout.random(1, 15) * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1))
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(95, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                Item = fallout.create_object_sid(95, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            Item = fallout.create_object_sid(94, 0, 0, -1)
        else
            Item = fallout.create_object_sid(34, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                Item = fallout.create_object_sid(34, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            Item = fallout.create_object_sid(10, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 1) then
            if fallout.random(0, 2) == 0 then
                Item = fallout.create_object_sid(125, 0, 0, -1)
            else
                Item = fallout.create_object_sid(124, 0, 0, -1)
            end
            fallout.add_obj_to_inven(Critter, Item)
        end
        Tot_Critter_B = Tot_Critter_B - 1
    end
end

function Steel6()
    fallout.display_msg(fallout.message_str(112, 252))
    Tot_Critter_A = fallout.random(3, 4)
    Tot_Critter_B = fallout.random(12, 15)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 7
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    group_angle = fallout.random(0, 5)
    fallout.set_external_var("random_seed_1", 0)
    Critter_script = 759
    if fallout.random(0, 1) then
        Critter_type = 16777491
    else
        Critter_type = 16777494
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
    Item = fallout.create_object_sid(28, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Critter_script = 758
    while Tot_Critter_A do
        if fallout.random(0, 1) then
            Critter_type = 16777490
        else
            Critter_type = 16777493
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
        if fallout.random(0, 3) == 1 then
            Item = fallout.create_object_sid(13, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            Item = fallout.create_object_sid(37, 0, 0, -1)
            fallout.add_mult_objs_to_inven(Critter, Item, fallout.random(1, 3))
            continue
        end
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    victim = Critter
    Critter_type = 16777254
    Critter_script = 749
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
        Item = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) then
            Item = fallout.create_object_sid(30, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            if fallout.has_trait(0, fallout.dude_obj(), 40) then
                Item = fallout.create_object_sid(30, 0, 0, -1)
                fallout.add_obj_to_inven(Critter, Item)
            end
            Item = fallout.create_object_sid(8, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(40, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.attack_setup(Critter, victim)
    fallout.set_global_var(288, 3)
    stranger()
end

function Vats1()
    fallout.display_msg(fallout.message_str(112, 253))
    fallout.radiation_inc(fallout.dude_obj(), fallout.random(15, 30))
    Tot_Critter_A = fallout.random(3, 4)
    Tot_Critter_B = 1
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if fallout.random(0, 1) == 1 then
            if fallout.random(0, 3) == 0 then
                Item = fallout.create_object_sid(11, 0, 0, -1)
            else
                Item = fallout.create_object_sid(12, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(234, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777241
    Critter_script = 854
    while Tot_Critter_B do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_B = Tot_Critter_B - 1
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Vats2()
    fallout.display_msg(fallout.message_str(112, 254))
    if fallout.random(0, 1) then
        Critter_type = 16777259
        Critter_script = 953
    else
        Critter_type = 16777261
        Critter_script = 953
    end
    Tot_Critter_A = fallout.random(3, 5)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Vats3()
    fallout.display_msg(fallout.message_str(112, 306))
    Tot_Critter_A = fallout.random(1, 2)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    Critter_type = 16777261
    Critter_script = 953
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777259
    Critter_script = 953
    Tot_Critter_A = 1
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    Tot_Critter_A = fallout.random(2, 3)
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777241
    Critter_script = 854
    Critter_direction = fallout.random(0, 2)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(118, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(38, 0, 0, -1)
    fallout.add_mult_objs_to_inven(Critter, Item, fallout.has_trait(0, fallout.dude_obj(), 40) + 2)
    if not(fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 100)) then
        Item = fallout.create_object_sid(100, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Vats4()
    fallout.display_msg(fallout.message_str(112, 256))
    Tot_Critter_A = fallout.random(3, 4)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 7
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(3, 4))
        if fallout.random(0, 1) == 1 then
            if fallout.random(0, 1) == 1 then
                Item = fallout.create_object_sid(11, 0, 0, -1)
            else
                Item = fallout.create_object_sid(12, 0, 0, -1)
            end
        else
            Item = fallout.create_object_sid(234, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    Critter_type = 16777241
    Critter_script = 854
    Tot_Critter_B = 1
    while Tot_Critter_B do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.random(3, 4))
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_B = Tot_Critter_B - 1
    end
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    Critter_type = 16777261
    Critter_script = 953
    Critter_direction = fallout.random(0, 2)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.random(3, 4))
    fallout.set_global_var(288, 3)
    stranger()
end

function Vats5()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6)
    Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
    if fallout.is_success(Skill_roll) then
        if v0 == 1 then
            fallout.display_msg(fallout.message_str(112, 109))
        else
            fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
        end
    else
        if fallout.is_critical(Skill_roll) then
            v1 = fallout.random(2, 4)
            if v0 == 1 then
                fallout.display_msg(fallout.message_str(112, 112) .. v1 .. fallout.message_str(112, 113))
            else
                fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
            end
            fallout.critter_injure(fallout.dude_obj(), 2)
        else
            v1 = fallout.random(1, 2)
            if v0 == 1 then
                if v1 == 1 then
                    fallout.display_msg(fallout.message_str(112, 117))
                else
                    fallout.display_msg(fallout.message_str(112, 118) .. v1 .. fallout.message_str(112, 119))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            else
                if v1 == 1 then
                    fallout.display_msg(fallout.message_str(112, 120) .. v0 .. fallout.message_str(112, 121))
                else
                    fallout.display_msg(fallout.message_str(112, 122) .. v0 .. fallout.message_str(112, 123) .. v1 .. fallout.message_str(112, 124))
                end
                fallout.critter_injure(fallout.dude_obj(), 2)
            end
        end
    end
    v0 = v0 * 3600
    fallout.game_time_advance(fallout.game_ticks(v0))
end

function Vats6()
    fallout.display_msg(fallout.message_str(112, 279))
    Item = fallout.create_object_sid(33554804, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(8, 10)), 0, -1)
    Item = fallout.create_object_sid(33554653, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 9)), 0, -1)
    Item = fallout.create_object_sid(33554654, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 9)), 0, -1)
    Item = fallout.create_object_sid(33554747, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 9)), 0, -1)
    Item = fallout.create_object_sid(33555207, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(5, 9)), 0, -1)
    if time.is_night() then
        Item = fallout.create_object_sid(33554433, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(8, 10)), 0, -1)
        if fallout.random(0, 1) then
            Item = fallout.create_object_sid(33554433, fallout.tile_num_in_direction(Dude_tile + fallout.random(0, 8) - 4, fallout.random(0, 5), fallout.random(8, 10)), 0, -1)
        end
    end
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 3
    group_angle = fallout.random(0, 5)
    Critter_type = 16777403
    Critter_script = 850
    Tot_Critter_A = fallout.random(2, 3)
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
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
    Critter_type = 16777241
    Critter_script = 854
    Critter_direction = fallout.random(0, 2)
    Critter_direction = group_angle + (fallout.random(0, 2) - 1)
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(12, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(35, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    Critter_type = 16777261
    Critter_script = 953
    Tot_Critter_A = 2
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
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 2) - 1)
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
    fallout.set_global_var(288, 3)
    stranger()
end

function Glow1()
    local v0 = 3
    fallout.display_msg(fallout.message_str(112, 280))
    Tot_Critter_A = fallout.random(2, 3)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if fallout.random(0, 1) then
        Critter_type = 16777241
        Critter_script = 854
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(118, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.has_trait(0, fallout.dude_obj(), 40) then
            v0 = 5
        end
        while v0 do
            Item = fallout.create_object_sid(38, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
            v0 = v0 - 1
        end
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Glow2()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 281))
    v0 = fallout.game_time_hour()
    Tot_Critter_A = fallout.random(3, 5)
    if (v0 > 600) and (v0 < 1900) then
        Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
        Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    else
        Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
        Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    end
    Critter_type = 16777261
    Critter_script = 953
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if fallout.random(0, 1) then
        Critter_direction = fallout.random(0, 4)
        Critter_type = 16777259
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Glow3()
    fallout.display_msg(fallout.message_str(112, 282))
    Tot_Critter_A = fallout.random(4, 8)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 8
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Critter_type = 16777227
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 4)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(92, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Glow4()
    fallout.display_msg(fallout.message_str(112, 283))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 4
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    Critter_type = 16777261
    Critter_script = 953
    Tot_Critter_A = 1
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 2)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.radiation_inc(fallout.dude_obj(), fallout.random(15, 30))
end

function Glow5()
    fallout.display_msg(fallout.message_str(112, 284))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    group_angle = fallout.random(0, 5)
    Tot_Critter_A = 1 + fallout.random(0, 1)
    Critter_type = 16777261
    Critter_script = 953
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if fallout.random(0, 1) then
        Critter_type = 16777259
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
    end
end

function Glow6()
    fallout.display_msg(fallout.message_str(112, 285))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 2
    Critter_script = 953
    Critter_type = 16777259
    Critter_direction = fallout.random(2, 5)
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    if fallout.random(0, 1) then
        Critter_type = 16777261
        Critter_direction = fallout.random(1, 4)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Death1()
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 8
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 8
    if fallout.global_var(100) ~= 2 then
        fallout.display_msg(fallout.message_str(112, 286))
        Critter_direction = fallout.random(0, 5)
        Critter_type = 16777267
        Critter_script = 642
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    else
        fallout.display_msg(fallout.message_str(112, 287))
        Critter_type = 16777227
        Critter_script = 12
        Tot_Critter_A = fallout.random(3, 5)
        while Tot_Critter_A do
            Critter_direction = fallout.random(0, 5)
            Place_critter()
            fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
            Tot_Critter_A = Tot_Critter_A - 1
        end
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Death2()
    fallout.display_msg(fallout.message_str(112, 288))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 3
    Critter_direction = fallout.random(0, 5)
    Critter_type = 16777259
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    fallout.set_global_var(288, 2)
    stranger()
end

function Death3()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 6) + 2
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 126) then
        fallout.display_msg(fallout.message_str(112, 125))
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 126))
    else
        Skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 17, 20 * fallout.has_trait(0, fallout.dude_obj(), 16))
        if fallout.is_success(Skill_roll) then
            fallout.display_msg(fallout.message_str(112, 110) .. v0 .. fallout.message_str(112, 111))
        else
            if fallout.is_critical(Skill_roll) then
                v1 = fallout.random(2, 4)
            else
                v1 = fallout.random(2, 3)
            end
            fallout.display_msg(fallout.message_str(112, 114) .. v0 .. fallout.message_str(112, 115) .. v1 .. fallout.message_str(112, 116))
            fallout.critter_injure(fallout.dude_obj(), 2)
        end
        fallout.critter_dmg(fallout.dude_obj(), v1, 0)
        v0 = v0 * 3600
        fallout.game_time_advance(fallout.game_ticks(v0))
    end
end

function Death4()
    fallout.display_msg(fallout.message_str(112, 299))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Tot_Critter_A = fallout.random(2, 4)
    group_angle = fallout.random(0, 5)
    Critter_type = 16777227
    Critter_script = 12
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 4) - 2)
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
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Death5()
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 10
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 3) + 10
    if 1 == 1 then
        fallout.display_msg(fallout.message_str(112, 300))
        Critter_direction = dude_rot + (fallout.random(0, 2) - 1)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Critter_type = 16777254
        Critter_script = 703
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.item_caps_adjust(Critter, (fallout.random(20, 60) * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1)
        Item = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(31, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(111, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(9, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(1, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(90, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        Item = fallout.create_object_sid(125, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        fallout.set_global_var(125, 1)
    else
        fallout.display_msg(fallout.message_str(112, 301))
        Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 7
        Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
        Critter_direction = fallout.random(0, 5)
        if fallout.random(0, 3) == 3 then
            Critter_type = 16777226
        else
            Critter_type = 16777378
        end
        Critter_script = 222
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Death6()
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 5
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    if fallout.global_var(100) ~= 2 then
        fallout.display_msg(fallout.message_str(112, 302))
        Critter_direction = fallout.random(0, 5)
        Critter_type = 16777267
        Critter_script = 642
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    else
        fallout.display_msg(fallout.message_str(112, 303))
        Critter_type = 16777227
        Critter_script = 12
        Tot_Critter_A = fallout.random(3, 5)
        group_angle = fallout.random(0, 5)
        while Tot_Critter_A do
            Critter_direction = group_angle + (fallout.random(0, 4) - 2)
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
    end
    fallout.set_global_var(288, 2)
    stranger()
end

function Bone1()
    fallout.display_msg(fallout.message_str(112, 307))
    Tot_Critter_A = fallout.random(2, 3)
    group_angle = fallout.random(0, 5)
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Critter_type = 16777403
    Critter_script = 850
    while Tot_Critter_A do
        Critter_direction = group_angle + (fallout.random(0, 4) - 2)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        if fallout.random(1, 4) == 1 then
            Item = fallout.create_object_sid(11, 0, 0, -1)
        else
            Item = fallout.create_object_sid(12, 0, 0, -1)
        end
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(1, 5) == 1 then
            Item = fallout.create_object_sid(13, 0, 0, -1)
            fallout.add_obj_to_inven(Critter, Item)
        end
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(5, 20) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
        Tot_Critter_A = Tot_Critter_A - 1
    end
    if fallout.random(0, 1) then
        Critter_type = 16777241
        Critter_script = 854
        Critter_direction = group_angle + (fallout.random(0, 4) - 2)
        while Critter_direction < 0 do
            Critter_direction = Critter_direction + 6
        end
        if Critter_direction > 5 then
            Critter_direction = Critter_direction % 6
        end
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Item = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(Critter, Item)
        if fallout.random(0, 2) == 0 then
            Item = fallout.item_caps_adjust(Critter, fallout.random(5, 20) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
        end
    end
    fallout.set_global_var(288, 3)
    stranger()
end

function Bone2()
    local v0 = 0
    fallout.display_msg(fallout.message_str(112, 308))
    group_angle = fallout.random(0, 5)
    if time.is_night() and fallout.random(0, 1) then
        Critter = fallout.create_object_sid(33555044, 0, 0, -1)
        Critter_tile = fallout.tile_num_in_direction(Dude_tile, group_angle, 4)
        fallout.critter_attempt_placement(Critter, Critter_tile, 0)
        Critter = fallout.create_object_sid(33555044, 0, 0, -1)
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
    Dude_tile = Dude_tile + (fallout.random(0, 4) - 2 + ((fallout.random(0, 2) - 1) * 200))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 4
    Tot_Critter_A = fallout.random(3, 5)
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
    fallout.set_global_var(288, 2)
    stranger()
end

function Bone3()
    fallout.display_msg(fallout.message_str(112, 309))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Tot_Critter_A = fallout.random(3, 7)
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
    Critter_direction = group_angle + fallout.random(0, 2 * 2) - 2
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(1, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(25, 100) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    fallout.set_global_var(288, 1)
    stranger()
end

function Bone4()
    fallout.display_msg(fallout.message_str(112, 310))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Tot_Critter_A = fallout.random(2, 5)
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
    Critter_direction = group_angle + fallout.random(0, 2 * 2) - 2
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
    Item = fallout.item_caps_adjust(Critter, fallout.random(25, 100) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    fallout.set_global_var(288, 1)
    stranger()
end

function Bone5()
    fallout.display_msg(fallout.message_str(112, 311))
    Outer_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 6
    Inner_ring = (fallout.get_critter_stat(fallout.dude_obj(), 1) // 2) + 2
    Tot_Critter_A = fallout.random(1, 3)
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
    Critter_direction = group_angle + fallout.random(0, 2 * 2) - 2
    while Critter_direction < 0 do
        Critter_direction = Critter_direction + 6
    end
    if Critter_direction > 5 then
        Critter_direction = Critter_direction % 6
    end
    Place_critter()
    fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
    Item = fallout.create_object_sid(1, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.create_object_sid(47, 0, 0, -1)
    fallout.add_obj_to_inven(Critter, Item)
    Item = fallout.item_caps_adjust(Critter, fallout.random(25, 100) * ((2 * fallout.has_trait(0, fallout.dude_obj(), 20)) + 1))
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
    fallout.set_global_var(288, 2)
    stranger()
end

function Bone6()
    fallout.display_msg(fallout.message_str(112, 313))
    Tot_Critter_A = fallout.random(4, 6)
    if time.is_day() then
        Outer_ring = 6
        Inner_ring = 3
    else
        Outer_ring = 4
        Inner_ring = 3
    end
    Critter_type = 16777284
    Critter_script = 735
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Place_critter()
        fallout.anim(Critter, 1000, fallout.rotation_to_tile(fallout.tile_num(Critter), fallout.tile_num(fallout.dude_obj())))
        Tot_Critter_A = Tot_Critter_A - 1
    end
    fallout.set_global_var(288, 1)
    stranger()
end

function Scenes()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0
    Tot_Critter_A = fallout.random(3, 14)
    v4 = -1
    while Tot_Critter_A do
        Critter_direction = fallout.random(0, 5)
        Range = fallout.random(4, 28)
        Place_Holder = Range
        v0 = fallout.tile_num_in_direction(Dude_tile, Critter_direction, Place_Holder)
        Critter_direction = fallout.random(0, 5)
        v0 = fallout.tile_num_in_direction(Dude_tile, Critter_direction, Place_Holder)
        v0 = v0 + (fallout.random(0, 2) - 1)
        Critter_direction = fallout.random(0, 5)
        v0 = fallout.tile_num_in_direction(Dude_tile, Critter_direction, Place_Holder)
        v0 = v0 + (fallout.random(0, 2) - 1)
        Critter_direction = fallout.random(0, 5)
        v0 = fallout.tile_num_in_direction(Dude_tile, Critter_direction, Place_Holder)
        v2 = fallout.random(0, 9)
        while v4 == v2 do
            v2 = fallout.random(0, 9)
        end
        fallout.debug_msg(fallout.message_str(112, 304) .. v2 .. "")
        if v2 == 0 then
            v3 = fallout.random(1, 6)
            if v3 == 1 then
                Item = fallout.create_object_sid(33554517, 0, 0, -1)
            else
                if v3 == 2 then
                    if fallout.random(1, 4) == 1 then
                        Item = fallout.create_object_sid(33554749, 0, 0, -1)
                    else
                        Item = fallout.create_object_sid(33554496, 0, 0, -1)
                    end
                else
                    if v3 == 3 then
                        Item = fallout.create_object_sid(33554555, 0, 0, -1)
                    else
                        if v3 == 4 then
                            Item = fallout.create_object_sid(33554496, 0, 0, -1)
                        else
                            if v3 == 5 then
                                Item = fallout.create_object_sid(33554497, 0, 0, -1)
                            else
                                if fallout.random(1, 3) == 1 then
                                    Item = fallout.create_object_sid(33554498, 0, 0, -1)
                                else
                                    Item = fallout.create_object_sid(33554744, 0, 0, -1)
                                end
                            end
                        end
                    end
                end
            end
        else
            if v2 == 1 then
                v3 = fallout.random(1, 3)
                if v3 == 1 then
                    Item = fallout.create_object_sid(33554712, 0, 0, -1)
                else
                    if v3 == 2 then
                        Item = fallout.create_object_sid(33554711, 0, 0, -1)
                    else
                        Item = fallout.create_object_sid(33554710, 0, 0, -1)
                    end
                end
            else
                if v2 == 2 then
                    v3 = fallout.random(1, 5)
                    if v3 == 1 then
                        Item = fallout.create_object_sid(33554514, 0, 0, -1)
                    else
                        if v3 == 2 then
                            Item = fallout.create_object_sid(33554515, 0, 0, -1)
                        else
                            if v3 == 3 then
                                Item = fallout.create_object_sid(33554516, 0, 0, -1)
                            else
                                if v3 == 4 then
                                    Item = fallout.create_object_sid(33554517, 0, 0, -1)
                                else
                                    Item = fallout.create_object_sid(33554518, 0, 0, -1)
                                end
                            end
                        end
                    end
                else
                    if v2 == 3 then
                        Item = fallout.create_object_sid(33554533, 0, 0, -1)
                    else
                        if v2 == 4 then
                            v3 = fallout.random(1, 4)
                            if v3 == 1 then
                                Item = fallout.create_object_sid(33554524, 0, 0, -1)
                            else
                                if v3 == 2 then
                                    Item = fallout.create_object_sid(33554525, 0, 0, -1)
                                else
                                    if v3 == 3 then
                                        Item = fallout.create_object_sid(33554524, 0, 0, -1)
                                    else
                                        Item = fallout.create_object_sid(33554525, 0, 0, -1)
                                    end
                                end
                            end
                        else
                            if v2 == 5 then
                                v3 = fallout.random(1, 4)
                                if v3 == 1 then
                                    Item = fallout.create_object_sid(33554534, 0, 0, -1)
                                else
                                    if v3 == 2 then
                                        Item = fallout.create_object_sid(33554535, 0, 0, -1)
                                    else
                                        if v3 == 3 then
                                            Item = fallout.create_object_sid(33554536, 0, 0, -1)
                                        else
                                            Item = fallout.create_object_sid(33554534, 0, 0, -1)
                                        end
                                    end
                                end
                            else
                                if v2 == 6 then
                                    v3 = fallout.random(1, 3)
                                    if v3 == 1 then
                                        Item = fallout.create_object_sid(33554541, 0, 0, -1)
                                    else
                                        if v3 == 2 then
                                            Item = fallout.create_object_sid(33554542, 0, 0, -1)
                                        else
                                            Item = fallout.create_object_sid(33554540, 0, 0, -1)
                                        end
                                    end
                                else
                                    if v2 == 7 then
                                        v3 = fallout.random(1, 4)
                                        if v3 == 1 then
                                            Item = fallout.create_object_sid(33554555, 0, 0, -1)
                                        else
                                            if v3 == 2 then
                                                Item = fallout.create_object_sid(33554553, 0, 0, -1)
                                            else
                                                if v3 == 3 then
                                                    Item = fallout.create_object_sid(33554556, 0, 0, -1)
                                                else
                                                    Item = fallout.create_object_sid(33554554, 0, 0, -1)
                                                end
                                            end
                                        end
                                    else
                                        if v2 == 8 then
                                            v3 = fallout.random(1, 3)
                                            if v3 == 1 then
                                                Item = fallout.create_object_sid(33554712, 0, 0, -1)
                                            else
                                                if v3 == 2 then
                                                    Item = fallout.create_object_sid(33554711, 0, 0, -1)
                                                else
                                                    Item = fallout.create_object_sid(33554710, 0, 0, -1)
                                                end
                                            end
                                        else
                                            v3 = fallout.random(1, 6)
                                            if v3 == 1 then
                                                Item = fallout.create_object_sid(33554517, 0, 0, -1)
                                            else
                                                if v3 == 2 then
                                                    if fallout.random(1, 3) == 1 then
                                                        Item = fallout.create_object_sid(33554749, 0, 0, -1)
                                                    else
                                                        Item = fallout.create_object_sid(33554496, 0, 0, -1)
                                                    end
                                                else
                                                    if v3 == 3 then
                                                        Item = fallout.create_object_sid(33554555, 0, 0, -1)
                                                    else
                                                        if v3 == 4 then
                                                            Item = fallout.create_object_sid(33554496, 0, 0, -1)
                                                        else
                                                            if v3 == 5 then
                                                                Item = fallout.create_object_sid(33554497, 0, 0, -1)
                                                            else
                                                                if fallout.random(1, 3) == 1 then
                                                                    Item = fallout.create_object_sid(33554498, 0, 0, -1)
                                                                else
                                                                    Item = fallout.create_object_sid(fallout.random(0, 2) + 33554710, 0, 0, -1)
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        v4 = v2
        fallout.critter_attempt_placement(Item, v0, 0)
        Tot_Critter_A = Tot_Critter_A - 1
    end
end

function Place_critter()
    local v0 = 0
    local v1 = 0
    Critter = fallout.create_object_sid(Critter_type, 0, 0, Critter_script)
    Range = fallout.random(Inner_ring, Outer_ring)
    v0 = fallout.random(0, 5)
    Critter_tile = fallout.tile_num_in_direction(Dude_tile, Critter_direction, Range)
    v1 = fallout.tile_num_in_direction(Critter_tile, v0, Range // 2)
    if (fallout.tile_distance(Dude_tile, v1) <= Outer_ring) and (fallout.tile_distance(Dude_tile, v1) >= Inner_ring) then
        Critter_tile = fallout.tile_num_in_direction(Critter_tile, v0, Range // 2)
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

local exports = {}
exports.start = start
return exports
