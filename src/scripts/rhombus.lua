local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local do_dialogue
local rhombus01
local rhombus02
local rhombus03
local rhombus03_01
local rhombus04
local rhombus05
local rhombus06
local rhombus06a
local rhombus07
local rhombus08
local rhombus09
local rhombus09_1
local rhombus10
local rhombus11
local rhombus12
local rhombus13
local rhombus14
local rhombus15
local rhombus16
local rhombus17
local rhombus18
local rhombus19
local rhombus20
local rhombus21
local rhombus22
local rhombus22a
local rhombus23
local rhombus24
local rhombus25
local rhombus26
local rhombus27
local rhombus27_1
local rhombus28
local rhombus28_1
local rhombus28_2
local rhombus29
local rhombus30
local rhombus31
local rhombus32
local rhombus33
local rhombus35
local rhombus37
local rhombus38
local rhombus39
local rhombus40
local rhombus41
local rhombus42
local rhombus43
local rhombus44
local rhombus45
local rhombus46
local rhombus47
local rhombus48
local rhombus51
local rhombus51a
local rhombus52
local rhombus53
local rhombus54
local rhombus55
local rhombus56
local rhombusx
local rhombusx1
local rhombusx2
local rhombusok
local anger
local annoyed
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timeforwhat
local kickout
local Remove_Player

local MAD = 0
local Q1 = 0
local Q2 = 0
local Q4 = 0
local rndx = 0
local rndy = 0
local rndz = 0
local VATS = 0
local MALE = 0
local HOSTILE = 0
local ILLEGAL = 0
local Only_Once = 1
local here = 0
local conmod = 0
local loot = 0
local sense = 0
local denounce = 0
local Test = 0

local exit_line = 0

local rhombus00
local rhombus34
local rhombus39_1
local rhombus49

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 81)
    end
    if fallout.script_action() == 22 then
        timeforwhat()
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

function do_dialogue()
    fallout.start_gdialog(56, fallout.self_obj(), 4, 20, 5)
    reaction.get_reaction()
    fallout.gsay_start()
    MALE = fallout.get_critter_stat(fallout.dude_obj(), 34) == 0
    if ILLEGAL then
        ILLEGAL = 0
        conmod = (fallout.get_critter_stat(fallout.dude_obj(), 3) - 5) * 10
        if fallout.local_var(5) == 1 then
            rhombus51()
        else
            rhombus55()
        end
    else
        if MAD then
            if MAD < 3 then
                anger()
            else
                rhombus05()
            end
        else
            rhombus01()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if denounce == 1 then
        Remove_Player()
    end
end

function rhombus01()
    fallout.gsay_reply(56, 105)
    fallout.giq_option(4, 56, 106, rhombus02, 50)
    fallout.giq_option(4, 56, 107, rhombus03, 51)
    fallout.giq_option(-3, 56, 108, rhombus32, 50)
end

function rhombus02()
    fallout.gsay_reply(56, 109)
    rhombus00()
end

function rhombus03()
    reaction.DownReact()
    fallout.gsay_reply(56, 110)
    fallout.giq_option(4, 56, 111, rhombus03_01, 50)
    fallout.giq_option(4, 56, 112, rhombus05, 51)
end

function rhombus03_01()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        rhombus04()
    else
        rhombus06()
    end
end

function rhombus04()
    fallout.gsay_reply(56, 113)
    fallout.giq_option(4, 56, 114, rhombus02, 50)
    fallout.giq_option(4, 56, 115, rhombus05, 51)
end

function rhombus05()
    fallout.gsay_message(56, 116, 51)
    rhombusx1()
end

function rhombus06()
    anger()
end

function rhombus06a()
    reaction.DownReact()
    rhombus06()
end

function rhombus07()
    Q1 = Q1 + 1
    if Q1 > 4 then
        anger()
    else
        if Q1 > 3 then
            annoyed()
        else
            if Q1 > 1 then
                fallout.gsay_message(56, 179, 50)
            end
            fallout.gsay_reply(56, 118)
            fallout.giq_option(4, 56, 119, rhombus08, 50)
            fallout.giq_option(4, 56, 120, rhombus12, 50)
            fallout.giq_option(6, 56, 121, rhombus19, 50)
        end
    end
