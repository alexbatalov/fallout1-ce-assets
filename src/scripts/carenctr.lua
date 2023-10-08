local fallout = require("fallout")
local light = require("lib.light")

local start
local map_enter_p_proc
local map_exit_p_proc
local Junktown_CC_1
local Junktown_CC_2
local Junktown_CC_3
local Junktown_FGT_1
local Junktown_FGT_2
local Junktown_FGT_3
local Junktown_WM_1
local Junktown_WM_2
local Boneyard_CC_1
local Boneyard_CC_2
local Boneyard_CC_3
local Boneyard_FGT_1
local Boneyard_FGT_2
local Boneyard_FGT_3
local Boneyard_WM_1
local Boneyard_WM_2
local Brotherhood_CC_1
local Brotherhood_CC_2
local Brotherhood_CC_3
local Brotherhood_FGT_1
local Brotherhood_FGT_2
local Brotherhood_FGT_3
local Necrop_CC_1
local Necrop_CC_2
local Necrop_CC_3
local Small_Ghoul
local Medium_Ghoul
local Large_Ghoul
local Huge_Ghoul
local Small_Merc
local Medium_Merc
local Large_Merc
local Huge_Merc
local Small_Mutant
local Medium_Mutant
local Large_Mantis
local Huge_Mantis
local Small_Spawn
local Party_Pack
local Monster_Pack
local Dice_Total
local Cycle
local Place_Caravan
local Place_Stranger
local Mutant_Stuff
local Ghoul_Stuff
local Human_Stuff

local Dice_Roll = 0
local Critter_Rotation = 0
local Total_Rotation = 0
local Critter_Tile = 0
local Inner_Circle = 0
local Outer_Circle = 0
local Players_Elevation = 0
local Entering_Map = 0
local Ghoul_Merc = 0
local Mutant_Merc = 0
local Human_Merc = 0

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

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 16 then
            map_exit_p_proc()
        end
    end
end

function map_enter_p_proc()
    light.lighting()
    add_party()
    Outer_Circle = fallout.random(4, 9) + 4
    Inner_Circle = Outer_Circle - 4
    if fallout.metarule(14, 0) then
        fallout.set_global_var(215, 1)
        fallout.set_global_var(216, 2)
        fallout.debug_msg("CVan_Driver == " .. fallout.global_var(215))
        fallout.debug_msg("CVan_Guard == " .. fallout.global_var(216))
        Place_Caravan()
        if fallout.global_var(199) == 1 then
            if fallout.cur_map_index() == 56 then
                if fallout.global_var(32) == 1 then
                    Boneyard_CC_1()
                else
                    if fallout.global_var(32) == 2 then
                        Boneyard_CC_2()
                    else
                        Boneyard_CC_3()
                    end
                end
            else
                if fallout.cur_map_index() == 57 then
                    if fallout.global_var(32) == 1 then
                        Necrop_CC_1()
                    else
                        if fallout.global_var(32) == 2 then
                            Necrop_CC_2()
                        else
                            Necrop_CC_3()
                        end
                    end
                else
                    if fallout.cur_map_index() == 58 then
                        if fallout.global_var(32) == 1 then
                            Junktown_CC_1()
                        else
                            if fallout.global_var(32) == 2 then
                                Junktown_CC_2()
                            else
                                Junktown_CC_3()
                            end
                        end
                    else
                        if fallout.global_var(32) == 1 then
                            Brotherhood_CC_1()
                        else
                            if fallout.global_var(32) == 2 then
                                Brotherhood_CC_2()
                            else
                                Brotherhood_CC_3()
                            end
                        end
                    end
                end
            end
        else
            if fallout.global_var(200) == 1 then
                if fallout.cur_map_index() == 56 then
                    if fallout.global_var(32) == 1 then
                        Boneyard_WM_1()
                    else
                        Boneyard_WM_2()
                    end
                else
                    if fallout.global_var(32) == 1 then
                        Junktown_WM_1()
                    else
                        Junktown_WM_2()
                    end
                end
            else
                if fallout.cur_map_index() == 56 then
                    if fallout.global_var(32) == 1 then
                        Boneyard_FGT_1()
                    else
                        if fallout.global_var(32) == 2 then
                            Boneyard_FGT_2()
                        else
                            Boneyard_FGT_3()
                        end
                    end
                else
                    if fallout.cur_map_index() == 58 then
                        if fallout.global_var(32) == 1 then
                            Junktown_FGT_1()
                        else
                            if fallout.global_var(32) == 2 then
                                Junktown_FGT_2()
                            else
                                Junktown_FGT_3()
                            end
                        end
                    else
                        if fallout.global_var(32) == 1 then
                            Brotherhood_FGT_1()
                        else
                            if fallout.global_var(32) == 2 then
                                Brotherhood_FGT_2()
                            else
                                Brotherhood_FGT_3()
                            end
                        end
                    end
                end
            end
        end
    end
