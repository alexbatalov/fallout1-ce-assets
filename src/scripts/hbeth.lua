local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 1
local g2 = 0

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Beth00
local Beth01
local Beth02
local Beth02a
local Beth02b
local Beth03
local Beth03a
local Beth04
local Beth05
local Beth06
local Beth07
local Beth08
local Beth09
local Beth10
local Beth11
local Beth12
local Beth13
local Beth14
local Beth15
local Beth15a
local Beth16
local Beth16a
local Beth17
local Beth17a
local Beth17b
local Beth18
local Beth19
local Beth20
local Beth21
local Beth22
local Beth23
local Beth24
local Beth25
local Beth26
local Beth27
local Beth27a
local Beth28
local Beth29
local Beth30
local Beth31
local Beth32
local Beth33
local Beth34
local Beth35
local Beth35a
local Beth36
local Beth37
local Beth38
local Beth39
local Beth40
local Beth40a
local Beth41
local Beth42
local Beth43
local Beth44
local Beth45
local Beth46
local Beth47
local Beth48
local Beth49
local Beth50
local Beth52
local Beth52a
local Beth53
local Beth54
local Beth55
local Beth56
local Beth57
local Beth58
local Beth59
local Beth60
local Beth61
local Beth62
local Beth63
local Beth64
local Beth65
local Beth66
local Beth67
local Beth68
local Beth69
local BethEnd
local Get_Stuff
local Put_Stuff

-- ?import? variable hostile
-- ?import? variable Only_Once
-- ?import? variable Sid_Ptr

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

local Beth02c

