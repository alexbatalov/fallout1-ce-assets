local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local do_dialogue
local setend
local setcbt
local settime
local set00
local set00_2
local set01
local set01a
local set02
local set03
local set05
local set06
local set07
local set08
local set09_2
local set09
local set10
local set10a
local set11
local set12
local set12_2
local set13
local set13_2
local set14
local set15
local set16
local set17
local set17_2
local set18
local set19_2
local set19
local set20
local set21
local set21a
local set22
local set23
local set24
local set25
local set25_2
local set26
local set27
local set28
local set29
local set30
local set31
local set32
local set33
local set34
local set34_2
local set35
local set36
local set38
local set39
local set40
local set40_2
local set41
local set42
local set43
local set44
local set42_2
local set45
local set45a
local set46
local set47
local set48
local set49
local set50
local set51
local set52
local set52a
local set53
local set54
local set55
local set56
local set57
local set57_2
local set58
local set59
local set60
local set61
local set62
local set63
local set64
local set65
local set00a
local set00b
local set02a
local set04
local set09a
local set18a
local set200
local set201
local set202
local set203
local set204
local set205
local set206
local set207
local set208
local set209
local set300
local set301
local set302
local set303
local set304
local set305
local set306
local set307
local set308
local set309
local set310
local set311
local pickup_p_proc
local travel

local Hostile = 0
local initialized = false
local chip = 0
local setgone = 0

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 78)
        initialized = true
    else
        if fallout.script_action() == 22 then
            if fallout.fixed_param() == 1 then
                fallout.set_local_var(9, 1)
            end
        else
            if fallout.script_action() == 14 then
                Hostile = 1
            else
                if fallout.script_action() == 11 then
                    do_dialogue()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 12 then
                            if fallout.global_var(249) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                                if fallout.local_var(6) == 0 then
                                    fallout.dialogue_system_enter()
                                end
                            end
                            if Hostile then
                                Hostile = 0
                                fallout.set_global_var(249, 1)
                                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                            else
                                if fallout.local_var(4) == 0 then
                                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6) then
                                        fallout.dialogue_system_enter()
                                    end
                                else
                                    if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
                                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6) then
                                            fallout.dialogue_system_enter()
                                        end
                                    end
                                end
                            end
                        else
                            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                                fallout.script_overrides()
                                fallout.display_msg(fallout.message_str(15, 100))
                            else
                                if fallout.script_action() == 18 then
                                    fallout.set_global_var(553, 1)
                                    reputation.inc_evil_critter()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    reaction.get_reaction()
    fallout.start_gdialog(15, fallout.self_obj(), 4, 15, 4)
    fallout.gsay_start()
    if fallout.global_var(249) then
        Hostile = 1
    end
    if Hostile then
        set49()
    else
        if fallout.local_var(4) then
            if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
                set57()
            else
                if fallout.global_var(18) and (fallout.local_var(7) == 0) then
                    set52()
                else
                    if time.is_day() then
                        set207()
                    else
                        if fallout.global_var(29) >= 1 then
                            if fallout.local_var(5) == 1 then
                                set50()
                            end
                            if fallout.global_var(60) & 1 then
                                set42()
                            else
                                if fallout.global_var(59) == 1 then
                                    set29()
                                else
                                    if (fallout.global_var(29) == 2) or (fallout.global_var(306) ~= 0) then
                                        set18()
                                    else
                                        if fallout.local_var(9) then
                                            set25()
                                        else
                                            set51()
                                        end
                                    end
                                end
                            end
                        else
                            set51()
                        end
                    end
                end
            end
        else
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(600), 1)
            fallout.set_local_var(4, 1)
            if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
                set57()
            else
                if fallout.global_var(18) and (fallout.local_var(7) == 0) then
                    set52()
                else
                    if (fallout.global_var(29) == 2) or (fallout.global_var(306) ~= 0) then
                        set30()
                    else
                        if fallout.global_var(17) ~= 2 then
                            if fallout.global_var(59) == 1 then
                                set16()
                            else
                                set00()
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function setend()
end

function setcbt()
    Hostile = 1
end

function settime()
    setcbt()
end