end

function map_exit_p_proc()
    remove_party()
    fallout.set_global_var(200, 2)
    fallout.set_global_var(199, 2)
    fallout.set_global_var(201, 2)
end

function Junktown_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Mantis()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Large_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Huge_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Medium_Merc()
                        else
                            Small_Spawn()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Mutant()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Mantis()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Medium_Merc()
                        else
                            Small_Ghoul()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Small_Spawn()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_FGT_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Ghoul()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Medium_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Mantis()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Small_Merc()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_FGT_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Ghoul()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Party_Pack()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Large_Mantis()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Huge_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Small_Merc()
                        else
                            Small_Ghoul()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_FGT_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Medium_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Small_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Huge_Mantis()
                        else
                            Huge_Merc()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_WM_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Small_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Medium_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Small_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Large_Merc()
                        end
                    end
                end
            end
        end
    end
end

function Junktown_WM_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Medium_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Large_Mantis()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Medium_Merc()
                        else
                            Huge_Mantis()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Spawn()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Huge_Mantis()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Large_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Small_Mutant()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Medium_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Huge_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Mantis()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Medium_Merc()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Huge_Mantis()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Medium_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Huge_Merc()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_FGT_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_FGT_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Small_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Huge_Mantis()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_FGT_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Mantis()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Large_Merc()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_WM_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Medium_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Small_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Medium_Merc()
                        else
                            Large_Mantis()
                        end
                    end
                end
            end
        end
    end
end

function Boneyard_WM_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Medium_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Small_Merc()
                        else
                            Large_Mantis()
                        end
                    end
                end
            end
        end
    end
end

function Brotherhood_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Small_Spawn()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Party_Pack()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Monster_Pack()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Medium_Ghoul()
                        else
                            Medium_Mutant()
                        end
                    end
                end
            end
        end
    end
end

function Brotherhood_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Huge_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Party_Pack()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Huge_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Small_Spawn()
                        else
                            Small_Mutant()
                        end
                    end
                end
            end
        end
    end
end

function Brotherhood_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Huge_Mantis()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Large_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Huge_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Small_Merc()
                        else
                            Monster_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Brotherhood_FGT_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Huge_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Mantis()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Medium_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Mantis()
                        else
                            Small_Mutant()
                        end
                    end
                end
            end
        end
    end
end

function Brotherhood_FGT_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Mutant()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Small_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Large_Mantis()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Medium_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Huge_Merc()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Huge_Mantis()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Brotherhood_FGT_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Small_Mutant()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Medium_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Large_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Huge_Merc()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Necrop_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Ghoul()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Large_Merc()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Party_Pack()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Small_Ghoul()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Huge_Mantis()
                        else
                            Large_Ghoul()
                        end
                    end
                end
            end
        end
    end
end