function start()
    local v0 = 0
    if g1 then
        g1 = 0
        fallout.set_external_var("Beth_Ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 37)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    g0 = 1
end

function critter_p_proc()
    if g0 then
        g0 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        g0 = 1
    end
end

function talk_p_proc()
    local v0 = 0
    Get_Stuff()
    get_reaction()
    if ((time.game_time_in_days() - fallout.local_var(16)) >= 1) or (fallout.local_var(16) == 0) then
        fallout.set_local_var(16, time.game_time_in_days())
        fallout.set_local_var(17, 1000 + fallout.random(0, 1000))
        v0 = fallout.item_caps_adjust(fallout.self_obj(), fallout.local_var(17))
    else
        v0 = fallout.item_caps_adjust(fallout.self_obj(), fallout.local_var(17))
    end
    if fallout.map_var(10) == 1 then
        fallout.gdialog_set_barter_mod(5)
    else
        fallout.gdialog_set_barter_mod(-10)
    end
    fallout.set_map_var(33, 1)
    if fallout.local_var(11) == 0 then
        fallout.set_local_var(11, time.game_time_in_hours())
    end
    if time.is_night() then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(617, 361), 2)
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and (fallout.local_var(14) == 0) then
            Beth55()
        else
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and (fallout.local_var(14) == 1) then
                Beth56()
            else
                if fallout.local_var(4) == 1 then
                    fallout.start_gdialog(617, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    if fallout.local_var(1) > 1 then
                        Beth64()
                    else
                        Beth65()
                    end
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    fallout.set_local_var(4, 1)
                    fallout.start_gdialog(617, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Beth00()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
    fallout.set_local_var(11, time.game_time_in_hours())
    v0 = fallout.item_caps_adjust(fallout.self_obj(), -1 * fallout.item_caps_total(fallout.self_obj()))
    Put_Stuff()
end

function destroy_p_proc()
    fallout.move_obj_inven_to_obj(fallout.external_var("Beth_Box_Ptr"), fallout.self_obj())
    reputation.inc_good_critter()
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(617, 100))
end

function Beth00()
    fallout.gsay_reply(617, 101)
    Beth01()
end

function Beth01()
    fallout.giq_option(4, 617, 102, Beth09, 50)
    fallout.giq_option(4, 617, 104, Beth62, 49)
    fallout.giq_option(4, 617, 398, Beth68, 50)
    fallout.giq_option(4, 617, 105, Beth63, 50)
    fallout.giq_option(4, 617, 106, Beth06, 50)
    fallout.giq_option(4, 617, 107, BethEnd, 50)
    fallout.giq_option(-3, 617, 108, Beth04, 50)
end

function Beth02()
    if fallout.map_var(41) == 1 then
        fallout.giq_option(4, 617, 109, Beth36, 50)
    end
    if fallout.global_var(226) >= 1 then
        fallout.giq_option(4, 617, 110, Beth02a, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 617, 112, Beth02b, 50)
    end
    fallout.giq_option(4, 617, 398, Beth69, 50)
    fallout.giq_option(4, 617, 113, Beth23, 50)
    fallout.giq_option(4, 617, 114, Beth03a, 50)
    fallout.giq_option(4, 617, 115, BethEnd, 50)
end

function Beth02a()
    if fallout.global_var(226) == 5 then
        Beth37()
    else
        Beth38()
    end
end

function Beth02b()
    if fallout.global_var(203) ~= 0 then
        Beth66()
    else
        Beth14()
    end
end

function Beth03()
    if fallout.local_var(10) == 1 then
        if (fallout.local_var(5) == 0) and (fallout.global_var(203) == 2) then
            fallout.set_local_var(5, 1)
            fallout.set_global_var(219, 1)
            fallout.gsay_reply(617, 123)
        else
            if (fallout.local_var(6) == 0) and (fallout.global_var(203) == 2) then
                fallout.set_local_var(5, 1)
                fallout.gsay_reply(617, 124)
            else
                if (fallout.local_var(7) == 0) and (fallout.global_var(112) == 2) then
                    fallout.set_local_var(5, 1)
                    fallout.gsay_reply(617, 125)
                else
                    if (fallout.local_var(8) == 0) and (fallout.global_var(18) == 1) then
                        fallout.set_local_var(5, 1)
                        fallout.gsay_reply(617, 126)
                    else
                        if (fallout.local_var(9) == 0) and (fallout.global_var(17) == 1) then
                            fallout.set_local_var(5, 1)
                            fallout.gsay_reply(617, 127)
                        end
                    end
                end
            end
        end
    else
        fallout.set_local_var(10, 1)
        if (fallout.local_var(5) == 0) and (fallout.global_var(203) == 2) then
            fallout.set_local_var(5, 1)
            fallout.set_global_var(219, 1)
            fallout.gsay_reply(617, 117)
        else
            if (fallout.local_var(6) == 0) and (fallout.global_var(203) == 2) then
                fallout.set_local_var(5, 1)
                fallout.gsay_reply(617, 118)
            else
                if (fallout.local_var(7) == 0) and (fallout.global_var(112) == 2) then
                    fallout.set_local_var(5, 1)
                    fallout.gsay_reply(617, 119)
                else
                    if (fallout.local_var(8) == 0) and (fallout.global_var(18) == 1) then
                        fallout.set_local_var(5, 1)
                        fallout.gsay_reply(617, 121)
                    else
                        if (fallout.local_var(9) == 0) and (fallout.global_var(17) == 1) then
                            fallout.set_local_var(5, 1)
                            fallout.gsay_reply(617, 122)
                        end
                    end
                end
            end
        end
    end
    fallout.giq_option(4, 617, 128, Beth03a, 50)
    fallout.giq_option(4, 617, 129, Beth39, 50)
    fallout.giq_option(4, 617, 130, BethEnd, 50)
end

function Beth03a()
    if (fallout.local_var(5) == 0) and (fallout.global_var(203) == 2) or ((fallout.local_var(6) == 0) and (fallout.global_var(203) == 2)) or ((fallout.local_var(7) == 0) and (fallout.global_var(112) == 2)) or ((fallout.local_var(8) == 0) and (fallout.global_var(18) == 1)) or ((fallout.local_var(9) == 0) and (fallout.global_var(17) == 1)) then
        Beth03()
    else
        Beth12()
    end
end

function Beth04()
    fallout.gsay_reply(617, 131)
    fallout.giq_option(-3, 617, 132, Beth05, 50)
    fallout.giq_option(-3, 617, 133, Beth05, 50)
end

function Beth05()
    fallout.gsay_message(617, 134, 50)
end

function Beth06()
    fallout.gsay_reply(617, 135)
    fallout.giq_option(4, 617, 136, BethEnd, 50)
end

function Beth07()
    fallout.gsay_reply(617, 137)
    fallout.giq_option(4, 617, 138, Beth08, 50)
    fallout.giq_option(4, 617, 139, Beth11, 50)
end

function Beth08()
    fallout.gsay_reply(617, 140)
    Beth01()
end

function Beth09()
    fallout.gsay_reply(617, 141)
    Beth02()
end

function Beth10()
    fallout.gsay_reply(617, 142)
    Beth02()
end

function Beth11()
    fallout.gsay_message(617, 143, 50)
end

function Beth12()
    fallout.gsay_reply(617, 144)
    fallout.giq_option(4, 617, 145, Beth08, 50)
    fallout.giq_option(4, 617, 146, Beth13, 50)
end

function Beth13()
    fallout.gsay_message(617, 147, 50)
end

function Beth14()
    fallout.gsay_reply(617, 148)
    fallout.giq_option(4, 617, 149, Beth15, 50)
    fallout.giq_option(4, 617, 150, Beth20, 50)
end

function Beth15()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(617, 151)
    fallout.giq_option(4, 617, 152, Beth16, 50)
    if (fallout.map_var(46) >= 4) or (fallout.map_var(46) >= 4) then
        fallout.giq_option(4, 617, 153, Beth15a, 51)
    end
    fallout.giq_option(4, 617, 154, BethEnd, 50)
end

function Beth15a()
    BigDownReact()
    Beth21()
end

function Beth16()
    fallout.set_map_var(48, 1)
    fallout.gsay_reply(617, 155)
    if (fallout.map_var(46) >= 5) or (fallout.map_var(46) >= 5) then
        fallout.giq_option(4, 617, 156, Beth16a, 51)
    end
    fallout.giq_option(4, 617, 157, Beth17, 50)
    fallout.giq_option(4, 617, 158, Beth18, 50)
    fallout.giq_option(4, 617, 159, Beth18, 50)
end

function Beth16a()
    BottomReact()
    Beth22()
end

function Beth17()
    fallout.gsay_reply(617, 160)
    fallout.giq_option(4, 617, 161, Beth18, 50)
    fallout.giq_option(4, 617, 162, Beth17a, 51)
    fallout.giq_option(4, 617, 163, Beth17b, 51)
end

function Beth17a()
    DownReact()
    Beth19()
end

function Beth17b()
    BigDownReact()
    Beth19()
end

function Beth18()
    fallout.gsay_reply(617, 164)
    Beth02()
end

function Beth19()
    fallout.gsay_message(617, 165, 51)
end

function Beth20()
    fallout.gsay_reply(617, 166)
    Beth02()
end

function Beth21()
    fallout.gsay_message(617, 167, 51)
end

function Beth22()
    fallout.gsay_message(617, 168, 51)
end

function Beth23()
    fallout.gsay_reply(617, 169)
    Beth24()
end

function Beth24()
    fallout.giq_option(4, 617, 170, Beth25, 50)
    fallout.giq_option(4, 617, 172, Beth30, 50)
    fallout.giq_option(4, 617, 173, Beth33, 50)
    fallout.giq_option(4, 617, 174, Beth42, 50)
    fallout.giq_option(4, 617, 175, BethEnd, 50)
end

function Beth25()
    fallout.gsay_reply(617, 177)
    fallout.giq_option(4, 617, 178, Beth27, 50)
    if fallout.map_var(41) == 1 then
        fallout.giq_option(4, 617, 179, Beth34, 50)
    end
    fallout.giq_option(4, 617, 180, Beth26, 50)
    fallout.giq_option(4, 617, 181, BethEnd, 50)
end

function Beth26()
    fallout.gsay_reply(617, 182)
    Beth24()
end

function Beth27()
    fallout.gsay_reply(617, 183)
    fallout.giq_option(4, 617, 184, Beth28, 50)
    fallout.giq_option(4, 617, 185, Beth27a, 51)
    fallout.giq_option(4, 617, 186, Beth26, 50)
    fallout.giq_option(4, 617, 187, BethEnd, 50)
end

function Beth27a()
    BigDownReact()
    BethEnd()
end

function Beth28()
    fallout.gsay_reply(617, 188)
    fallout.giq_option(4, 617, 189, Beth29, 50)
    fallout.giq_option(4, 617, 190, Beth26, 50)
    fallout.giq_option(4, 617, 191, BethEnd, 50)
end

function Beth29()
    fallout.gsay_reply(617, 192)
    Beth24()
end

function Beth30()
    fallout.gsay_reply(617, 193)
    fallout.giq_option(4, 617, 194, Beth32, 50)
    fallout.giq_option(4, 617, 195, Beth31, 50)
    fallout.giq_option(4, 617, 196, Beth26, 50)
    fallout.giq_option(4, 617, 197, BethEnd, 50)
end

function Beth31()
    fallout.gsay_reply(617, 198)
    fallout.giq_option(4, 617, 199, Beth32, 50)
    fallout.giq_option(4, 617, 200, Beth26, 50)
    fallout.giq_option(4, 617, 201, BethEnd, 50)
end

function Beth32()
    fallout.gsay_reply(617, 202)
    fallout.giq_option(4, 617, 203, Beth31, 50)
    fallout.giq_option(4, 617, 204, Beth26, 50)
    fallout.giq_option(4, 617, 205, BethEnd, 50)
end

function Beth33()
    fallout.gsay_reply(617, 206)
    Beth24()
end

function Beth34()
    fallout.gsay_reply(617, 207)
    Beth35()
end

function Beth35()
    if fallout.map_var(41) == 1 then
        fallout.giq_option(4, 617, 208, Beth40, 50)
    end
    if fallout.global_var(226) >= 1 then
        fallout.giq_option(4, 617, 209, Beth46, 50)
    end
    if fallout.map_var(41) == 1 then
        fallout.giq_option(4, 617, 212, Beth35a, 50)
    end
    fallout.giq_option(4, 617, 213, Beth24, 50)
    fallout.giq_option(4, 617, 214, BethEnd, 50)
end

function Beth35a()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 3 then
        Beth54()
    else
        Beth53()
    end
end

function Beth36()
    fallout.gsay_reply(617, 215)
    Beth35()
end

function Beth37()
    fallout.gsay_reply(617, 216)
    Beth35()
end

function Beth38()
    fallout.gsay_reply(617, 217)
    Beth35()
end

function Beth39()
    fallout.gsay_reply(617, 218)
    Beth02()
end

function Beth40()
    fallout.gsay_reply(617, 219)
    fallout.giq_option(4, 617, 220, Beth43, 50)
    fallout.giq_option(4, 617, 221, Beth44, 50)
    fallout.giq_option(4, 617, 222, Beth35, 50)
    fallout.giq_option(4, 617, 223, Beth23, 50)
    fallout.giq_option(4, 617, 224, Beth40a, 51)
    fallout.giq_option(4, 617, 225, BethEnd, 50)
end

function Beth40a()
    BigDownReact()
    Beth41()
end

function Beth41()
    fallout.gsay_message(617, 226, 51)
end

function Beth42()
    fallout.gsay_reply(617, 227)
    Beth24()
end

function Beth43()
    fallout.gsay_reply(617, 228)
    fallout.giq_option(4, 617, 229, Beth44, 50)
    fallout.giq_option(4, 617, 230, Beth35, 50)
    fallout.giq_option(4, 617, 231, Beth23, 50)
    fallout.giq_option(4, 617, 232, BethEnd, 50)
end

function Beth44()
    fallout.gsay_reply(617, 233)
    fallout.giq_option(4, 617, 234, Beth44, 50)
    fallout.giq_option(4, 617, 235, Beth35, 50)
    fallout.giq_option(4, 617, 236, Beth23, 50)
    fallout.giq_option(4, 617, 237, Beth45, 51)
    fallout.giq_option(4, 617, 238, BethEnd, 50)
end

function Beth45()
    BigDownReact()
    fallout.gsay_message(617, 239, 51)
end

function Beth46()
    fallout.gsay_reply(617, 240)
    fallout.giq_option(4, 617, 241, Beth47, 50)
    fallout.giq_option(4, 617, 242, Beth49, 51)
    fallout.giq_option(4, 617, 243, Beth47, 50)
    fallout.giq_option(4, 617, 244, Beth50, 50)
end

function Beth47()
    fallout.set_global_var(226, 2)
    fallout.gsay_reply(617, 245)
    fallout.giq_option(4, 617, 246, Beth48, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 617, 247, Beth49, 51)
    else
        fallout.giq_option(4, 617, 248, Beth49, 51)
    end
    fallout.giq_option(4, 617, 249, Beth35, 50)
    fallout.giq_option(4, 617, 250, Beth23, 50)
    fallout.giq_option(4, 617, 251, BethEnd, 50)
end

function Beth48()
    fallout.gsay_reply(617, 252)
    fallout.giq_option(4, 617, 253, Beth35, 50)
    fallout.giq_option(4, 617, 254, Beth23, 50)
    fallout.giq_option(4, 617, 255, BethEnd, 50)
end

function Beth49()
    fallout.gsay_message(617, 256, 51)
end

function Beth50()
    fallout.set_global_var(226, 2)
    fallout.gsay_reply(617, 257)
    fallout.giq_option(4, 617, 258, Beth35, 50)
    fallout.giq_option(4, 617, 259, Beth23, 50)
    fallout.giq_option(4, 617, 394, Beth48, 50)
    fallout.giq_option(4, 617, 260, BethEnd, 50)
end

function Beth52()
    fallout.gsay_reply(617, 266)
    fallout.giq_option(4, 617, 267, Beth35, 50)
    fallout.giq_option(4, 617, 268, Beth23, 50)
    fallout.giq_option(4, 617, 269, Beth52a, 51)
    fallout.giq_option(4, 617, 270, BethEnd, 50)
end

function Beth52a()
    DownReact()
    BethEnd()
end

function Beth53()
    fallout.gsay_reply(617, 271)
    if fallout.global_var(108) == 2 then
        fallout.giq_option(4, 617, 272, Beth57, 50)
        fallout.giq_option(4, 617, 273, Beth59, 50)
    else
        if fallout.global_var(74) == 2 then
            fallout.giq_option(4, 617, 274, Beth58, 50)
        else
            fallout.giq_option(4, 617, 275, Beth58, 50)
        end
    end
end

function Beth54()
    fallout.gsay_reply(617, 276)
    if fallout.global_var(108) == 2 then
        fallout.giq_option(4, 617, 277, Beth61, 50)
    end
    fallout.giq_option(4, 617, 278, Beth57, 50)
    fallout.giq_option(4, 617, 279, Beth58, 50)
end

function Beth55()
    fallout.set_local_var(14, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(617, 280), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(617, 281), 2)
    end
end

function Beth56()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(617, 282), 2)
end

