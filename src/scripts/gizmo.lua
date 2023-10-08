local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local damage_p_proc
local Gizmo01
local Gizmo01_1
local Gizmo01b
local Gizmo02
local Gizmo04
local Gizmo04a
local Gizmo04_1
local Gizmo05
local Gizmo05_1
local Gizmo06
local Gizmo07
local Gizmo08
local Gizmo09
local Gizmo10
local Gizmo11
local Gizmo13
local Gizmo13_1
local Gizmo14
local Gizmo15
local Gizmo15_1
local Gizmo16
local Gizmo16a
local Gizmo17
local Gizmo18
local Gizmo19
local Gizmo20
local Gizmo21
local Gizmo22
local Gizmo23
local Gizmo24
local Gizmo25
local Gizmo26
local Gizmo27
local Gizmo28
local Gizmo29
local Gizmo30
local Gizmo32
local Gizmo33
local Gizmo34
local Gizmo35
local Gizmo36
local Gizmo37
local Gizmo38
local Gizmo39
local Gizmo42
local Gizmo43
local Gizmo44
local Gizmo45
local Gizmo47
local Gizmo48
local Gizmo19a
local Gizmox
local Gizmox1
local Gizmox2
local GizmoPay
local badmouth

local rndx = 0
local rndy = 0
local rndz = 0
local HOSTILE = 0
local INSISTS = 0
local CRIME = 0
local stealing = 0
local initialized = 0

local exit_line = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 15 then
                        map_enter_p_proc()
                    else
                        if fallout.script_action() == 4 then
                            pickup_p_proc()
                        else
                            if fallout.script_action() == 11 then
                                talk_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if HOSTILE then
        HOSTILE = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("Killian_ptr") ~= 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(44, 220), 0)
            fallout.attack(fallout.external_var("Killian_ptr"), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 57) then
                fallout.set_global_var(41, 1)
            end
        end
    end
    if fallout.global_var(347) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(44, 218))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(347, 1)
        reputation.inc_evil_critter()
    end
    fallout.set_global_var(38, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(44, 100))
end

function map_enter_p_proc()
    local v0 = 0
    fallout.set_external_var("Gizmo_ptr", fallout.self_obj())
    if fallout.local_var(7) == 0 then
        fallout.set_local_var(7, 1000)
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 13)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 60)
    if fallout.global_var(104) == 2 then
        v0 = fallout.create_object_sid(213, fallout.tile_num(fallout.self_obj()), 0, -1)
        fallout.kill_critter(fallout.self_obj(), 0)
    end
end

function pickup_p_proc()
    stealing = 1
    fallout.dialogue_system_enter()
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(8) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 104), 2)
    else
        if fallout.global_var(39) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 101), 0)
        else
            fallout.start_gdialog(44, fallout.self_obj(), 4, 21, 7)
            fallout.gsay_start()
            if stealing then
                Gizmo45()
            else
                if fallout.global_var(37) == 1 then
                    Gizmo21()
                else
                    if (fallout.local_var(4) > 0) and (fallout.local_var(4) < 3) then
                        Gizmo13()
                    else
                        if fallout.local_var(4) == 3 then
                            Gizmo35()
                        else
                            fallout.set_local_var(4, 1)
                            if (fallout.global_var(37) == 1) or (fallout.global_var(36) == 1) then
                                Gizmo21()
                            else
                                Gizmo01()
                            end
                        end
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(347, 1)
    end
end

function Gizmo01()
    fallout.gsay_reply(44, 101)
    fallout.giq_option(5, 44, 102, Gizmo01_1, 49)
    fallout.giq_option(7, 44, 103, Gizmo04, 50)
    fallout.giq_option(4, 44, 104, Gizmo04, 50)
    fallout.giq_option(-3, 44, 105, Gizmo01b, 51)
end

function Gizmo01_1()
    reaction.UpReactLevel()
    fallout.set_local_var(5, 1)
    Gizmo02()