end

function rhombus08()
    fallout.gsay_reply(56, 122)
    fallout.giq_option(5, 56, 123, rhombus09, 50)
    fallout.giq_option(6, 56, 124, rhombus17, 50)
    fallout.giq_option(4, 56, 125, rhombus18, 51)
end

function rhombus09()
    fallout.gsay_reply(56, 126)
    fallout.giq_option(5, 56, 127, rhombus09_1, 50)
    fallout.giq_option(5, 56, 128, rhombus04, 50)
end

function rhombus09_1()
    if MALE then
        rhombus11()
    else
        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -1)) then
            rhombus10()
        else
            rhombus11()
        end
    end
end

function rhombus10()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(56, 129)
    fallout.giq_option(5, 56, 130, rhombus06a, 51)
    fallout.giq_option(5, 56, 131, rhombus02, 50)
end

function rhombus11()
    fallout.gsay_reply(56, 132)
    fallout.giq_option(5, 56, 133, rhombus06a, 51)
    fallout.giq_option(5, 56, 134, rhombus02, 50)
end

function rhombus12()
    fallout.gsay_reply(56, 135)
    fallout.giq_option(4, 56, 136, rhombus03, 51)
    fallout.giq_option(4, 56, 137, rhombus13, 50)
end

function rhombus13()
    fallout.gsay_reply(56, 138)
    fallout.giq_option(5, 56, 139, rhombus14, 50)
    fallout.giq_option(4, 56, 140, rhombus03, 51)
    fallout.giq_option(4, 56, 141, rhombus02, 50)
end

function rhombus14()
    fallout.gsay_reply(56, 142)
    fallout.giq_option(5, 56, 143, rhombus15, 50)
    fallout.giq_option(5, 56, 144, rhombus03, 51)
end

function rhombus15()
    fallout.gsay_reply(56, 145)
    fallout.giq_option(5, 56, 146, rhombus02, 50)
    fallout.giq_option(5, 56, 147, rhombus16, 50)
end

function rhombus16()
    fallout.gsay_message(56, 148, 50)
end

function rhombus17()
    fallout.gsay_reply(56, 149)
    fallout.giq_option(4, 56, 150, rhombus03, 51)
    fallout.giq_option(4, 56, 151, rhombus12, 50)
    fallout.giq_option(4, 56, 152, rhombus02, 50)
end

function rhombus18()
    fallout.gsay_message(56, 153, 50)
    rhombusx1()
end

function rhombus19()
    fallout.gsay_reply(56, 154)
    fallout.giq_option(5, 56, 155, rhombus20, 50)
    fallout.giq_option(4, 56, 156, rhombus13, 50)
end

function rhombus20()
    fallout.gsay_reply(56, 157)
    fallout.giq_option(5, 56, 158, rhombus02, 50)
end

function rhombus21()
    Q2 = Q2 + 1
    if Q2 > 4 then
        anger()
    else
        if Q2 > 3 then
            annoyed()
        else
            if Q2 == 2 then
                fallout.gsay_message(56, 180, 50)
            else
                if Q2 == 3 then
                    fallout.gsay_message(56, 179, 50)
                end
            end
            fallout.gsay_message(56, 159, 50)
            rhombus00()
        end
    end
end

function rhombus22()
    if fallout.local_var(6) == 0 then
        rhombus22a()
    else
        annoyed()
    end
end

function rhombus22a()
    fallout.gsay_reply(56, 160)
    fallout.giq_option(4, 56, 161, rhombus09_1, 50)
    fallout.giq_option(4, 56, 162, rhombus00, 50)
end

function rhombus23()
    Q4 = Q4 + 1
    if Q4 > 4 then
        anger()
    else
        if Q4 > 3 then
            annoyed()
        else
            if fallout.global_var(73) == 0 then
                fallout.set_global_var(73, 1)
            end
            if fallout.global_var(75) == 0 then
                fallout.set_global_var(75, 1)
            end
            if Q4 == 2 then
                fallout.gsay_message(56, 180, 50)
            else
                if Q4 == 3 then
                    fallout.gsay_message(56, 179, 50)
                end
            end
            fallout.gsay_message(56, 163, 50)
            rhombus00()
        end
    end