function set00()
    fallout.gsay_reply(15, 101)
    fallout.giq_option(5, 15, 102, set00_2, 50)
    fallout.giq_option(4, 15, 103, set00a, 51)
    fallout.giq_option(4, 15, 104, set00b, 51)
    fallout.giq_option(-3, 15, 105, set05, 50)
end

function set00_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        reaction.UpReact()
        set01()
    else
        reaction.BigDownReact()
        set02()
    end
end

function set01()
    fallout.gsay_reply(15, 106)
    fallout.giq_option(7, 15, 107, set09, 50)
    fallout.giq_option(4, 15, 108, set01a, 50)
    fallout.giq_option(4, 15, 109, set14, 50)
end

function set01a()
    fallout.gsay_reply(15, 110)
    fallout.giq_option(0, 15, 111, set12, 50)
end

function set02()
    fallout.gsay_reply(15, 112)
    fallout.giq_option(5, 15, 113, set03, 51)
    fallout.giq_option(5, 15, 114, set02a, 49)
    fallout.giq_option(0, 15, 115, set01, 50)
end

function set03()
    fallout.gsay_message(15, 116, 51)
    setcbt()
end

function set05()
    fallout.gsay_reply(15, 121)
    fallout.giq_option(-3, 15, 122, set06, 50)
    fallout.giq_option(-3, 15, 123, set08, 50)
end

function set06()
    fallout.set_global_var(29, 1)
    fallout.gsay_reply(15, 124)
    fallout.giq_option(4, 15, 125, setend, 50)
    fallout.giq_option(4, 15, 126, set07, 50)
    fallout.giq_option(-3, 15, 127, setend, 50)
    fallout.giq_option(-3, 15, 128, set07, 50)
end

function set07()
    fallout.gsay_message(15, 129, 50)
    setend()
end

function set08()
    fallout.gsay_message(15, 130, 50)
    settime()
end

function set09_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        set10()
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            set03()
        else
            set04()
        end
    end
end

function set09()
    fallout.gsay_reply(15, 131)
    fallout.giq_option(6, 15, 132, set09_2, 50)
    fallout.giq_option(4, 15, 133, set09a, 51)
    fallout.giq_option(5, 15, 134, set15, 50)
end

function set10()
    fallout.gsay_reply(15, 135)
    fallout.giq_option(6, 15, 136, set10a, 50)
    fallout.giq_option(4, 15, 137, setcbt, 51)
end

function set10a()
    fallout.gsay_reply(15, 138)
    fallout.giq_option(6, 15, 139, set11, 50)
end

function set11()
    fallout.gsay_reply(15, 140)
    fallout.giq_option(5, 15, 141, set12, 50)
    fallout.giq_option(4, 15, 142, set08, 50)
end

function set12()
    fallout.gsay_reply(15, 143)
    fallout.giq_option(4, 15, 144, set06, 50)
    fallout.giq_option(4, 15, 145, set12_2, 51)
end

function set12_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        set08()
    else
        set03()
    end
end

function set13()
    fallout.gsay_reply(15, 146)
    fallout.giq_option(4, 15, 147, set06, 50)
    fallout.giq_option(4, 15, 148, set13_2, 51)
end

function set13_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        set08()
    else
        set03()
    end
end

function set14()
    fallout.gsay_reply(15, 149)
    fallout.giq_option(4, 15, 150, set12, 50)
    fallout.giq_option(5, 15, 151, set15, 50)
end

function set15()
    fallout.gsay_reply(15, 152)
    fallout.giq_option(4, 15, 153, set12, 50)
    fallout.giq_option(4, 15, 154, set12_2, 50)
    fallout.giq_option(4, 15, 155, set09a, 51)
end

function set16()
    fallout.gsay_reply(15, 156)
    fallout.giq_option(4, 15, 157, set17, 50)
    fallout.giq_option(4, 15, 158, set03, 51)
    fallout.giq_option(-3, 15, 159, set17, 50)
    fallout.giq_option(-3, 15, 160, set03, 51)
end