end

function Gizmo01b()
    fallout.gsay_message(44, 106, 51)
    Gizmox2()
end

function Gizmo02()
    fallout.gsay_reply(44, 107)
    fallout.giq_option(5, 44, 108, Gizmo11, 51)
    fallout.giq_option(4, 44, 109, Gizmo04, 50)
end

function Gizmo04()
    fallout.gsay_reply(44, 110)
    fallout.giq_option(4, 44, 111, Gizmo05, 50)
    fallout.giq_option(4, 44, 112, Gizmo04_1, 51)
end

function Gizmo04a()
    fallout.gsay_message(44, 113, 50)
    Gizmo05()
end

function Gizmo04_1()
    fallout.set_local_var(5, fallout.local_var(5) + 1)
    if fallout.local_var(5) > 1 then
        Gizmo11()
    else
        Gizmo04a()
    end
end

function Gizmo05()
    fallout.gsay_reply(44, 114)
    fallout.giq_option(7, 44, 115, Gizmo06, 50)
    if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0))) then
        fallout.giq_option(6, 44, 116, Gizmo05_1, 51)
    end
    fallout.giq_option(4, 44, 117, Gizmo07, 49)
    fallout.giq_option(4, 44, 118, Gizmo10, 50)
    fallout.giq_option(5, 44, 119, Gizmo08, 50)
end

function Gizmo05_1()
    reaction.DownReactLevel()
    Gizmo10()
end

function Gizmo06()
    fallout.gsay_reply(44, 120)
    fallout.giq_option(7, 44, 121, Gizmo07, 49)
    fallout.giq_option(4, 44, 122, Gizmo07, 49)
    fallout.giq_option(6, 44, 123, badmouth, 51)
    fallout.giq_option(5, 44, 124, Gizmo08, 50)
    fallout.giq_option(4, 44, 125, Gizmo10, 51)
    fallout.giq_option(4, 44, 126, Gizmo10, 50)
end

function Gizmo07()
    fallout.set_global_var(39, 1)
    fallout.gsay_message(44, 127, 49)
    Gizmox()
end

function Gizmo08()
    fallout.gsay_reply(44, 128)
    fallout.giq_option(4, 44, 129, Gizmo07, 49)
    fallout.giq_option(6, 44, 130, Gizmo09, 50)
    fallout.giq_option(4, 44, 131, Gizmo10, 50)
    fallout.giq_option(5, 44, 132, badmouth, 51)
end

function Gizmo09()
    fallout.set_local_var(7, 1500)
    fallout.gsay_reply(44, 133)
    fallout.giq_option(4, 44, 134, Gizmo07, 49)
    fallout.giq_option(6, 44, 135, badmouth, 51)
    fallout.giq_option(5, 44, 136, Gizmo10, 50)
    fallout.giq_option(4, 44, 137, Gizmo10, 51)
end

function Gizmo10()
    fallout.gsay_message(44, 138, 51)
    Gizmox1()
end

function Gizmo11()
    fallout.gsay_message(44, 139, 51)
    Gizmox1()
end

function Gizmo13()
    fallout.set_local_var(4, fallout.local_var(4) + 1)
    fallout.gsay_reply(44, 140)
    fallout.giq_option(4, 44, 141, Gizmo13_1, 50)
    fallout.giq_option(4, 44, 142, Gizmo20, 50)
end

function Gizmo13_1()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 56) or (fallout.global_var(37) == 1) then
        Gizmo14()
    else
        Gizmo17()
    end
end

function Gizmo14()
    fallout.gsay_reply(44, 143)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 56) then
        fallout.gsay_option(634, 106, Gizmo15, 49)
    else
        fallout.gsay_option(634, 106, Gizmo17, 51)
    end
end