function Beth57()
    fallout.gsay_reply(617, 283)
    Beth60()
end

function Beth58()
    fallout.gsay_reply(617, 284)
    Beth60()
end

function Beth59()
    fallout.gsay_reply(617, 285)
    Beth60()
end

function Beth60()
    fallout.giq_option(4, 617, 286, Beth35, 50)
    fallout.giq_option(4, 617, 287, Beth23, 50)
    fallout.giq_option(4, 617, 288, BethEnd, 50)
end

function Beth61()
    fallout.gsay_reply(617, 289)
    Beth60()
end

function Beth62()
    fallout.gsay_message(617, fallout.random(290, 295), 50)
    if fallout.map_var(10) == 1 then
        fallout.gsay_message(617, 297, 49)
        fallout.gdialog_mod_barter(5)
        fallout.gsay_reply(617, 395)
        fallout.giq_option(4, 617, 396, BethEnd, 50)
        fallout.giq_option(-3, 617, 397, BethEnd, 50)
    else
        fallout.gdialog_mod_barter(-10)
        fallout.gsay_reply(617, 395)
        fallout.giq_option(4, 617, 396, BethEnd, 50)
        fallout.giq_option(-3, 617, 397, BethEnd, 50)
    end
end

function Beth63()
    fallout.gsay_message(617, fallout.random(300, 305), 50)
    if fallout.map_var(10) == 1 then
        fallout.gsay_message(617, 297, 49)
        fallout.gdialog_mod_barter(5)
        fallout.gsay_reply(617, 395)
        fallout.giq_option(4, 617, 396, BethEnd, 50)
        fallout.giq_option(-3, 617, 397, BethEnd, 50)
    else
        fallout.gdialog_mod_barter(-10)
        fallout.gsay_reply(617, 395)
        fallout.giq_option(4, 617, 396, BethEnd, 50)
        fallout.giq_option(-3, 617, 397, BethEnd, 50)
    end