function set17()
    fallout.gsay_reply(15, 161)
    fallout.giq_option(7, 15, 162, set17_2, 50)
    fallout.giq_option(4, 15, 163, set06, 50)
    fallout.giq_option(4, 15, 164, set03, 51)
    fallout.giq_option(-3, 15, 159, set06, 50)
    fallout.giq_option(-3, 15, 160, set03, 51)
end

function set17_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        set09()
    else
        set03()
    end
end

function set18()
    fallout.set_global_var(60, fallout.global_var(60) | 1)
    fallout.gsay_reply(15, 165)
    fallout.giq_option(4, 15, 166, setend, 50)
    fallout.giq_option(4, 15, 167, set18a, 51)
    fallout.giq_option(-3, 15, 168, setend, 50)
end

function set19_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        set20()
    else
        set23()
    end
end

function set19()
    fallout.gsay_reply(15, 169)
    fallout.giq_option(5, 15, 170, set19_2, 50)
    fallout.giq_option(4, 15, 171, setend, 50)
    fallout.giq_option(4, 15, 172, set24, 50)
end

function set20()
    fallout.gsay_reply(15, 173)
    fallout.giq_option(4, 15, 174, set21, 50)
    fallout.giq_option(4, 15, 175, setend, 50)
end

function set21()
    fallout.gsay_reply(15, 176)
    fallout.giq_option(4, 15, 177, set22, 50)
    fallout.giq_option(4, 15, 178, set21a, 50)
end

function set21a()
    fallout.gsay_message(15, 179, 50)
    setend()
end

function set22()
    fallout.gsay_reply(15, 180)
    fallout.giq_option(5, 15, 181, setend, 50)
end

function set23()
    fallout.gsay_reply(15, 182)
    fallout.giq_option(4, 15, 183, setend, 50)
    fallout.giq_option(4, 15, 184, setcbt, 51)
end

function set24()
    fallout.gsay_reply(15, 185)
    fallout.giq_option(4, 15, 186, setend, 50)
    fallout.giq_option(4, 15, 187, setcbt, 51)
end

function set25()
    fallout.gsay_reply(15, 188)
    fallout.giq_option(5, 15, 189, set25_2, 50)
    fallout.giq_option(4, 15, 190, set28, 50)
    fallout.giq_option(-3, 15, 191, set28, 50)
end

function set25_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        set26()
    else
        set27()
    end
end

function set26()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(15, 192, 50)
    fallout.set_global_var(60, fallout.global_var(60) | 1)
    setend()
end

function set27()
    fallout.gsay_message(15, 193, 51)
    setcbt()
end

function set28()
    fallout.gsay_message(15, 194, 50)
    setend()
end

function set29()
    fallout.gsay_message(15, 195, 50)
    setcbt()
end

function set30()
    fallout.gsay_reply(15, 196)
    fallout.giq_option(5, 15, 197, set31, 50)
    fallout.giq_option(5, 15, 198, set34, 50)
    fallout.giq_option(4, 15, 199, set38, 50)
    fallout.giq_option(4, 15, 200, set40, 50)
    fallout.giq_option(-3, 15, 201, set41, 50)
end

function set31()
    fallout.gsay_reply(15, 202)
    fallout.giq_option(5, 15, 203, set32, 50)
    fallout.giq_option(5, 15, 204, setcbt, 51)
end

function set32()
    fallout.gsay_reply(15, 205)
    fallout.giq_option(4, 15, 206, setcbt, 51)
    fallout.giq_option(4, 15, 207, set33, 50)
end

function set33()
    fallout.set_global_var(60, fallout.global_var(60) | 1)
    fallout.gsay_reply(15, 208)
    setend()
end

function set34()
    fallout.gsay_reply(15, 209)
    fallout.giq_option(5, 15, 210, set18, 50)
    fallout.giq_option(5, 15, 211, set34_2, 50)
end

function set34_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        set35()
    else
        set36()
    end
end

function set35()
    fallout.gsay_message(15, 212, 50)
    setend()
end

function set36()
    fallout.set_global_var(60, fallout.global_var(60) | 1)
    fallout.gsay_message(15, 213, 50)
    setend()
end