function Necrop_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Small_Ghoul()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Large_Merc()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Large_Ghoul()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Huge_Ghoul()
                        else
                            Party_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Necrop_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Ghoul()
    else
        if (Dice_Roll > 3) and (Dice_Roll < 7) then
            Medium_Ghoul()
        else
            if (Dice_Roll > 6) and (Dice_Roll < 10) then
                Small_Ghoul()
            else
                if (Dice_Roll > 9) and (Dice_Roll < 13) then
                    Huge_Merc()
                else
                    if (Dice_Roll > 12) and (Dice_Roll < 16) then
                        Huge_Mantis()
                    else
                        if (Dice_Roll > 15) and (Dice_Roll < 18) then
                            Large_Ghoul()
                        else
                            Monster_Pack()
                        end
                    end
                end
            end
        end
    end
end

function Small_Ghoul()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 3)
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle))
        Ghoul_Merc = fallout.create_object_sid(16777401, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Critter_Rotation == 0 then
            fallout.anim(Ghoul_Merc, 1000, 3)
        else
            if Critter_Rotation == 1 then
                fallout.anim(Ghoul_Merc, 1000, 4)
            else
                fallout.anim(Ghoul_Merc, 1000, 5)
            end
        end
        Ghoul_Stuff()
        v1 = v1 + 1
    end
end

function Medium_Ghoul()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(4, 6)
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Ghoul_Merc = fallout.create_object_sid(16777401, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Total_Rotation == 0 then
            fallout.anim(Ghoul_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Ghoul_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Ghoul_Merc, 1000, 5)
                else
                    fallout.anim(Ghoul_Merc, 1000, 3)
                end
            end
        end
        Ghoul_Stuff()
        v1 = v1 + 1
    end
end

function Large_Ghoul()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(7, 9)
    Outer_Circle = fallout.random(6, 12) + 4
    Inner_Circle = Outer_Circle - 4
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Ghoul_Merc = fallout.create_object_sid(16777401, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Total_Rotation == 0 then
            fallout.anim(Ghoul_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Ghoul_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Ghoul_Merc, 1000, 5)
                else
                    fallout.anim(Ghoul_Merc, 1000, 3)
                end
            end
        end
        Ghoul_Stuff()
        v1 = v1 + 1
    end
end

function Huge_Ghoul()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(10, 13)
    Outer_Circle = fallout.random(8, 16) + 4
    Inner_Circle = Outer_Circle - 6
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Ghoul_Merc = fallout.create_object_sid(16777401, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Total_Rotation == 0 then
            fallout.anim(Ghoul_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Ghoul_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Ghoul_Merc, 1000, 5)
                else
                    fallout.anim(Ghoul_Merc, 1000, 3)
                end
            end
        end
        Ghoul_Stuff()
        v1 = v1 + 1
    end
end

function Small_Merc()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(2, 4)
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle))
        if fallout.random(0, 1) then
            Human_Merc = fallout.create_object_sid(16777446, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        else
            Human_Merc = fallout.create_object_sid(16777440, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        end
        if Critter_Rotation == 0 then
            fallout.anim(Human_Merc, 1000, 3)
        else
            if Critter_Rotation == 1 then
                fallout.anim(Human_Merc, 1000, 4)
            else
                fallout.anim(Human_Merc, 1000, 5)
            end
        end
        Human_Stuff()
        v1 = v1 + 1
    end
end

function Medium_Merc()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.random(3, 5)
    Outer_Circle = fallout.random(5, 10) + 2
    Inner_Circle = Outer_Circle - 4
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        v2 = fallout.random(1, 4)
        if v2 == 1 then
            Human_Merc = fallout.create_object_sid(16777446, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        else
            if v2 == 2 then
                Human_Merc = fallout.create_object_sid(16777440, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
            else
                if v2 == 3 then
                    Human_Merc = fallout.create_object_sid(16777473, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
                else
                    Human_Merc = fallout.create_object_sid(16777478, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
                end
            end
        end
        if Total_Rotation == 0 then
            fallout.anim(Human_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Human_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Human_Merc, 1000, 5)
                else
                    fallout.anim(Human_Merc, 1000, 3)
                end
            end
        end
        Human_Stuff()
        v1 = v1 + 1
    end
end

function Large_Merc()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.random(4, 7)
    Outer_Circle = fallout.random(6, 10) + 6
    Inner_Circle = Outer_Circle - 6
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 3)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        v2 = fallout.random(1, 4)
        if v2 == 1 then
            Human_Merc = fallout.create_object_sid(16777446, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        else
            if v2 == 2 then
                Human_Merc = fallout.create_object_sid(16777440, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
            else
                if v2 == 3 then
                    Human_Merc = fallout.create_object_sid(16777473, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
                else
                    Human_Merc = fallout.create_object_sid(16777478, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
                end
            end
        end
        if Total_Rotation == 0 then
            fallout.anim(Human_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Human_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Human_Merc, 1000, 5)
                else
                    fallout.anim(Human_Merc, 1000, 3)
                end
            end
        end
        Human_Stuff()
        v1 = v1 + 1
    end
end

function Huge_Merc()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.random(6, 10)
    Outer_Circle = fallout.random(10, 16) + 2
    Inner_Circle = Outer_Circle - 8
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 4)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 4)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 4)
        Critter_Rotation = fallout.random(0, 3)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 4)
        v2 = fallout.random(1, 4)
        if v2 == 1 then
            Human_Merc = fallout.create_object_sid(16777446, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        else
            if v2 == 2 then
                Human_Merc = fallout.create_object_sid(16777440, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
            else
                if v2 == 3 then
                    Human_Merc = fallout.create_object_sid(16777473, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
                else
                    Human_Merc = fallout.create_object_sid(16777478, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
                end
            end
        end
        if Total_Rotation == 0 then
            fallout.anim(Human_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Human_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Human_Merc, 1000, 5)
                else
                    fallout.anim(Human_Merc, 1000, 3)
                end
            end
        end
        Human_Stuff()
        v1 = v1 + 1
    end
end

function Small_Mutant()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 2)
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle))
        Mutant_Merc = fallout.create_object_sid(16777403, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Critter_Rotation == 0 then
            fallout.anim(Mutant_Merc, 1000, 3)
        else
            if Critter_Rotation == 1 then
                fallout.anim(Mutant_Merc, 1000, 4)
            else
                fallout.anim(Mutant_Merc, 1000, 5)
            end
        end
        Mutant_Stuff()
        v1 = v1 + 1
    end
end

function Medium_Mutant()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(2, 4)
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Total_Rotation - Critter_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Mutant_Merc = fallout.create_object_sid(16777403, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Total_Rotation == 0 then
            fallout.anim(Mutant_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Mutant_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Mutant_Merc, 1000, 5)
                else
                    fallout.anim(Mutant_Merc, 1000, 3)
                end
            end
        end
        Mutant_Stuff()
        v1 = v1 + 1
    end
end

function Large_Mantis()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.random(5, 8)
    Outer_Circle = fallout.random(8, 16) + 2
    Inner_Circle = Outer_Circle - 6
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        v2 = fallout.create_object_sid(16777392, Critter_Tile, fallout.elevation(fallout.dude_obj()), 762)
        if Total_Rotation == 0 then
            fallout.anim(v2, 1000, 3)
            continue
        end
        if Total_Rotation == 1 then
            fallout.anim(v2, 1000, 4)
            continue
        end
        if Total_Rotation == 2 then
            fallout.anim(v2, 1000, 5)
            continue
        end
        fallout.anim(v2, 1000, 3)
        v1 = v1 + 1
    end
end

function Huge_Mantis()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.random(6, 10)
    Outer_Circle = fallout.random(8, 16) + 2
    Inner_Circle = Outer_Circle - 6
    while v1 < v0 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        v2 = fallout.create_object_sid(16777392, Critter_Tile, fallout.elevation(fallout.dude_obj()), 762)
        if Total_Rotation == 0 then
            fallout.anim(v2, 1000, 3)
            continue
        end
        if Total_Rotation == 1 then
            fallout.anim(v2, 1000, 4)
            continue
        end
        if Total_Rotation == 2 then
            fallout.anim(v2, 1000, 5)
            continue
        end
        fallout.anim(v2, 1000, 3)
        v1 = v1 + 1
    end
end

function Small_Spawn()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.random(1, 2)
    while v1 < v0 do
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 2), fallout.random(Inner_Circle, Outer_Circle))
        v2 = fallout.create_object_sid(16777381, Critter_Tile, fallout.elevation(fallout.dude_obj()), 762)
        fallout.anim(v2, 1000, 3)
        v1 = v1 + 1
    end
end

function Party_Pack()
    Large_Merc()
    Medium_Ghoul()
end

function Monster_Pack()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    Outer_Circle = fallout.random(4, 9) + 4
    Inner_Circle = Outer_Circle - 4
    Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 2), fallout.random(Inner_Circle, Outer_Circle))
    v0 = fallout.create_object_sid(16777381, Critter_Tile, fallout.elevation(fallout.dude_obj()), 762)
    fallout.anim(v0, 1000, 3)
    v3 = fallout.random(3, 5)
    while v2 < v3 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 3)
        v1 = fallout.create_object_sid(16777392, Critter_Tile, fallout.elevation(fallout.dude_obj()), 762)
        if Total_Rotation == 0 then
            fallout.anim(v1, 1000, 3)
            continue
        end
        if Total_Rotation == 1 then
            fallout.anim(v1, 1000, 4)
            continue
        end
        if Total_Rotation == 2 then
            fallout.anim(v1, 1000, 5)
            continue
        end
        fallout.anim(v1, 1000, 3)
        v2 = v2 + 1
    end
    v2 = 0
    v3 = fallout.random(2, 4)
    while v2 < v3 do
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Critter_Rotation
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Critter_Rotation = fallout.random(0, 2)
        Total_Rotation = Total_Rotation + (Critter_Rotation - Total_Rotation)
        Critter_Tile = fallout.tile_num_in_direction(Critter_Tile, Critter_Rotation, fallout.random(Inner_Circle, Outer_Circle) // 2)
        Ghoul_Merc = fallout.create_object_sid(16777401, Critter_Tile, fallout.elevation(fallout.dude_obj()), 763)
        if Total_Rotation == 0 then
            fallout.anim(Ghoul_Merc, 1000, 3)
        else
            if Total_Rotation == 1 then
                fallout.anim(Ghoul_Merc, 1000, 4)
            else
                if Total_Rotation == 2 then
                    fallout.anim(Ghoul_Merc, 1000, 5)
                else
                    fallout.anim(Ghoul_Merc, 1000, 3)
                end
            end
        end
        Ghoul_Stuff()
        v2 = v2 + 1
    end
end

function Dice_Total()
    Dice_Roll = fallout.random(3, 18)
end

function Cycle()
    if Critter_Rotation > 5 then
        Critter_Rotation = Critter_Rotation % 6
    else
        if Critter_Rotation < 0 then
            while Critter_Rotation < 0 do
                Critter_Rotation = Critter_Rotation + 6
            end
        end
    end
end

function Place_Caravan()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    if fallout.global_var(32) == 1 then
        if (fallout.cur_map_index() == 58) or (fallout.cur_map_index() == 59) then
            fallout.override_map_start(85, 95, 0, 1)
        else
            fallout.override_map_start(83, 103, 0, 1)
        end
        Players_Elevation = 0
    else
        if fallout.global_var(32) == 2 then
            if (fallout.cur_map_index() == 58) or (fallout.cur_map_index() == 59) then
                fallout.override_map_start(85, 95, 1, 1)
            else
                fallout.override_map_start(83, 103, 1, 1)
            end
            Players_Elevation = 1
        else
            if (fallout.cur_map_index() == 58) or (fallout.cur_map_index() == 59) then
                fallout.override_map_start(85, 95, 2, 1)
            else
                fallout.override_map_start(93, 84, 2, 1)
            end
            Players_Elevation = 2
        end
    end
    fallout.debug_msg("Procedure CVan_Driver == " .. fallout.global_var(215))
    fallout.debug_msg("Procedure CVan_Guard == " .. fallout.global_var(216))
    if fallout.global_var(215) == 1 then
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 6)
        v0 = fallout.create_object_sid(16777233, Critter_Tile, fallout.elevation(fallout.dude_obj()), 761)
        fallout.critter_add_trait(v0, 1, 6, 0)
        fallout.critter_add_trait(v0, 1, 5, 17)
        fallout.anim(v0, 1000, 1)
        v2 = fallout.create_object_sid(94, 0, 0, -1)
        fallout.add_obj_to_inven(v0, v2)
        fallout.wield_obj_critter(v0, v2)
    end
    if fallout.global_var(216) == 2 then
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 5, 4)
        v1 = fallout.create_object_sid(16777420, Critter_Tile, fallout.elevation(fallout.dude_obj()), 761)
        fallout.critter_add_trait(v0, 1, 6, 0)
        fallout.critter_add_trait(v0, 1, 5, 17)
        fallout.anim(v1, 1000, 1)
        v2 = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(v1, v2)
        fallout.wield_obj_critter(v1, v2)
    end
    if fallout.global_var(216) >= 1 then
        Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 4)
        v1 = fallout.create_object_sid(16777420, Critter_Tile, fallout.elevation(fallout.dude_obj()), 761)
        fallout.critter_add_trait(v0, 1, 6, 0)
        fallout.critter_add_trait(v0, 1, 5, 17)
        fallout.anim(v1, 1000, 1)
        v2 = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(v1, v2)
        fallout.wield_obj_critter(v1, v2)
    end
    if fallout.has_trait(0, fallout.dude_obj(), 46) then
        Place_Stranger()
    end
end

function Place_Stranger()
    local v0 = 0
    local v1 = 0
    Critter_Tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 5, 2)
    v0 = fallout.create_object_sid(16777520, Critter_Tile, fallout.elevation(fallout.dude_obj()), 761)
    fallout.critter_add_trait(v0, 1, 6, 0)
    fallout.critter_add_trait(v0, 1, 5, 92)
    v1 = fallout.create_object_sid(23, 0, 0, -1)
    fallout.add_obj_to_inven(v0, v1)
    fallout.wield_obj_critter(v0, v1)
    v1 = fallout.create_object_sid(36, 0, 0, -1)
    if fallout.has_trait(0, fallout.dude_obj(), 40) then
        fallout.add_mult_objs_to_inven(v0, v1, 10)
    else
        fallout.add_mult_objs_to_inven(v0, v1, 5)
    end
end

function Mutant_Stuff()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 5)
    if v0 == 1 then
        v1 = fallout.create_object_sid(11, 0, 0, -1)
        fallout.add_obj_to_inven(Mutant_Merc, v1)
        fallout.wield_obj_critter(Mutant_Merc, v1)
    end
    v0 = fallout.random(1, 3)
    if v0 == 1 then
        v1 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Mutant_Merc, v1, fallout.random(1, 3))
    end
    v0 = fallout.random(1, 2)
    if v0 == 1 then
        v1 = fallout.create_object_sid(234, 0, 0, -1)
        fallout.add_obj_to_inven(Mutant_Merc, v1)
        fallout.wield_obj_critter(Mutant_Merc, v1)
    end
    v0 = fallout.random(1, 5)
    if v0 == 1 then
        v1 = fallout.create_object_sid(144, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Mutant_Merc, v1, fallout.random(1, 2))
    end
    v0 = fallout.random(1, 10)
    if v0 == 1 then
        v1 = fallout.create_object_sid(59, 0, 0, -1)
        fallout.add_obj_to_inven(Mutant_Merc, v1)
    end
    v0 = fallout.random(1, 10)
    if v0 == 1 then
        v1 = fallout.create_object_sid(52, 0, 0, -1)
        fallout.add_obj_to_inven(Mutant_Merc, v1)
    end
