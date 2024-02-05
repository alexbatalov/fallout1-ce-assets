local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")
local party = require("lib.party")

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
local Place_Caravan
local Place_Stranger
local Mutant_Stuff
local Ghoul_Stuff
local Human_Stuff

local Dice_Roll = 0
local Inner_Circle = 0
local Outer_Circle = 0

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

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 16 then
        map_exit_p_proc()
    end
end

function map_enter_p_proc()
    light.lighting()
    party_elevation = party.add_party()
    Outer_Circle = fallout.random(4, 9) + 4
    Inner_Circle = Outer_Circle - 4
    if misc.map_first_run() then
        fallout.set_global_var(215, 1)
        fallout.set_global_var(216, 2)
        fallout.debug_msg("CVan_Driver == " .. fallout.global_var(215))
        fallout.debug_msg("CVan_Guard == " .. fallout.global_var(216))
        Place_Caravan()
        local cur_map_index = fallout.cur_map_index()
        if fallout.global_var(199) == 1 then
            if cur_map_index == 56 then
                if fallout.global_var(32) == 1 then
                    Boneyard_CC_1()
                elseif fallout.global_var(32) == 2 then
                    Boneyard_CC_2()
                else
                    Boneyard_CC_3()
                end
            elseif cur_map_index == 57 then
                if fallout.global_var(32) == 1 then
                    Necrop_CC_1()
                elseif fallout.global_var(32) == 2 then
                    Necrop_CC_2()
                else
                    Necrop_CC_3()
                end
            elseif cur_map_index == 58 then
                if fallout.global_var(32) == 1 then
                    Junktown_CC_1()
                elseif fallout.global_var(32) == 2 then
                    Junktown_CC_2()
                else
                    Junktown_CC_3()
                end
            else
                if fallout.global_var(32) == 1 then
                    Brotherhood_CC_1()
                elseif fallout.global_var(32) == 2 then
                    Brotherhood_CC_2()
                else
                    Brotherhood_CC_3()
                end
            end
        elseif fallout.global_var(200) == 1 then
            if cur_map_index == 56 then
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
            if cur_map_index == 56 then
                if fallout.global_var(32) == 1 then
                    Boneyard_FGT_1()
                elseif fallout.global_var(32) == 2 then
                    Boneyard_FGT_2()
                else
                    Boneyard_FGT_3()
                end
            elseif cur_map_index == 58 then
                if fallout.global_var(32) == 1 then
                    Junktown_FGT_1()
                elseif fallout.global_var(32) == 2 then
                    Junktown_FGT_2()
                else
                    Junktown_FGT_3()
                end
            else
                if fallout.global_var(32) == 1 then
                    Brotherhood_FGT_1()
                elseif fallout.global_var(32) == 2 then
                    Brotherhood_FGT_2()
                else
                    Brotherhood_FGT_3()
                end
            end
        end
    end
end

function map_exit_p_proc()
    party.remove_party()
    fallout.set_global_var(200, 2)
    fallout.set_global_var(199, 2)
    fallout.set_global_var(201, 2)
end

function Junktown_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Mantis()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Large_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Huge_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Medium_Merc()
    else
        Small_Spawn()
    end
end

function Junktown_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Mutant()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Mantis()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Medium_Merc()
    else
        Small_Ghoul()
    end
end

function Junktown_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Small_Spawn()
    else
        Party_Pack()
    end
end

function Junktown_FGT_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Ghoul()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Medium_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Mantis()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Small_Merc()
    else
        Party_Pack()
    end
end

function Junktown_FGT_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Ghoul()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Party_Pack()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Large_Mantis()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Huge_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Small_Merc()
    else
        Small_Ghoul()
    end
end

function Junktown_FGT_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Medium_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Small_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Huge_Mantis()
    else
        Huge_Merc()
    end
end

function Junktown_WM_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Small_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Medium_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Small_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Large_Merc()
    end
end

function Junktown_WM_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Medium_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Large_Mantis()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Medium_Merc()
    else
        Huge_Mantis()
    end
end

function Boneyard_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Spawn()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Huge_Mantis()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Large_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Small_Mutant()
    end
