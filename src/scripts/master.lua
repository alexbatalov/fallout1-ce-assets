local fallout = require("fallout")
local time = require("lib.time")

local start
local gameover
local giveme
local do_dialogue
local master00
local master01
local master02
local master03
local master04
local master05
local master06
local master06_1
local master07
local master08
local master08_1
local master09
local master10
local master11
local master11_1
local master12
local master13
local master14
local master16
local master17
local master17_1
local master18
local master19
local master20
local master21
local master21_1
local master22
local master23
local master24
local master25
local master26
local master27
local master28
local master29
local master30
local master31
local master32
local master33
local master34
local master35
local master36
local master37
local master38
local master38_1
local master38_2
local master39
local master40
local master41
local master42
local master43
local master44
local master45
local master46
local master47
local master200
local master201
local master202
local master203
local mastercbt
local masterend
local damage_p_proc
local combat_p_proc
local map_enter_p_proc

local MALE = 0
local HOSTILE = 0
local DISARM = 0
local Only_ONce = 1
local LIEUTENANTS = 0
local everyother = 1
local wimpyother = 1
local so_long = 0

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

local exit_line = 0

function start()
    if Only_ONce then
        Only_ONce = 0
        fallout.set_external_var("Master_Ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 55)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 70)
    end
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    end
    if fallout.script_action() == 14 then
        damage_p_proc()
    end
    if fallout.script_action() == 13 then
        combat_p_proc()
    end
    if fallout.script_action() == 11 then
        if fallout.global_var(18) == 0 then
            do_dialogue()
        end
    else
        if fallout.script_action() == 18 then
            if fallout.source_obj() == fallout.dude_obj() then
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                    fallout.set_global_var(156, 1)
                    fallout.set_global_var(157, 0)
                end
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    fallout.set_global_var(157, 1)
                    fallout.set_global_var(156, 0)
                end
                fallout.set_global_var(160, fallout.global_var(160) + 1)
                if (fallout.global_var(160) % 6) == 0 then
                    fallout.set_global_var(155, fallout.global_var(155) + 1)
                end
            end
            fallout.set_global_var(18, 1)
            if fallout.global_var(17) == 0 then
                fallout.set_global_var(51, 1)
            end
            fallout.set_global_var(309, 2)
            if fallout.global_var(55) == 0 then
                fallout.set_global_var(55, time.game_time_in_seconds())
            end
        else
            if fallout.script_action() == 21 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(51, 100))
            else
                if fallout.script_action() == 22 then
                    fallout.set_global_var(241, 3)
                    fallout.dialogue_system_enter()
                else
                    if fallout.script_action() == 12 then
                        if fallout.local_var(5) then
                            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                                HOSTILE = 1
                            end
                        end
                        if HOSTILE then
                            fallout.set_local_var(5, 1)
                            HOSTILE = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                        if fallout.global_var(241) == 2 then
                        else
                            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 10 then
                                fallout.dialogue_system_enter()
                            end
                        end
                    end
                end
            end
        end
    end
end

function gameover()
    so_long = 1
end

function giveme()
    local v0 = 0
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 194) then
        v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 194)
        fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
        fallout.destroy_object(v0)
        master14()
    else
        master13()
    end
end

function do_dialogue()
    get_reaction()
    fallout.start_gdialog(51, fallout.self_obj(), 4, 6, 11)
    fallout.gsay_start()
    MALE = fallout.get_critter_stat(fallout.dude_obj(), 34) == 0
    if fallout.local_var(5) then
        master203()
    else
        if fallout.local_var(4) then
            if fallout.global_var(56) then
                master46()
            else
                if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -1)) then
                    master43()
                else
                    master44()
                end
            end
        else
            fallout.set_local_var(4, 1)
            master00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if so_long then
        fallout.play_gmovie(10)
        fallout.play_gmovie(7)
        fallout.metarule(13, 0)
    end
end

function master00()
    fallout.gsay_reply(51, 101)
    fallout.giq_option(4, 51, 102, master01, 50)
    fallout.giq_option(6, 51, 103, master04, 50)
    fallout.giq_option(4, 51, 104, mastercbt, 51)
    fallout.giq_option(5, 51, 105, master38, 50)
    fallout.giq_option(-3, 51, 106, master42, 50)
end

function master01()
    fallout.gsay_reply(51, 107)
    fallout.giq_option(4, 51, 108, master02, 50)
    fallout.giq_option(4, 51, 109, gameover, 50)
end