function set38()
    fallout.gsay_reply(15, 214)
    fallout.giq_option(4, 15, 215, set39, 50)
    fallout.giq_option(4, 15, 216, setend, 50)
    fallout.giq_option(4, 15, 217, setcbt, 51)
end

function set39()
    fallout.set_global_var(60, fallout.global_var(60) | 1)
    fallout.gsay_message(15, 218, 50)
    setend()
end

function set40()
    fallout.gsay_reply(15, 219)
    fallout.giq_option(4, 15, 220, set40_2, 50)
    fallout.giq_option(4, 15, 221, setcbt, 51)
end

function set40_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        set34()
    else
        set48()
    end
end

function set41()
    fallout.gsay_reply(15, 222)
    fallout.giq_option(-3, 15, 223, set08, 50)
    fallout.giq_option(-3, 15, 224, setcbt, 51)
end

function set42()
    fallout.gsay_reply(15, 225)
    fallout.giq_option(4, 15, 226, set42_2, 50)
    fallout.giq_option(4, 15, 227, setcbt, 51)
    fallout.giq_option(4, 15, 228, setend, 50)
    fallout.giq_option(-3, 15, 229, setend, 50)
end

function set43()
    fallout.gsay_reply(15, 230)
    fallout.giq_option(7, 15, 231, set44, 50)
    fallout.giq_option(4, 15, 232, set47, 50)
    fallout.giq_option(4, 15, 233, set48, 51)
end

function set44()
    fallout.gsay_reply(15, 234)
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
        fallout.giq_option(13, 15, 235, set46, 50)
    end
    fallout.giq_option(4, 15, 236, setend, 50)
    fallout.giq_option(4, 15, 237, set45, 50)
end

function set42_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        set43()
    else
        set48()
    end
end

function set45()
    fallout.gsay_reply(15, 238)
    fallout.giq_option(4, 15, 239, setcbt, 51)
    fallout.giq_option(4, 15, 240, setend, 50)
    fallout.giq_option(4, 15, 241, set45a, 51)
end

function set45a()
    fallout.gsay_message(15, 242, 51)
    setcbt()
end

function set46()
    fallout.gsay_reply(15, 243)
    fallout.giq_option(4, 15, 244, setend, 50)
    fallout.giq_option(4, 15, 245, setcbt, 51)
end

function set47()
    fallout.gsay_message(15, 246, 50)
    setend()
end

function set48()
    fallout.gsay_message(15, 247, 51)
    setcbt()
end

function set49()
    if fallout.local_var(6) ~= 1 then
        fallout.set_local_var(6, 1)
        fallout.gsay_message(15, 248, 51)
    end
    setcbt()
end

function set50()
    fallout.set_local_var(5, 2)
    fallout.gsay_reply(15, 249)
    fallout.giq_option(5, 15, 250, setend, 50)
    fallout.giq_option(5, 15, 251, setcbt, 51)
end

function set51()
    fallout.gsay_message(15, 252, 50)
    setend()
end

function set52()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(15, 253)
    fallout.giq_option(4, 15, 254, set53, 49)
    fallout.giq_option(4, 15, 255, set03, 51)
    fallout.giq_option(-3, 15, 256, set52a, 49)
end

function set52a()
    fallout.gsay_reply(15, 257)
    fallout.giq_option(-3, 15, 258, set53, 49)
end

function set53()
    fallout.gsay_reply(15, 259)
    fallout.giq_option(5, 15, 260, set54, 50)
    fallout.giq_option(4, 15, 261, set56, 50)
    fallout.giq_option(4, 15, 262, setend, 50)
    fallout.giq_option(-3, 15, 263, set56, 50)
    fallout.giq_option(-3, 15, 264, setend, 50)
end

function set54()
    fallout.gsay_reply(15, 265)
    fallout.giq_option(4, 15, 266, set55, 50)
    fallout.giq_option(4, 15, 267, set56, 50)
end

function set55()
    setgone = 1
    fallout.gsay_message(15, 268, 50)
    setend()
end

function set56()
    fallout.set_global_var(60, fallout.global_var(60) | 2)
    fallout.gsay_message(15, 269, 50)
    setend()
end