end

function Boneyard_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Medium_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Huge_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Mantis()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Medium_Merc()
    else
        Party_Pack()
    end
end

function Boneyard_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Huge_Mantis()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Medium_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Huge_Merc()
    end
end

function Boneyard_FGT_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Party_Pack()
    end
end

function Boneyard_FGT_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Small_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Huge_Mantis()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Party_Pack()
    end
end

function Boneyard_FGT_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Mantis()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Large_Merc()
    end
end

function Boneyard_WM_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Medium_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Small_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Medium_Merc()
    else
        Large_Mantis()
    end
end

function Boneyard_WM_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Large_Merc()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Medium_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Small_Merc()
    else
        Large_Mantis()
    end
end

function Brotherhood_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Small_Spawn()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Party_Pack()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Monster_Pack()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Medium_Ghoul()
    else
        Medium_Mutant()
    end
end

function Brotherhood_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Huge_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Party_Pack()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Huge_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Small_Spawn()
    else
        Small_Mutant()
    end
end

function Brotherhood_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Party_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Huge_Mantis()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Large_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Huge_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Small_Merc()
    else
        Monster_Pack()
    end
end

function Brotherhood_FGT_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Huge_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Mantis()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Medium_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Mantis()
    else
        Small_Mutant()
    end
end

function Brotherhood_FGT_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Small_Mutant()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Small_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Large_Mantis()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Medium_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Huge_Merc()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Huge_Mantis()
    else
        Party_Pack()
    end
end

function Brotherhood_FGT_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Monster_Pack()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Small_Mutant()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Medium_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Large_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Huge_Merc()
    else
        Party_Pack()
    end
end

function Necrop_CC_1()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Ghoul()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Large_Merc()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Party_Pack()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Small_Ghoul()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Huge_Mantis()
    else
        Large_Ghoul()
    end
end

function Necrop_CC_2()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Mantis()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Small_Ghoul()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Large_Merc()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Large_Ghoul()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Huge_Ghoul()
    else
        Party_Pack()
    end
end

function Necrop_CC_3()
    Dice_Total()
    if Dice_Roll == 3 then
        Huge_Ghoul()
    elseif Dice_Roll > 3 and Dice_Roll < 7 then
        Medium_Ghoul()
    elseif Dice_Roll > 6 and Dice_Roll < 10 then
        Small_Ghoul()
    elseif Dice_Roll > 9 and Dice_Roll < 13 then
        Huge_Merc()
    elseif Dice_Roll > 12 and Dice_Roll < 16 then
        Huge_Mantis()
    elseif Dice_Roll > 15 and Dice_Roll < 18 then
        Large_Ghoul()
    else
        Monster_Pack()
    end
end

function Small_Ghoul()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(1, 3)
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle))
        local critter_obj = fallout.create_object_sid(16777401, critter_tile_num, dude_elevation, 763)
        if critter_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif critter_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        else
            fallout.anim(critter_obj, 1000, 5)
        end
        Ghoul_Stuff(critter_obj)
        num = num - 1
    end
end

function Medium_Ghoul()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(4, 6)
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)

        local critter_obj = fallout.create_object_sid(16777401, critter_tile_num, dude_elevation, 763)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Ghoul_Stuff(critter_obj)
        num = num - 1
    end
end

function Large_Ghoul()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(7, 9)
    Outer_Circle = fallout.random(6, 12) + 4
    Inner_Circle = Outer_Circle - 4
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)

        local critter_obj = fallout.create_object_sid(16777401, critter_tile_num, dude_elevation, 763)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Ghoul_Stuff(critter_obj)
        num = num - 1
    end
end

function Huge_Ghoul()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(10, 13)
    Outer_Circle = fallout.random(8, 16) + 4
    Inner_Circle = Outer_Circle - 6
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)

        local critter_obj = fallout.create_object_sid(16777401, critter_tile_num, dude_elevation, 763)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Ghoul_Stuff(critter_obj)
        num = num - 1
    end
end

