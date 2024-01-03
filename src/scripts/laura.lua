local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 0
local g6 = 0
local g7 = 0
local g8 = 0
local g9 = 0
local g10 = 0
local g11 = 0
local g12 = 0
local g13 = 0
local g14 = 0
local g15 = 0

local start
local do_dialogue
local lauracbt
local laura01
local laura01a
local laura02
local laura03
local laura04
local laura09
local laura10
local laura11
local laura14
local laura15
local laura16
local laura16a
local laura21
local laura22
local laura23
local laura23_1
local laura24
local laura25
local laura26
local laura27
local laura28
local laura29
local laura30
local laura31
local laura32
local laura32a
local laura33
local laura34
local laura35
local laura36
local laura37
local laura38
local laura39
local laura40
local laura41
local laura42
local laura43
local laura44
local laura45
local laura46
local laura46_1
local laura47
local laura48
local laura49
local laura50
local laura51
local laura52
local laura53
local laura54
local laura55
local laura56
local laura57
local laura57_01
local laura58
local laura59
local laura60
local laura61
local laura62
local laura63
local laura64
local laura65
local laura67
local laura68
local laura69
local laura70
local laura71
local laura72
local laura73
local laura74
local laura75
local laura76
local laura77
local laura78
local laura79
local lauraxx
local laurax
local laurax1
local laurax2
local laurax3
local laurax4
local laurax5
local laurax6
local laurax7
local laurax8

-- ?import? variable rndx
-- ?import? variable rndy
-- ?import? variable rndz
-- ?import? variable rndu
-- ?import? variable MALE
-- ?import? variable HOSTILE
-- ?import? variable DESTROYED
-- ?import? variable KILLEDANY
-- ?import? variable CAPTURED
-- ?import? variable AFTERX
-- ?import? variable ILLEGAL
-- ?import? variable ILLEGBEFORE
-- ?import? variable TRESPASS
-- ?import? variable CRIME
-- ?import? variable CHILDREN
-- ?import? variable Black_Door_Ptr

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

-- ?import? variable exit_line