function Gizmo15()
    fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.dude_obj(), 56))
    fallout.set_global_var(39, 2)
    fallout.gsay_reply(44, 144)
    fallout.giq_option(4, 44, 145, GizmoPay, 50)
    fallout.giq_option(6, 44, 146, Gizmo15_1, 51)
    fallout.giq_option(6, 44, 147, Gizmo16, 50)
    fallout.giq_option(7, 44, 148, GizmoPay, 50)
end

function Gizmo15_1()
    fallout.set_local_var(5, fallout.local_var(5) + 1)
    if fallout.local_var(5) > 1 then
        Gizmo11()
    else
        Gizmo16()
    end
end

function Gizmo16()
    fallout.gsay_reply(44, 149)
    fallout.giq_option(4, 44, 150, GizmoPay, 50)
    if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0))) then
        fallout.giq_option(7, 44, 151, Gizmo16a, 51)
    end
    fallout.giq_option(6, 44, 152, GizmoPay, 50)
end

function Gizmo16a()
    reaction.DownReactLevel()
    badmouth()
end

function Gizmo17()
    fallout.gsay_reply(44, 153)
    fallout.giq_option(4, 44, 154, Gizmo18, 50)
    fallout.giq_option(6, 44, 155, Gizmo19, 51)
    fallout.giq_option(5, 44, 156, Gizmo20, 50)
    fallout.giq_option(6, 44, 157, Gizmo20, 50)
end

function Gizmo18()
    if fallout.local_var(6) > 1 then
        Gizmo11()
    else
        fallout.set_local_var(6, fallout.local_var(6) + 1)
        if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 104) and (fallout.global_var(36) == 1) then
            fallout.set_global_var(42, 1)
        end
        fallout.gsay_message(44, 158, 50)
        Gizmox()
    end
end

function Gizmo19()
    fallout.gsay_reply(44, 159)
    fallout.giq_option(4, 44, 160, Gizmo20, 50)
    if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0))) then
        fallout.giq_option(7, 44, 161, Gizmo19a, 51)
    end
    fallout.giq_option(5, 44, 162, Gizmo18, 50)
    fallout.giq_option(6, 44, 163, Gizmo20, 50)
end

function Gizmo20()
    if fallout.local_var(6) > 1 then
        Gizmo11()
    else
        fallout.set_local_var(6, fallout.local_var(6) + 1)
        fallout.gsay_message(44, 164, 50)
        Gizmox()
    end
end

function Gizmo21()
    fallout.gsay_reply(44, 165)
    if fallout.global_var(37) == 0 then
        fallout.giq_option(7, 44, 166, Gizmo22, 50)
        fallout.giq_option(4, 44, 169, Gizmo22, 50)
    else
        fallout.giq_option(4, 44, 221, Gizmo15, 49)
    end
    fallout.giq_option(4, 44, 167, Gizmo32, 50)
    fallout.giq_option(6, 44, 168, Gizmo34, 51)
    fallout.giq_option(-3, 44, 105, Gizmo01b, 51)
end

function Gizmo22()
    fallout.gsay_reply(44, 170)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 7 then
        fallout.giq_option(7, 44, 171, Gizmo23, 50)
    else
        fallout.giq_option(4, 44, 222, Gizmo23, 50)
    end
    fallout.giq_option(6, 44, 172, Gizmo34, 51)
    fallout.giq_option(5, 44, 173, Gizmo33, 50)
    fallout.giq_option(4, 44, 174, Gizmo34, 51)
    fallout.giq_option(4, 44, 175, Gizmo32, 51)
end

function Gizmo23()
    fallout.gsay_reply(44, 176)
    fallout.giq_option(7, 44, 177, Gizmo24, 49)
    fallout.giq_option(5, 44, 178, Gizmo34, 51)
    fallout.giq_option(4, 44, 179, Gizmo32, 50)
    fallout.giq_option(4, 44, 223, Gizmo24, 49)
end