function Small_Merc()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(2, 4)
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle))

        local critter_obj
        if fallout.random(0, 1) ~= 0 then
            critter_obj = fallout.create_object_sid(16777446, critter_tile_num, dude_elevation, 763)
        else
            critter_obj = fallout.create_object_sid(16777440, critter_tile_num, dude_elevation, 763)
        end
        if critter_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif critter_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        else
            fallout.anim(critter_obj, 1000, 5)
        end
        Human_Stuff(critter_obj)
        num = num - 1
    end
end

function Medium_Merc()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(3, 5)
    Outer_Circle = fallout.random(5, 10) + 2
    Inner_Circle = Outer_Circle - 4
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)

        local critter_obj
        local type = fallout.random(1, 4)
        if type == 1 then
            critter_obj = fallout.create_object_sid(16777446, critter_tile_num, dude_elevation, 763)
        elseif type == 2 then
            critter_obj = fallout.create_object_sid(16777440, critter_tile_num, dude_elevation, 763)
        elseif type == 3 then
            critter_obj = fallout.create_object_sid(16777473, critter_tile_num, dude_elevation, 763)
        else
            critter_obj = fallout.create_object_sid(16777478, critter_tile_num, dude_elevation, 763)
        end
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Human_Stuff(critter_obj)
        num = num - 1
    end
end

function Large_Merc()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(4, 7)
    Outer_Circle = fallout.random(6, 10) + 6
    Inner_Circle = Outer_Circle - 6
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 3)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)

        local critter_obj
        local type = fallout.random(1, 4)
        if type == 1 then
            critter_obj = fallout.create_object_sid(16777446, critter_tile_num, dude_elevation, 763)
        elseif type == 2 then
            critter_obj = fallout.create_object_sid(16777440, critter_tile_num, dude_elevation, 763)
        elseif type == 3 then
            critter_obj = fallout.create_object_sid(16777473, critter_tile_num, dude_elevation, 763)
        else
            critter_obj = fallout.create_object_sid(16777478, critter_tile_num, dude_elevation, 763)
        end
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Human_Stuff(critter_obj)
        num = num - 1
    end
end

function Huge_Merc()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(6, 10)
    Outer_Circle = fallout.random(10, 16) + 2
    Inner_Circle = Outer_Circle - 8
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 4)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 4)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 4)
        critter_rotation = fallout.random(0, 3)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 4)

        local critter_obj
        local type = fallout.random(1, 4)
        if type == 1 then
            critter_obj = fallout.create_object_sid(16777446, critter_tile_num, dude_elevation, 763)
        elseif type == 2 then
            critter_obj = fallout.create_object_sid(16777440, critter_tile_num, dude_elevation, 763)
        elseif type == 3 then
            critter_obj = fallout.create_object_sid(16777473, critter_tile_num, dude_elevation, 763)
        else
            critter_obj = fallout.create_object_sid(16777478, critter_tile_num, dude_elevation, 763)
        end
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Human_Stuff(critter_obj)
        num = num - 1
    end
end

function Small_Mutant()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(1, 2)
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle))

        local critter_obj = fallout.create_object_sid(16777403, critter_tile_num, dude_elevation, 763)
        if critter_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif critter_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        else
            fallout.anim(critter_obj, 1000, 5)
        end
        Mutant_Stuff(critter_obj)
        num = num - 1
    end
end

function Medium_Mutant()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(2, 4)
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (total_rotation - critter_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)

        local critter_obj = fallout.create_object_sid(16777403, critter_tile_num, dude_elevation, 763)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Mutant_Stuff(critter_obj)
        num = num - 1
    end
end

function Large_Mantis()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(5, 8)
    Outer_Circle = fallout.random(8, 16) + 2
    Inner_Circle = Outer_Circle - 6
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)

        local critter_obj = fallout.create_object_sid(16777392, critter_tile_num, dude_elevation, 762)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        num = num - 1
    end
end

function Huge_Mantis()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(6, 10)
    Outer_Circle = fallout.random(8, 16) + 2
    Inner_Circle = Outer_Circle - 6
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)

        local critter_obj = fallout.create_object_sid(16777392, critter_tile_num, dude_elevation, 762)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        num = num - 1
    end