local laura67a
local laura68a
local laura69a
local laura70a
local laura71a
local laura72a
local laura73a
local laura74a
local laura75a
local laura76a
local laura77a
local laura78a
local laura79a
local laura80
local laura80a
local laura81
local laura81a
local laura82
local laura82a
local laura83
local laura83a
local laura84
local laura84a
local laura85
local laura85a
local laura86
local laura86a
local laura87
local laura87a
local laura88
local laura88a
local lauraend

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 18 then
            reputation.inc_good_critter()
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(48, 100))
            else
                if fallout.script_action() == 4 then
                    g5 = 1
                else
                    if fallout.script_action() == 12 then
                        fallout.set_external_var("Laura_Ptr", fallout.self_obj())
                        if fallout.local_var(4) == 1 then
                            fallout.set_local_var(4, 2)
                            fallout.set_local_var(9, 1)
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 14089, 0)
                        else
                            if (fallout.local_var(4) == 2) and (fallout.tile_num(fallout.self_obj()) ~= 14089) then
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 14089, 0)
                            else
                                if (fallout.local_var(4) == 2) and (fallout.tile_num(fallout.self_obj()) == 14089) then
                                    fallout.set_local_var(4, 3)
                                    fallout.obj_unlock(fallout.external_var("Red_Door_Ptr"))
                                    fallout.use_obj(fallout.external_var("Red_Door_Ptr"))
                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 12495, 0)
                                else
                                    if (fallout.local_var(4) == 3) and (fallout.tile_num(fallout.self_obj()) ~= 12495) then
                                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 12495, 0)
                                    else
                                        if (fallout.local_var(4) == 3) and (fallout.tile_num(fallout.self_obj()) == 12495) then
                                            fallout.set_local_var(4, 4)
                                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 12302, 0)
                                        else
                                            if fallout.local_var(4) == 4 then
                                                fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 178), 8)
                                                fallout.set_local_var(4, 5)
                                                fallout.set_local_var(9, 2)
                                            else
                                                if fallout.local_var(4) == 5 then
                                                    fallout.set_local_var(4, 6)
                                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 15099, 0)
                                                else
                                                    if (fallout.local_var(4) == 6) and (fallout.tile_num(fallout.self_obj()) ~= 15099) then
                                                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 15099, 0)
                                                    else
                                                        if (fallout.local_var(4) == 6) and (fallout.tile_num(fallout.self_obj()) == 15099) then
                                                            fallout.set_local_var(4, 7)
                                                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 23301, 0)
                                                        else
                                                            if (fallout.local_var(4) == 7) and (fallout.tile_num(fallout.self_obj()) ~= 23301) then
                                                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 23301, 0)
                                                            else
                                                                if (fallout.local_var(4) == 7) and (fallout.tile_num(fallout.self_obj()) == 23301) then
                                                                    fallout.set_local_var(4, 8)
                                                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 27106, 0)
                                                                else
                                                                    if (fallout.local_var(4) == 8) and (fallout.tile_num(fallout.self_obj()) ~= 27106) then
                                                                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 27106, 0)
                                                                    else
                                                                        if (fallout.local_var(4) == 8) and (fallout.tile_num(fallout.self_obj()) == 27106) then
                                                                            fallout.set_local_var(4, 9)
                                                                            fallout.set_obj_visibility(fallout.self_obj(), 1)
                                                                        else
                                                                            if fallout.local_var(5) == 1 then
                                                                                fallout.set_local_var(5, 2)
                                                                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 22090, 0)
                                                                            else
                                                                                if (fallout.local_var(5) == 2) and (fallout.tile_num(fallout.self_obj()) ~= 22090) then
                                                                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 22090, 0)
                                                                                else
                                                                                    if (fallout.local_var(5) == 2) and (fallout.tile_num(fallout.self_obj()) == 22090) then
                                                                                        fallout.set_local_var(5, 3)
                                                                                    else
                                                                                        if fallout.local_var(9) == 1 then
                                                                                            if (fallout.tile_num(fallout.self_obj()) == 22090) or (fallout.tile_num(fallout.self_obj()) == 12495) then
                                                                                                fallout.set_local_var(9, 0)
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
                                end
                            end
                        end
                        if g5 then
                            g5 = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    else
                        if fallout.script_action() == 22 then
                            g5 = 1
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    get_reaction()
    if fallout.local_var(9) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 177), 8)
    else
        if fallout.local_var(9) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 179), 8)
        else
            fallout.start_gdialog(48, fallout.self_obj(), 4, 3, 8)
            fallout.gsay_start()
            g4 = fallout.get_critter_stat(fallout.dude_obj(), 34) == 0
            if g10 then
                if g11 then
                    laura63()
                else
                    g11 = 1
                    if g13 == g12 then
                        laura65()
                    end
                    if g13 > g12 then
                        laura64()
                    end
                end
            else
                if fallout.local_var(6) ~= 0 then
                    if fallout.local_var(7) == 1 then
                        laura61()
                    else
                        if fallout.local_var(8) == 1 then
                            laura21()
                        else
                            laura16()
                        end
                    end
                else
                    fallout.set_local_var(6, 1)
                    laura01()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function lauracbt()
    g5 = 1
end

function laura01()
    if g4 then
        fallout.gsay_reply(48, 102)
    else
        fallout.gsay_reply(48, 104)
    end
    if fallout.global_var(61) == 1 then
        fallout.giq_option(4, 48, 105, laura02, 50)
    end
    fallout.giq_option(5, 48, 106, laura14, 50)
    fallout.giq_option(4, 48, 107, laura15, 51)
    fallout.giq_option(-3, 48, 108, laura01a, 50)
end

function laura01a()
    fallout.gsay_message(48, 110, 50)
    laurax()
end

function laura02()
    fallout.gsay_reply(48, 112)
    if fallout.global_var(61) == 1 then
        fallout.giq_option(4, 48, 113, laura03, 50)
    end
    fallout.giq_option(4, 48, 114, laura10, 50)
end

function laura03()
    fallout.gsay_reply(48, 116)
    if fallout.global_var(61) == 1 then
        fallout.giq_option(4, 48, 117, laura04, 50)
    end
    fallout.giq_option(4, 48, 118, laura09, 50)
end

function laura04()
    fallout.gsay_message(48, 120, 50)
    fallout.set_local_var(7, 1)
    laurax1()
end

function laura09()
    fallout.gsay_reply(48, 122)
    laurax()
end

function laura10()
    fallout.gsay_reply(48, 124)
    fallout.giq_option(4, 48, 125, laura03, 50)
    fallout.giq_option(4, 48, 126, laura11, 50)
end

function laura11()
    DownReact()
    fallout.gsay_message(48, 128, 50)
    laurax()
end

function laura14()
    fallout.gsay_message(48, 130, 50)
    laurax()