function Gizmo24()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(44, 180)
    else
        fallout.gsay_reply(44, 226)
    end
    fallout.giq_option(7, 44, 181, Gizmo25, 49)
    fallout.giq_option(4, 44, 182, Gizmo32, 50)
    fallout.giq_option(4, 44, 224, Gizmo26, 49)
end

function Gizmo25()
    fallout.gsay_reply(44, 183)
    fallout.giq_option(7, 44, 184, Gizmo26, 50)
    fallout.giq_option(4, 44, 185, Gizmo26, 50)
end

function Gizmo26()
    fallout.gsay_reply(44, 186)
    fallout.giq_option(7, 44, 187, Gizmo27, 50)
    fallout.giq_option(4, 44, 188, Gizmo30, 50)
    fallout.giq_option(4, 44, 189, Gizmo27, 50)
end

function Gizmo27()
    fallout.gsay_reply(44, 190)
    fallout.giq_option(6, 44, 191, Gizmo34, 51)
    fallout.giq_option(6, 44, 192, Gizmo28, 50)
    fallout.giq_option(4, 44, 225, Gizmo28, 50)
end

function Gizmo28()
    fallout.gsay_reply(44, 193)
    if fallout.global_var(36) == 1 then
        if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 104) then
            fallout.set_global_var(42, 1)
        end
    end
    fallout.set_global_var(39, 1)
    fallout.giq_option(6, 44, 194, Gizmo29, 50)
    fallout.giq_option(4, 44, 195, Gizmo29, 50)
    fallout.giq_option(4, 44, 196, Gizmo30, 51)
    fallout.giq_option(4, 44, 197, Gizmo30, 50)
end

function Gizmo29()
    fallout.gsay_message(44, 198, 50)
    Gizmox()
end

function Gizmo30()
    fallout.gsay_message(44, 199, 51)
    Gizmox1()
end

function Gizmo32()
    fallout.gsay_message(44, 200, 51)
    Gizmox2()
end

function Gizmo33()
    fallout.gsay_reply(44, 201)
    fallout.giq_option(5, 44, 202, Gizmo25, 50)
    fallout.giq_option(4, 44, 203, Gizmo32, 50)
end

function Gizmo34()
    fallout.gsay_message(44, 204, 50)
    Gizmox1()
end

function Gizmo35()
    fallout.gsay_message(44, 205, 51)
    Gizmox1()
end

function Gizmo36()
    fallout.gsay_message(44, 206, 50)
end

function Gizmo37()
    fallout.gsay_message(44, 207, 50)
end

function Gizmo38()
    fallout.gsay_message(44, 208, 50)
end

function Gizmo39()
    fallout.gsay_message(44, 209, 50)
end

function Gizmo42()
    fallout.gsay_message(44, 210, 50)
end

function Gizmo43()
    fallout.gsay_message(44, 211, 50)
end

function Gizmo44()
    fallout.gsay_message(44, 212, 50)
end

function Gizmo45()
    fallout.set_external_var("Gizmo_is_angry", 1)
    fallout.set_local_var(8, 1)
    stealing = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(44, 213, 50)
    else
        fallout.gsay_message(44, 214, 50)
    end
end

function Gizmo47()
    fallout.gsay_message(44, 215, 50)
end

function Gizmo48()
    fallout.gsay_message(44, 216, 50)
end

function Gizmo19a()
    reaction.DownReactLevel()
    Gizmo11()
end

function Gizmox()
    fallout.set_external_var("show_to_door", 1)
end

function Gizmox1()
    fallout.set_external_var("Gizmo_is_angry", 1)
    fallout.set_local_var(8, 1)
end

function Gizmox2()
    fallout.set_local_var(8, 1)
end

function GizmoPay()
    fallout.set_external_var("payment", fallout.local_var(7))
end

function badmouth()
    fallout.set_local_var(5, fallout.local_var(5) + 1)
    if fallout.local_var(5) > 1 then
        Gizmo11()
    else
        Gizmo10()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
return exports