end

function Small_Spawn()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local num = fallout.random(1, 2)
    while num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle))
        local critter_obj = fallout.create_object_sid(16777381, critter_tile_num, dude_elevation, 762)
        fallout.anim(critter_obj, 1000, 3)
        num = num - 1
    end
end

function Party_Pack()
    Large_Merc()
    Medium_Ghoul()
end

function Monster_Pack()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    Outer_Circle = fallout.random(4, 9) + 4
    Inner_Circle = Outer_Circle - 4
    local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, fallout.random(0, 2),
        fallout.random(Inner_Circle, Outer_Circle))
    local critter_obj = fallout.create_object_sid(16777381, critter_tile_num, dude_elevation, 762)
    fallout.anim(critter_obj, 1000, 3)

    local mantises_num = fallout.random(3, 5)
    while mantises_num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 3)

        local critter_obj = fallout.create_object_sid(16777392, critter_tile_num, dude_elevation, 762)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        mantises_num = mantises_num - 1
    end

    local ghouls_num = fallout.random(2, 4)
    while ghouls_num > 0 do
        local critter_rotation = fallout.random(0, 2)
        local total_rotation = critter_rotation
        local critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)
        critter_rotation = fallout.random(0, 2)
        total_rotation = total_rotation + (critter_rotation - total_rotation)
        critter_tile_num = fallout.tile_num_in_direction(critter_tile_num, critter_rotation,
            fallout.random(Inner_Circle, Outer_Circle) // 2)

        local critter_obj = fallout.create_object_sid(16777401, critter_tile_num, dude_elevation, 763)
        if total_rotation == 0 then
            fallout.anim(critter_obj, 1000, 3)
        elseif total_rotation == 1 then
            fallout.anim(critter_obj, 1000, 4)
        elseif total_rotation == 2 then
            fallout.anim(critter_obj, 1000, 5)
        else
            fallout.anim(critter_obj, 1000, 3)
        end
        Ghoul_Stuff(critter_obj)
        ghouls_num = ghouls_num - 1
    end
end

function Dice_Total()
    Dice_Roll = fallout.random(3, 18)
end

function Place_Caravan()
    local cur_map_index = fallout.cur_map_index()
    if fallout.global_var(32) == 1 then
        if cur_map_index == 58 or cur_map_index == 59 then
            fallout.override_map_start(85, 95, 0, 1)
        else
            fallout.override_map_start(83, 103, 0, 1)
        end
    elseif fallout.global_var(32) == 2 then
        if cur_map_index == 58 or cur_map_index == 59 then
            fallout.override_map_start(85, 95, 1, 1)
        else
            fallout.override_map_start(83, 103, 1, 1)
        end
    else
        if cur_map_index == 58 or cur_map_index == 59 then
            fallout.override_map_start(85, 95, 2, 1)
        else
            fallout.override_map_start(93, 84, 2, 1)
        end
    end

    fallout.debug_msg("Procedure CVan_Driver == " .. fallout.global_var(215))
    fallout.debug_msg("Procedure CVan_Guard == " .. fallout.global_var(216))

    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)

    local critter_tile_num
    local critter_obj
    local item_obj

    if fallout.global_var(215) == 1 then
        critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, 4, 6)
        critter_obj = fallout.create_object_sid(16777233, critter_tile_num, dude_elevation, 761)
        misc.set_team(critter_obj, 0)
        fallout.critter_add_trait(critter_obj, 1, 5, 17)
        fallout.anim(critter_obj, 1000, 1)

        item_obj = fallout.create_object_sid(94, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    end

    if fallout.global_var(216) == 2 then
        critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, 5, 4)
        critter_obj = fallout.create_object_sid(16777420, critter_tile_num, dude_elevation, 761)
        misc.set_team(critter_obj, 0)
        fallout.critter_add_trait(critter_obj, 1, 5, 17)
        fallout.anim(critter_obj, 1000, 1)

        item_obj = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    end

    if fallout.global_var(216) >= 1 then
        critter_tile_num = fallout.tile_num_in_direction(dude_tile_num, 3, 4)
        critter_obj = fallout.create_object_sid(16777420, critter_tile_num, dude_elevation, 761)
        misc.set_team(critter_obj, 0)
        fallout.critter_add_trait(critter_obj, 1, 5, 17)
        fallout.anim(critter_obj, 1000, 1)

        item_obj = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    end

    if fallout.has_trait(0, fallout.dude_obj(), 46) ~= 0 then
        Place_Stranger()
    end