end

function laura15()
    DownReact()
    fallout.gsay_message(48, 132, 50)
    laurax()
end

function laura16()
    if fallout.local_var(1) > 1 then
        fallout.gsay_reply(48, 134)
    else
        fallout.gsay_reply(48, 136)
    end
    if fallout.global_var(61) == 1 then
        fallout.giq_option(4, 48, 137, laura02, 50)
    end
    fallout.giq_option(4, 48, 138, laura14, 50)
    fallout.giq_option(4, 48, 139, laurax, 50)
    fallout.giq_option(-3, 48, 140, laura16a, 50)
end

function laura16a()
    fallout.gsay_message(48, 142, 50)
    laurax()
end

function laura21()
    fallout.gsay_message(48, 144, 50)
    fallout.giq_option(4, 48, 145, laura22, 50)
end

function laura22()
    fallout.gsay_message(48, 147, 50)
    laura23()
end

function laura23()
    fallout.giq_option(5, 48, 148, laura24, 50)
    fallout.giq_option(4, 48, 149, laura33, 50)
    fallout.giq_option(4, 48, 150, laura23_1, 50)
    if g4 then
        fallout.giq_option(4, 48, 151, laura60, 50)
    end
    fallout.giq_option(4, 48, 152, laura59, 50)
end

function laura23_1()
    if fallout.global_var(52) == 0 then
        laura51()
    end
    if fallout.global_var(52) == 1 then
        laura38()
    end
    if fallout.global_var(52) == 2 then
        laura46()
    end
end

function laura24()
    fallout.gsay_reply(48, 154)
    fallout.giq_option(4, 48, 155, laura25, 50)
end

function laura25()
    fallout.gsay_reply(48, 157)
    fallout.giq_option(4, 48, 158, laura26, 50)
    fallout.giq_option(4, 48, 159, laura28, 50)
end

function laura26()
    fallout.gsay_reply(48, 161)
    fallout.giq_option(4, 48, 162, laura27, 50)
    fallout.giq_option(4, 48, 163, laura31, 50)
end

function laura27()
    fallout.gsay_reply(48, 165)
    fallout.giq_option(4, 48, 166, laura28, 50)
end

function laura28()
    fallout.gsay_reply(48, 168)
    fallout.giq_option(4, 48, 169, laura29, 50)
    fallout.giq_option(4, 48, 170, laura30, 50)
end

function laura29()
    fallout.gsay_reply(48, 172)
    laurax4()
end

function laura30()
    g3 = fallout.random(1, 2)
    if g3 == 1 then
        fallout.gsay_reply(48, 174)
    end
    if g3 == 2 then
        fallout.gsay_reply(48, 176)
    end
    laura23()
end

function laura31()
    fallout.gsay_reply(48, 178)
    fallout.giq_option(4, 48, 179, laura32a, 51)
    fallout.giq_option(4, 48, 180, laura30, 50)
end

function laura32()
    fallout.gsay_reply(48, 182)
    fallout.giq_option(4, 48, 183, laurax2, 51)
    fallout.giq_option(4, 48, 184, laurax8, 50)
    fallout.giq_option(4, 48, 185, laura30, 50)
end

function laura32a()
    DownReact()
    laura32()
end

function laura33()
    fallout.gsay_reply(48, 187)
    fallout.giq_option(4, 48, 188, laura34, 50)
    fallout.giq_option(4, 48, 189, laura35, 50)
end

function laura34()
    fallout.gsay_reply(48, 191)
    fallout.giq_option(6, 48, 192, laura36, 50)
    fallout.giq_option(4, 48, 193, laura36, 50)
end

function laura35()
    fallout.gsay_reply(48, 195)
    fallout.giq_option(6, 48, 196, laura36, 50)
    fallout.giq_option(4, 48, 197, laura36, 50)
end

function laura36()
    fallout.gsay_reply(48, 199)
    fallout.giq_option(4, 48, 200, laura37, 50)
end

function laura37()
    fallout.gsay_reply(48, 202)
    fallout.giq_option(4, 48, 203, laura28, 50)
    fallout.giq_option(4, 48, 204, laura27, 50)
end

function laura38()
    fallout.gsay_reply(48, 206)
    fallout.giq_option(4, 48, 207, laura39, 50)
    fallout.giq_option(4, 48, 208, laura43, 50)
end

function laura39()
    fallout.gsay_reply(48, 210)
    fallout.giq_option(4, 48, 211, laura40, 50)
    fallout.giq_option(4, 48, 212, laura42, 50)