end

function Beth64()
    if (fallout.get_critter_stat(fallout.dude_obj(), 3) >= 7) and (fallout.get_critter_stat(fallout.dude_obj(), 34) == 0) then
        if ((time.game_time_in_hours() - fallout.local_var(11)) <= 1) and (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1) then
            fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 314)) .. " " .. fallout.message_str(617, 315))
        else
            if (time.game_time_in_hours() - fallout.local_var(11)) <= 1 then
                fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 314)) .. " " .. fallout.message_str(617, 316))
            else
                if ((time.game_time_in_hours() - fallout.local_var(11)) > 1) and ((time.game_time_in_hours() - fallout.local_var(11)) <= 96) then
                    fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 314)) .. " " .. fallout.message_str(617, 317))
                else
                    if ((time.game_time_in_hours() - fallout.local_var(11)) > 96) and ((time.game_time_in_hours() - fallout.local_var(11)) <= 168) then
                        fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 314)) .. " " .. fallout.message_str(617, 318))
                    else
                        if ((time.game_time_in_hours() - fallout.local_var(11)) > 168) and ((time.game_time_in_hours() - fallout.local_var(11)) <= 336) then
                            fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 314)) .. " " .. fallout.message_str(617, 319))
                        else
                            if (time.game_time_in_hours() - fallout.local_var(11)) > 336 then
                                fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 314)) .. " " .. fallout.message_str(617, 320))
                            end
                        end
                    end
                end
            end
        end
    else
        if ((time.game_time_in_hours() - fallout.local_var(11)) <= 1) and (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1) then
            fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 313)) .. " " .. fallout.message_str(617, 315))
        else
            if (time.game_time_in_hours() - fallout.local_var(11)) <= 1 then
                fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 313)) .. " " .. fallout.message_str(617, 316))
            else
                if ((time.game_time_in_hours() - fallout.local_var(11)) > 1) and ((time.game_time_in_hours() - fallout.local_var(11)) <= 96) then
                    fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 313)) .. " " .. fallout.message_str(617, 317))
                else
                    if ((time.game_time_in_hours() - fallout.local_var(11)) > 96) and ((time.game_time_in_hours() - fallout.local_var(11)) <= 168) then
                        fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 313)) .. " " .. fallout.message_str(617, 318))
                    else
                        if ((time.game_time_in_hours() - fallout.local_var(11)) > 168) and ((time.game_time_in_hours() - fallout.local_var(11)) <= 336) then
                            fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 313)) .. " " .. fallout.message_str(617, 319))
                        else
                            if (time.game_time_in_hours() - fallout.local_var(11)) > 336 then
                                fallout.gsay_reply(617, fallout.message_str(617, fallout.random(311, 313)) .. " " .. fallout.message_str(617, 320))
                            end
                        end
                    end
                end
            end
        end
    end
    Beth01()