end

function Place_Stranger()
    local critter_tile_num
    local critter_obj
    local item_obj

    critter_tile_num = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 5, 2)
    critter_obj = fallout.create_object_sid(16777520, critter_tile_num, fallout.elevation(fallout.dude_obj()), 761)
    misc.set_team(critter_obj, 0)
    fallout.critter_add_trait(critter_obj, 1, 5, 92)

    item_obj = fallout.create_object_sid(23, 0, 0, -1)
    fallout.add_obj_to_inven(critter_obj, item_obj)
    fallout.wield_obj_critter(critter_obj, item_obj)

    item_obj = fallout.create_object_sid(36, 0, 0, -1)
    if fallout.has_trait(0, fallout.dude_obj(), 40) ~= 0 then
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, 10)
    else
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, 5)
    end
end

function Mutant_Stuff(critter_obj)
    local rnd
    local item_obj

    rnd = fallout.random(1, 5)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(11, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    end
    rnd = fallout.random(1, 3)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(1, 3))
    end
    rnd = fallout.random(1, 2)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(234, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    end
    rnd = fallout.random(1, 5)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(144, 0, 0, -1)
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(1, 2))
    end
    rnd = fallout.random(1, 10)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(59, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
    end
    rnd = fallout.random(1, 10)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(52, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
    end
end

function Ghoul_Stuff(critter_obj)
    local rnd
    local item_obj

    item_obj = fallout.create_object_sid(41, 0, 0, -1)
    if fallout.has_trait(0, fallout.dude_obj(), 20) ~= 0 then
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(2, 20))
    else
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(0, 10))
    end
    rnd = fallout.random(1, 4)
    if rnd == 1 or rnd == 2 then
        item_obj = fallout.create_object_sid(4, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    elseif rnd == 3 then
        item_obj = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    end
    rnd = fallout.random(1, 4)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(71, 0, 0, -1)
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(1, 2))
    end
end

function Human_Stuff(critter_obj)
    local rnd
    local item_obj

    item_obj = fallout.create_object_sid(41, 0, 0, -1)
    if fallout.has_trait(0, fallout.dude_obj(), 20) ~= 0 then
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(8, 40))
    else
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(4, 20))
    end
    rnd = fallout.random(1, 10)
    if rnd <= 3 then
        item_obj = fallout.create_object_sid(7, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    elseif rnd > 3 and rnd <= 5 then
        item_obj = fallout.create_object_sid(236, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)
    elseif rnd > 5 and rnd <= 7 then
        item_obj = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)

        item_obj = fallout.create_object_sid(30, 0, 0, -1)
        if fallout.has_trait(0, fallout.dude_obj(), 40) ~= 0 then
            fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(2, 4))
        else
            fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(1, 2))
        end
    elseif rnd > 7 and rnd <= 9 then
        item_obj = fallout.create_object_sid(18, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)

        item_obj = fallout.create_object_sid(111, 0, 0, -1)
        if fallout.has_trait(0, fallout.dude_obj(), 40) ~= 0 then
            fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(2, 4))
        else
            fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(0, 2))
        end
    else
        item_obj = fallout.create_object_sid(10, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        fallout.wield_obj_critter(critter_obj, item_obj)

        item_obj = fallout.create_object_sid(34, 0, 0, -1)
        if fallout.has_trait(0, fallout.dude_obj(), 40) ~= 0 then
            fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(1, 2))
        else
            fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(0, 1))
        end
    end
    rnd = fallout.random(1, 3)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_mult_objs_to_inven(critter_obj, item_obj, fallout.random(1, 2))
    end
    rnd = fallout.random(1, 10)
    if rnd == 1 then
        item_obj = fallout.create_object_sid(47, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