end

function laura40()
    fallout.gsay_reply(48, 214)
    fallout.giq_option(4, 48, 215, laura30, 50)
    fallout.giq_option(4, 48, 216, laura41, 50)
end

function laura41()
    fallout.gsay_message(48, 218, 50)
    laurax6()
end

function laura42()
    fallout.gsay_reply(48, 220)
    fallout.giq_option(4, 48, 221, laura30, 50)
    fallout.giq_option(4, 48, 222, laura41, 50)
end

function laura43()
    fallout.gsay_reply(48, 224)
    fallout.giq_option(4, 48, 225, laura44, 50)
    fallout.giq_option(4, 48, 226, laura45, 50)
end

function laura44()
    fallout.gsay_reply(48, 228)
    fallout.giq_option(4, 48, 229, laura42, 50)
    fallout.giq_option(4, 48, 230, laura45, 50)
end

function laura45()
    fallout.gsay_reply(48, 232)
    fallout.giq_option(4, 48, 233, laura37, 50)
    fallout.giq_option(4, 48, 234, laura30, 50)
    fallout.giq_option(4, 48, 235, laura41, 50)
end

function laura46()
    fallout.gsay_reply(48, 237)
    fallout.giq_option(4, 48, 238, laura46_1, 50)
end

function laura46_1()
    if fallout.global_var(7) == 1 then
        laura46()
    end
    if fallout.global_var(14) == 1 then
        laura49()
    end
end

function laura47()
    fallout.gsay_reply(48, 240)
    fallout.giq_option(4, 48, 241, laura48, 50)
    fallout.giq_option(4, 48, 242, laura45, 50)
end

function laura48()
    fallout.gsay_reply(48, 244)
    fallout.giq_option(4, 48, 245, laura45, 50)
end

function laura49()
    fallout.gsay_reply(48, 247)
    fallout.giq_option(4, 48, 248, laura50, 50)
    fallout.giq_option(4, 48, 249, laura45, 50)
end

function laura50()
    fallout.gsay_reply(48, 251)
    fallout.giq_option(4, 48, 252, laura45, 50)
end

function laura51()
    fallout.gsay_reply(48, 254)
    fallout.giq_option(4, 48, 255, laura52, 50)
    fallout.giq_option(4, 48, 256, laura55, 50)
    fallout.giq_option(4, 48, 257, laura57, 50)
end

function laura52()
    fallout.gsay_reply(48, 259)
    fallout.giq_option(4, 48, 260, laura53, 50)
    fallout.giq_option(4, 48, 261, laura55, 50)
end

function laura53()
    fallout.gsay_reply(48, 263)
    fallout.giq_option(4, 48, 264, laura54, 50)
    fallout.giq_option(4, 48, 265, laura30, 50)
end

function laura54()
    fallout.gsay_reply(48, 267)
    laura23()
end

function laura55()
    fallout.gsay_reply(48, 269)
    fallout.giq_option(4, 48, 270, laura33, 50)
    fallout.giq_option(4, 48, 271, laura56, 50)
end

function laura56()
    fallout.gsay_reply(48, 273)
    laura23()
end

function laura57()
    fallout.gsay_reply(48, 275)
    fallout.giq_option(4, 48, 276, laura57_01, 50)
    fallout.giq_option(4, 48, 277, laura56, 50)
    fallout.giq_option(4, 48, 278, laura55, 50)
end

function laura57_01()
    DownReact()
    if fallout.local_var(1) > 1 then
        laura58()
    else
        laura32()
    end
end

function laura58()
    fallout.gsay_reply(48, 280)
    fallout.giq_option(6, 48, 281, laura32, 50)
    fallout.giq_option(4, 48, 282, laura23, 50)
end

function laura59()
    fallout.gsay_reply(48, 284)
    laurax7()
end

function laura60()
    fallout.gsay_reply(48, 286)
    laura23()
end

function laura61()
    if fallout.local_var(1) > 1 then
        fallout.gsay_reply(48, 288)
    else
        fallout.gsay_reply(48, 290)
    end
    fallout.giq_option(4, 48, 291, laura30, 50)
    fallout.giq_option(4, 48, 292, laura41, 50)
end

function laura62()
    DownReact()
    fallout.gsay_message(48, 294, 50)
end

function laura63()
    DownReact()
    fallout.gsay_reply(48, 296)
    fallout.giq_option(4, 48, 297, laurax2, 50)
    fallout.giq_option(4, 48, 298, laurax5, 50)