function master02()
    fallout.gsay_reply(51, 110)
    fallout.giq_option(4, 51, 111, master03, 51)
    fallout.giq_option(4, 51, 112, gameover, 50)
end

function master03()
    fallout.gsay_message(51, 113, 51)
    mastercbt()
end

function master04()
    fallout.gsay_reply(51, 114)
    fallout.giq_option(6, 51, 115, master36, 50)
    fallout.giq_option(5, 51, 116, master05, 50)
end

function master05()
    fallout.gsay_reply(51, 117)
    fallout.giq_option(4, 51, 118, master06, 50)
end

function master06()
    fallout.gsay_reply(51, 119)
    fallout.giq_option(6, 51, 120, master06_1, 50)
    fallout.giq_option(4, 51, 121, master27, 51)
end

function master06_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        master07()
    else
        master35()
    end
end

function master07()
    fallout.gsay_reply(51, 122)
    fallout.giq_option(7, 51, 123, master08, 50)
    fallout.giq_option(6, 51, 124, master33, 51)
    fallout.giq_option(5, 51, 125, master31, 50)
end

function master08()
    fallout.gsay_reply(51, 126)
    fallout.giq_option(5, 51, 127, master08_1, 50)
    fallout.giq_option(4, 51, 128, master01, 49)
    fallout.giq_option(4, 51, 129, mastercbt, 51)
end

function master08_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        master09()
    else
        master30()
    end
end

function master09()
    fallout.gsay_reply(51, 130)
    fallout.giq_option(5, 51, 131, mastercbt, 51)
    fallout.giq_option(6, 51, 132, master10, 50)
    if fallout.obj_carrying_pid_obj(fallout.dude_obj(), 194) or fallout.global_var(310) then
        fallout.giq_option(7, 51, 133, master11, 50)
    end
end

function master10()
    fallout.gsay_message(51, 134, 51)
    mastercbt()
end

function master11()
    fallout.gsay_reply(51, 135)
    fallout.giq_option(6, 51, 136, master11_1, 50)
    fallout.giq_option(6, 51, 137, master20, 50)
    fallout.giq_option(4, 51, 138, master28, 50)
end

function master11_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        master12()
    else
        master29()
    end
end

function master12()
    fallout.gsay_reply(51, 139)
    fallout.giq_option(6, 51, 140, giveme, 50)
    fallout.giq_option(5, 51, 141, master26, 50)
    fallout.giq_option(6, 51, 142, master20, 50)
end

function master13()
    fallout.gsay_message(51, 143, 51)
    mastercbt()
end

function master14()
    fallout.game_time_advance(fallout.game_ticks(180))
    fallout.gsay_reply(51, 145)
    fallout.giq_option(5, 51, 146, master16, 50)
    fallout.giq_option(5, 51, 147, master17, 50)
end

function master16()
    fallout.gsay_message(51, 148, 51)
    mastercbt()
end

function master17()
    fallout.gsay_reply(51, 149)
    fallout.giq_option(6, 51, 150, master17_1, 50)
    fallout.giq_option(6, 51, 151, master18, 50)
end

function master17_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        master19()
    else
        master16()
    end
end

function master18()
    fallout.gsay_message(51, 152, 51)
    mastercbt()
end

function master19()
    fallout.gsay_message(51, 153, 50)
    fallout.set_external_var("MASTER_HAS_ARMED", 1)
    if fallout.global_var(55) == 0 then
        fallout.set_global_var(55, time.game_time_in_seconds())
        fallout.set_global_var(18, 1)
        if fallout.global_var(17) == 0 then
            fallout.set_global_var(51, 1)
        end
        fallout.set_global_var(309, 2)
    end
end

function master20()
    fallout.gsay_message(51, 154, 50)
    master21()
end

function master21()
    fallout.gsay_reply(51, 155)
    fallout.giq_option(6, 51, 156, master25, 50)
    fallout.giq_option(6, 51, 157, master21_1, 50)
    fallout.giq_option(6, 51, 158, master24, 50)
end

function master21_1()
    if fallout.global_var(54) == 1 then
        master22()
    else
        master23()
    end
end

function master22()
    fallout.gsay_message(51, 159, 51)
    mastercbt()
end

function master23()
    fallout.gsay_message(51, 160, 51)
    mastercbt()
end

function master24()
    fallout.gsay_message(51, 161, 51)
    mastercbt()
end

function master25()
    fallout.gsay_reply(51, 162)
    fallout.giq_option(6, 51, 163, master17, 50)
    fallout.giq_option(6, 51, 164, master16, 50)