function set57()
    fallout.gsay_reply(15, 270)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 98) then
        fallout.giq_option(6, 15, 271, set57_2, 50)
    end
    fallout.giq_option(4, 15, 272, set63, 51)
    fallout.giq_option(4, 15, 273, setcbt, 51)
    fallout.giq_option(4, 15, 274, set64, 50)
    fallout.giq_option(-3, 15, 275, set63, 50)
end

function set57_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        set58()
    else
        set62()
    end
end

function set58()
    fallout.gsay_reply(15, 276)
    fallout.giq_option(5, 15, 277, set59, 50)
    fallout.giq_option(4, 15, 278, set60, 51)
end

function set59()
    fallout.set_global_var(31, 1)
    fallout.set_global_var(227, 1)
    fallout.gsay_reply(15, 279)
    fallout.giq_option(4, 15, 280, travel, 50)
end

function set60()
    fallout.gsay_reply(15, 281)
    fallout.giq_option(4, 15, 282, set06, 50)
    fallout.giq_option(4, 15, 283, setcbt, 51)
end

function set61()
    fallout.gsay_message(15, 284, 51)
    setcbt()
end

function set62()
    fallout.gsay_reply(15, 285)
    fallout.giq_option(4, 15, 286, setcbt, 51)
end

function set63()
    fallout.gsay_reply(15, 287)
    fallout.giq_option(4, 15, 288, setcbt, 51)
    fallout.giq_option(-3, 15, 289, setcbt, 51)
end

function set64()
    fallout.gsay_reply(15, 290)
    fallout.giq_option(4, 15, 291, set63, 51)
    fallout.giq_option(4, 15, 292, set65, 50)
    fallout.giq_option(4, 15, 293, setcbt, 51)
end

function set65()
    chip = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 55)
    if chip ~= 0 then
        fallout.rm_obj_from_inven(fallout.dude_obj(), chip)
        fallout.set_global_var(30, 0)
    end
    fallout.gsay_message(15, 294, 51)
    reaction.BigDownReact()
end

function set00a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        set03()
    else
        set04()
    end
end

function set00b()
    reaction.BigDownReact()
    set02()
end

function set02a()
    reaction.UpReact()
    set01()
end

function set04()
    fallout.gsay_reply(15, 117)
    fallout.giq_option(4, 15, 118, setcbt, 51)
    fallout.giq_option(4, 15, 119, setcbt, 51)
    fallout.giq_option(-3, 15, 120, setcbt, 51)
end

function set09a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        set03()
    else
        set04()
    end
end

function set18a()
    reaction.BigDownReact()
    set19()
end

function set200()
    fallout.gsay_message(15, 295, 50)
end

function set201()
    fallout.gsay_message(15, 296, 50)
end

function set202()
    fallout.gsay_message(15, 297, 50)
end

function set203()
    fallout.gsay_message(15, 298, 50)
end

function set204()
    fallout.gsay_message(15, 299, 50)
end

function set205()
    fallout.gsay_message(15, 300, 50)
end

function set206()
    fallout.gsay_message(15, 301, 50)
end

function set207()
    fallout.gsay_message(15, 302, 50)
end

function set208()
    fallout.gsay_message(15, 303, 50)
end

function set209()
    fallout.gsay_message(15, 304, 50)
end

function set300()
    fallout.gsay_message(15, 305, 50)
end

function set301()
    fallout.gsay_message(15, 306, 50)
end

function set302()
    fallout.gsay_message(15, 307, 50)
end

function set303()
    fallout.gsay_message(15, 308, 50)
end

function set304()
    fallout.gsay_message(15, 309, 50)
end

function set305()
    fallout.gsay_message(15, 310, 50)
end

function set306()
    fallout.gsay_message(15, 311, 50)
end

function set307()
    fallout.gsay_message(15, 312, 50)
end

function set308()
    fallout.gsay_message(15, 313, 50)
end

function set309()
    fallout.gsay_message(15, 314, 50)
end

function set310()
    fallout.gsay_message(15, 315, 50)
end

function set311()
    fallout.gsay_message(15, 316, 50)
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        Hostile = 1
    end
end

function travel()
    fallout.load_map(5, 1)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
return exports