end

function laura64()
    DownReact()
    fallout.gsay_message(48, 300, 50)
end

function laura65()
    DownReact()
    fallout.gsay_reply(48, 302)
    fallout.giq_option(4, 48, 303, laurax2, 50)
    fallout.giq_option(4, 48, 304, laurax5, 50)
end

function laura67()
    fallout.gsay_message(48, 306, 50)
end

function laura68()
    fallout.gsay_message(48, 309, 50)
end

function laura69()
    fallout.gsay_message(48, 311, 50)
end

function laura70()
    fallout.gsay_message(48, 313, 50)
end

function laura71()
    fallout.gsay_message(48, 315, 50)
end

function laura72()
    fallout.gsay_message(48, 317, 50)
end

function laura73()
    fallout.gsay_message(48, 319, 50)
end

function laura74()
    fallout.gsay_message(48, 321, 50)
end

function laura75()
    fallout.gsay_message(48, 323, 50)
end

function laura76()
    fallout.gsay_message(48, 325, 50)
end

function laura77()
    fallout.gsay_message(48, 327, 50)
end

function laura78()
    fallout.gsay_message(48, 329, 50)
end

function laura79()
    fallout.gsay_message(48, 331, 50)
end

function lauraxx()
end

function laurax()
end

function laurax1()
    fallout.set_local_var(8, 1)
    fallout.set_local_var(5, 1)
    fallout.set_local_var(9, 1)
end

function laurax2()
    fallout.add_timer_event(fallout.self_obj(), 5, 1)
end

function laurax3()
end

function laurax4()
    fallout.set_local_var(4, 1)
    fallout.set_local_var(9, 1)
end

function laurax5()
    fallout.gfade_out(400)
    fallout.gfade_in(400)
end

function laurax6()
    fallout.set_local_var(5, 1)
    fallout.set_local_var(9, 1)
end

function laurax7()
end

function laurax8()
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if reputation.has_rep_champion() then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if reputation.has_rep_berserker() then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    g15 = fallout.message_str(634, fallout.random(100, 105))
end

function laura67a()
    fallout.gsay_message(48, 308, 50)
end

function laura68a()
    fallout.gsay_message(48, 310, 50)
end

function laura69a()
    fallout.gsay_message(48, 312, 50)
end

function laura70a()
    fallout.gsay_message(48, 314, 50)
end

function laura71a()
    fallout.gsay_message(48, 316, 50)
end

function laura72a()
    fallout.gsay_message(48, 318, 50)
end

function laura73a()
    fallout.gsay_message(48, 320, 50)
end

function laura74a()
    fallout.gsay_message(48, 322, 50)
end

function laura75a()
    fallout.gsay_message(48, 324, 50)
end

function laura76a()
    fallout.gsay_message(48, 326, 50)
end

function laura77a()
    fallout.gsay_message(48, 328, 50)
end

function laura78a()
    fallout.gsay_message(48, 330, 50)
end

function laura79a()
    fallout.gsay_message(48, 332, 50)
end

function laura80()
    fallout.gsay_message(48, 333, 50)
end

function laura80a()
    fallout.gsay_message(48, 334, 50)
end

function laura81()
    fallout.gsay_message(48, 335, 50)
end

function laura81a()
    fallout.gsay_message(48, 336, 50)
end

function laura82()
    fallout.gsay_message(48, 337, 50)
end

function laura82a()
    fallout.gsay_message(48, 338, 50)
end

function laura83()
    fallout.gsay_message(48, 339, 50)
end

function laura83a()
    fallout.gsay_message(48, 340, 50)
end

function laura84()
    fallout.gsay_message(48, 341, 50)
end

function laura84a()
    fallout.gsay_message(48, 342, 50)
end

function laura85()
    fallout.gsay_message(48, 343, 50)
end

function laura85a()
    fallout.gsay_message(48, 344, 50)
end

function laura86()
    fallout.gsay_message(48, 345, 50)
end

function laura86a()
    fallout.gsay_message(48, 346, 50)
end

function laura87()
    fallout.gsay_message(48, 347, 50)
end

function laura87a()
    fallout.gsay_message(48, 348, 50)
end

function laura88()
    fallout.gsay_message(48, 349, 50)
end

function laura88a()
    fallout.gsay_message(48, 350, 50)
end

function lauraend()
end

local exports = {}
exports.start = start
return exports