end

function rhombus24()
    reaction.DownReact()
    fallout.gsay_message(56, 164, 50)
end

function rhombus25()
    reaction.DownReact()
    fallout.gsay_message(56, 165, 50)
    rhombusx1()
end

function rhombus26()
    reaction.DownReact()
    fallout.gsay_message(56, 166, 50)
end

function rhombus27()
    reaction.DownReact()
    fallout.gsay_reply(56, 167)
    fallout.giq_option(4, 56, 168, rhombus27_1, 50)
    fallout.giq_option(4, 56, 169, rhombusx1, 50)
end

function rhombus27_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        rhombus28()
    else
        rhombus30()
    end
end

function rhombus28()
    fallout.gsay_reply(56, 170)
    fallout.giq_option(4, 56, 171, rhombus28_1, 50)
    fallout.giq_option(4, 56, 172, rhombus28_2, 50)
end

function rhombus28_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        rhombus29()
    else
        rhombus30()
    end
end

function rhombus28_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        rhombus29()
    else
        rhombus30()
    end
end

function rhombus29()
    fallout.gsay_reply(56, 173)
    fallout.giq_option(4, 56, 174, rhombusx2, 50)
    fallout.giq_option(4, 56, 175, rhombus05, 51)
end

function rhombus30()
    fallout.gsay_message(56, 176, 50)
    rhombusx1()
end

function rhombus31()
    rhombusx1()
end

function rhombus32()
    fallout.gsay_message(56, 177, 50)
end

function rhombus33()
    fallout.gsay_message(56, 178, 50)
end

function rhombus35()
    fallout.gsay_message(56, 180, 50)
end

function rhombus37()
    fallout.gsay_message(56, 182, 50)
end

function rhombus38()
    fallout.gsay_message(56, 183, 50)
end

function rhombus39()
    fallout.gsay_message(56, 184, 50)
end

function rhombus40()
    fallout.gsay_message(56, 186, 50)
end

function rhombus41()
    fallout.gsay_message(56, 187, 50)
end

function rhombus42()
    fallout.gsay_message(56, 188, 50)
end

function rhombus43()
    fallout.gsay_message(56, 189, 50)
end

function rhombus44()
    fallout.gsay_message(56, 190, 50)
end

function rhombus45()
    fallout.gsay_message(56, 191, 50)
end

function rhombus46()
    fallout.gsay_message(56, 192, 50)
end

function rhombus47()
    fallout.gsay_message(56, 193, 50)
end

function rhombus48()
    fallout.gsay_message(56, 194, 50)
end

function rhombus51()
    fallout.gsay_reply(56, 170)
    fallout.giq_option(4, 56, 172, rhombus51a, 50)
    fallout.giq_option(4, 56, 201, rhombus54, 51)
    fallout.giq_option(7, 56, 200, rhombus52, 49)
end

function rhombus51a()
    Test = fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)
    if fallout.is_success(Test) then
        rhombus52()
    else
        rhombus53()
    end
end

function rhombus52()
    fallout.gsay_reply(56, 173)
    fallout.giq_option(4, 56, 202, rhombusok, 50)
    fallout.giq_option(4, 56, 203, rhombus54, 51)
end

function rhombus53()
    fallout.gsay_message(56, 176, 51)
    kickout()
end

function rhombus54()
    fallout.gsay_message(56, 165, 51)
    kickout()
end

function rhombus55()
    fallout.gsay_reply(56, 167)
    fallout.giq_option(4, 56, 168, rhombus56, 51)
end

function rhombus56()
    Test = fallout.roll_vs_skill(fallout.dude_obj(), 14, conmod)
    if fallout.is_critical(Test) then
        combat()
    else
        kickout()
    end
end

function rhombusx()
end

function rhombusx1()
    combat()
end

function rhombusx2()
end

function rhombusok()
    fallout.critter_attempt_placement(fallout.dude_obj(), 22123, 0)