end

function Ghoul_Stuff()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v2 = fallout.create_object_sid(41, 0, 0, -1)
    if fallout.has_trait(0, fallout.dude_obj(), 20) then
        fallout.add_mult_objs_to_inven(Ghoul_Merc, v2, fallout.random(2, 20))
    else
        fallout.add_mult_objs_to_inven(Ghoul_Merc, v2, fallout.random(0, 10))
    end
    v0 = fallout.random(1, 4)
    if (v0 == 1) or (v0 == 2) then
        v1 = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(Ghoul_Merc, v1)
        fallout.wield_obj_critter(Ghoul_Merc, v1)
    else
        if v0 == 3 then
            v1 = fallout.create_object_sid(7, 0, 0, -1)
            fallout.add_obj_to_inven(Ghoul_Merc, v1)
            fallout.wield_obj_critter(Ghoul_Merc, v1)
        end
    end
    v0 = fallout.random(1, 4)
    if v0 == 1 then
        v1 = fallout.create_object_sid(71, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Ghoul_Merc, v1, fallout.random(1, 2))
    end
end

function Human_Stuff()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v2 = fallout.create_object_sid(41, 0, 0, -1)
    if fallout.has_trait(0, fallout.dude_obj(), 20) then
        fallout.add_mult_objs_to_inven(Human_Merc, v2, fallout.random(8, 40))
    else
        fallout.add_mult_objs_to_inven(Human_Merc, v2, fallout.random(4, 20))
    end
    v0 = fallout.random(1, 10)
    if v0 <= 3 then
        v1 = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(Human_Merc, v1)
        fallout.wield_obj_critter(Human_Merc, v1)
    else
        if (v0 > 3) and (v0 <= 5) then
            v1 = fallout.create_object_sid(236, 0, 0, -1)
            fallout.add_obj_to_inven(Human_Merc, v1)
            fallout.wield_obj_critter(Human_Merc, v1)
        else
            if (v0 > 5) and (v0 <= 7) then
                v1 = fallout.create_object_sid(8, 0, 0, -1)
                fallout.add_obj_to_inven(Human_Merc, v1)
                fallout.wield_obj_critter(Human_Merc, v1)
                v1 = fallout.create_object_sid(30, 0, 0, -1)
                if fallout.has_trait(0, fallout.dude_obj(), 40) then
                    fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(2, 4))
                else
                    fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(1, 2))
                end
            else
                if (v0 > 7) and (v0 <= 9) then
                    v1 = fallout.create_object_sid(18, 0, 0, -1)
                    fallout.add_obj_to_inven(Human_Merc, v1)
                    fallout.wield_obj_critter(Human_Merc, v1)
                    v1 = fallout.create_object_sid(111, 0, 0, -1)
                    if fallout.has_trait(0, fallout.dude_obj(), 40) then
                        fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(2, 4))
                    else
                        fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(0, 2))
                    end
                else
                    v1 = fallout.create_object_sid(10, 0, 0, -1)
                    fallout.add_obj_to_inven(Human_Merc, v1)
                    fallout.wield_obj_critter(Human_Merc, v1)
                    v1 = fallout.create_object_sid(34, 0, 0, -1)
                    if fallout.has_trait(0, fallout.dude_obj(), 40) then
                        fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(1, 2))
                    else
                        fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(0, 1))
                    end
                end
            end
        end
    end
    v0 = fallout.random(1, 3)
    if v0 == 1 then
        v1 = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(Human_Merc, v1, fallout.random(1, 2))
    end
    v0 = fallout.random(1, 10)
    if v0 == 1 then
        v1 = fallout.create_object_sid(47, 0, 0, -1)
        fallout.add_obj_to_inven(Human_Merc, v1)
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

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