end

function master26()
    fallout.gsay_reply(51, 165)
    fallout.giq_option(4, 51, 166, mastercbt, 51)
    fallout.giq_option(4, 51, 167, master01, 49)
end

function master27()
    fallout.gsay_reply(51, 168)
    fallout.giq_option(4, 51, 169, mastercbt, 51)
    fallout.giq_option(4, 51, 170, master01, 50)
end

function master28()
    fallout.gsay_message(51, 171, 51)
    mastercbt()
end

function master29()
    fallout.gsay_message(51, 172, 51)
    mastercbt()
end

function master30()
    fallout.gsay_reply(51, 173)
    fallout.giq_option(4, 51, 174, mastercbt, 51)
    fallout.giq_option(4, 51, 175, master01, 50)
end

function master31()
    fallout.gsay_reply(51, 176)
    fallout.giq_option(5, 51, 177, master32, 50)
    fallout.giq_option(5, 51, 178, mastercbt, 51)
end

function master32()
    fallout.gsay_reply(51, 179)
    fallout.giq_option(5, 51, 180, mastercbt, 51)
    fallout.giq_option(5, 51, 181, master01, 49)
end

function master33()
    fallout.gsay_reply(51, 182)
    fallout.giq_option(4, 51, 183, master34, 50)
end

function master34()
    fallout.gsay_reply(51, 184)
    fallout.giq_option(4, 51, 185, master01, 50)
    fallout.giq_option(4, 51, 186, mastercbt, 51)
end

function master35()
    fallout.gsay_reply(51, 187)
    fallout.giq_option(4, 51, 188, master01, 50)
    fallout.giq_option(4, 51, 189, mastercbt, 51)
    fallout.giq_option(5, 51, 190, master33, 50)
end

function master36()
    fallout.gsay_reply(51, 191)
    fallout.giq_option(5, 51, 192, master06, 50)
    fallout.giq_option(5, 51, 193, master37, 51)
end

function master37()
    fallout.gsay_message(51, 194, 51)
    mastercbt()
end

function master38()
    fallout.gsay_reply(51, 195)
    fallout.giq_option(5, 51, 197, mastercbt, 51)
    if (fallout.global_var(108) == 1) or (fallout.global_var(108) == 2) then
        fallout.giq_option(5, 51, 198, master38_2, 50)
    end
end

function master38_1()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        master41()
    else
        master40()
    end
end

function master38_2()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        master39()
    else
        master40()
    end
end

function master39()
    fallout.gsay_message(51, 199, 50)
    masterend()
end

function master40()
    fallout.gsay_message(51, 200, 51)
    mastercbt()
end

function master41()
    fallout.gsay_message(51, 201, 50)
    masterend()
end

function master42()
    fallout.gsay_message(51, 202, 51)
    mastercbt()
end

function master43()
    fallout.gsay_message(51, 203, 51)
    mastercbt()
end

function master44()
    fallout.gsay_reply(51, 204)
    fallout.giq_option(4, 51, 300, masterend, 50)
    fallout.giq_option(4, 51, 205, master01, 50)
    fallout.giq_option(4, 51, 206, master05, 51)
end

function master45()
    fallout.gsay_message(51, 207, 51)
    mastercbt()
end

function master46()
    fallout.gsay_reply(51, 208)
    fallout.giq_option(4, 51, 209, master47, 50)
    fallout.giq_option(4, 51, 210, mastercbt, 51)
end

function master47()
    fallout.gsay_message(51, 211, 51)
    mastercbt()
end

function master200()
    fallout.gsay_message(51, 212, 50)
end

function master201()
    fallout.gsay_message(51, 213, 50)
end

function master202()
    fallout.gsay_message(51, 214, 50)
end

function master203()
    fallout.gsay_message(51, 215, 51)
    mastercbt()
end

function mastercbt()
    HOSTILE = 1
end

function masterend()
end

function damage_p_proc()
    fallout.set_local_var(6, 1)
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        if everyother == 1 then
            everyother = 0
            if fallout.combat_difficulty() == 0 then
                if wimpyother == 1 then
                    wimpyother = 0
                    fallout.set_map_var(4, 1)
                else
                    wimpyother = 1
                end
            else
                fallout.set_map_var(4, 1)
            end
        else
            everyother = 1
        end
    end
end

function map_enter_p_proc()
    fallout.animate_stand_obj(fallout.self_obj())
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
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.combat_p_proc = combat_p_proc
exports.map_enter_p_proc = map_enter_p_proc
return exports