end

function anger()
    reaction.DownReact()
    MAD = MAD + 1
    if MAD == 1 then
        fallout.gsay_message(56, 182, 51)
    else
        if MAD == 2 then
            fallout.gsay_message(56, 117, 51)
        else
            if MAD == 3 then
                fallout.gsay_message(56, 177, 51)
                kickout()
            end
        end
    end
end

function annoyed()
    reaction.DownReact()
    fallout.gsay_message(56, 181, 51)
end

function combat()
    HOSTILE = 1
end

function critter_p_proc()
    if fallout.global_var(250) then
        HOSTILE = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        HOSTILE = 0
    end
    if HOSTILE then
        fallout.set_global_var(250, 1)
        HOSTILE = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (ILLEGAL == 0) then
            here = fallout.tile_num(fallout.dude_obj())
            if fallout.tile_distance(here, 24130) < 6 then
                ILLEGAL = 1
            else
                if fallout.tile_distance(here, 24322) < 6 then
                    ILLEGAL = 1
                end
            end
            if fallout.map_var(19) > 0 then
                ILLEGAL = 1
                fallout.set_map_var(19, 0)
            else
                if (fallout.tile_num(fallout.self_obj()) == 22123) and (fallout.tile_distance(here, 22930) < 3) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(56, 209), 3)
                end
            end
            if ILLEGAL then
                loot = 0
                loot = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 229)
                if loot then
                    fallout.rm_obj_from_inven(fallout.dude_obj(), loot)
                    fallout.add_obj_to_inven(fallout.external_var("locker_ptr"), loot)
                    fallout.display_msg(fallout.message_str(56, 207))
                end
                fallout.set_local_var(5, fallout.local_var(5) + 1)
                fallout.dialogue_system_enter()
            end
        else
            if (fallout.local_var(7) == 1) and (fallout.tile_num(fallout.self_obj()) ~= 22123) then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 22123, 0)
            else
                if (fallout.local_var(7) == 2) and (fallout.tile_num(fallout.self_obj()) ~= 23928) then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 23928, 0)
                else
                    if fallout.local_var(7) == 3 then
                        if fallout.local_var(5) > 0 then
                            sense = 0
                        else
                            sense = 1
                        end
                        if fallout.map_var(19) > sense then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(56, 206), 3)
                            fallout.set_map_var(19, 0)
                            fallout.set_local_var(7, 2)
                            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
                        else
                            if fallout.tile_num(fallout.self_obj()) ~= 23920 then
                                fallout.animate_move_obj_to_tile(fallout.self_obj(), 23920, 0)
                            end
                        end
                    else
                        if time.is_night() then
                            if fallout.local_var(8) == 0 then
                                fallout.set_local_var(8, 1)
                                fallout.set_local_var(7, 3)
                            end
                        else
                            fallout.set_local_var(8, 0)
                            fallout.set_local_var(7, 1)
                        end
                    end
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        HOSTILE = 1
    end
end

function talk_p_proc()
    do_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(56, 100))
end

function timeforwhat()
    if time.is_night() then
        if fallout.local_var(7) == 2 then
            fallout.set_local_var(7, 3)
        end
    end
end

function kickout()
    denounce = 1
end

function Remove_Player()
    fallout.set_global_var(108, 5)
    fallout.set_global_var(583, 0)
    fallout.set_global_var(584, 0)
    fallout.set_global_var(585, 0)
    fallout.set_global_var(586, 0)
    fallout.load_map(13, 1)
end

function rhombus00()
    fallout.gsay_reply(0, 0)
    fallout.giq_option(4, 56, 101, rhombus07, 50)
    fallout.giq_option(4, 56, 102, rhombus21, 50)
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 56, 103, rhombus22, 50)
    end
    fallout.giq_option(4, 56, 104, rhombus23, 50)
    fallout.giq_option(4, 56, 174, rhombusx, 50)
end

function rhombus34()
    fallout.gsay_message(56, 179, 50)
end

function rhombus39_1()
    fallout.gsay_message(56, 185, 50)
end

function rhombus49()
    fallout.gsay_message(56, 195, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