end

function Beth65()
    fallout.gsay_reply(617, fallout.random(322, 329))
    Beth01()
end

function Beth66()
    if fallout.local_var(12) == 0 then
        fallout.set_local_var(12, 1)
        fallout.gsay_reply(617, 330)
    else
        fallout.gsay_reply(617, 331)
    end
    fallout.giq_option(4, 617, 332, Beth18, 50)
    if fallout.local_var(13) == 0 then
        fallout.giq_option(4, 617, 333, Beth67, 50)
    end
end

function Beth67()
    local v0 = 0
    fallout.set_local_var(13, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(617, 334, 49)
    else
        fallout.gsay_message(617, 335, 49)
    end
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
end

function Beth68()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(617, 399)
    Beth01()
end

function Beth69()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(617, 399)
    Beth02()
end

function BethEnd()
end

function Get_Stuff()
    fallout.move_obj_inven_to_obj(fallout.external_var("Beth_Box_Ptr"), fallout.self_obj())
end

function Put_Stuff()
    fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Beth_Box_Ptr"))
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
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
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
    g2 = fallout.message_str(634, fallout.random(100, 105))
end

function Beth02c()
    if (fallout.local_var(5) == 0) and (fallout.global_var(203) == 2) or ((fallout.local_var(6) == 0) and (fallout.global_var(203) == 2)) or ((fallout.local_var(7) == 0) and (fallout.global_var(112) == 2)) or ((fallout.local_var(8) == 0) and (fallout.global_var(18) == 1)) or ((fallout.local_var(9) == 0) and (fallout.global_var(17) == 1)) then
        Beth03()
    else
        Beth07()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
