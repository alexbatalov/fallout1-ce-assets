local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local KillianEnd
local KillianCbt
local Killian0a
local Killian01
local Killian02
local Killian03
local Killian03a
local Killian04
local Killian05
local Killian06
local Killian08
local Killian09
local Killian09a
local Killian10
local Killian11
local Killian11a
local Killian12
local Killian13
local Killian13a
local Killian13b
local Killian14
local Killian15
local Killian16
local Killian21
local Killian22
local Killian23
local Killian24
local Killian26
local Killian27
local Killian28
local Killian29
local Killian30
local Killian31
local Killian32
local Killian34
local Killian35
local Killian36
local Killian37
local Killian38
local Killian39
local Killian40
local Killian41
local Killian42
local Killian43
local Killian44
local Killian45
local Killian45a
local Killian46
local Killian47
local Killian48
local Killian49
local Killian50
local Killian51
local Killian52
local Killian53
local Killian54
local Killian55
local Killian56
local Killian57
local Killian58
local Killian59
local Killian60
local Killian61
local Killian62
local Killian63
local Killian64
local Killian65
local Killian66
local Killian67
local Killian68
local Killian71
local Killian72
local Killian73
local Killian74
local Killian75
local Killian76
local Killian88
local Killian89
local Killian90
local Killianx
local Killianx1
local Killianx2
local Killianx3
local Killianx4
local Killian_barter
local Killian_give_stuff
local Killian_give_shotgun
local Killian_give_armor
local Killian_give_doctor_bag
local Killian_give_stimpaks
local soundcheck
local playback
local Killian02a
local Killian02b
local Killian03aa
local Killian03ba
local Killian03ca
local Killian32a
local Killian63a
local get_stuff_from_safe
local put_stuff_in_safe
local killian00
local killian69
local killian70
local killian76a
local killian77
local killian78
local killian79
local killian80
local killian81
local killian82
local killian83
local killian84
local killian85
local killian86
local killian87

local ILLEGAL = false
local ILLEGBEFORE = false
local TRESPASS = false
local hostile = false
local go_to_jail = false
local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    local cur_map_index = fallout.cur_map_index()
    if time.is_night() and distance_self_to_dude < 12 and self_can_see_dude and cur_map_index == 12 then
        ILLEGAL = true
        TRESPASS = true
        fallout.dialogue_system_enter()
    end
    if fallout.map_var(9) == 1 then
        if cur_map_index == 12 and fallout.local_var(7) == 0 and distance_self_to_dude < 12 and self_can_see_dude then
            fallout.set_map_var(9, 0)
            ILLEGAL = true
            TRESPASS = true
            fallout.dialogue_system_enter()
        else
            ILLEGAL = false
            TRESPASS = false
            fallout.set_map_var(9, 0)
        end
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if self_can_see_dude and distance_self_to_dude < 12 and fallout.map_var(2) ~= 0 and cur_map_index == 12 then
        fallout.dialogue_system_enter()
    end
    behaviour.sleeping(7, night_person, wake_time, sleep_time, home_tile, sleep_tile)
    local game_time_hour = fallout.game_time_hour()
    if game_time_hour > 730 and game_time_hour < 1900 then
        if fallout.tile_num(self_obj) ~= home_tile then
            fallout.animate_move_obj_to_tile(self_obj, home_tile, 0)
        else
            if fallout.has_trait(1, self_obj, 10) ~= 2 then
                fallout.anim(self_obj, 1000, 2)
            end
        end
    end
    if fallout.external_var("Killian_barter_var") ~= 0 then
        if fallout.local_var(7) == 0 and cur_map_index == 12 then
            if distance_self_to_dude < 12 then
                fallout.dialogue_system_enter()
            else
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.tile_num(dude_obj), fallout.random(0, 5), 1), 0)
            end
        else
            fallout.set_external_var("Killian_barter_var", 0)
        end
    end
end

function destroy_p_proc()
    local item_obj = fallout.create_object_sid(56, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.self_obj(), item_obj)
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
    fallout.set_global_var(37, 1)
    reputation.inc_good_critter()
    if fallout.global_var(105) == 1 then
        fallout.set_global_var(105, 2)
    end
    fallout.set_external_var("Killian_ptr", nil)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(47, 100))
end

function map_enter_p_proc()
    sleep_tile = 27896
    sleep_time = 1900
    wake_time = 700
    home_tile = 25683
    local self_obj = fallout.self_obj()
    fallout.set_external_var("Killian_ptr", self_obj)
    if fallout.cur_map_index() == 11 then
        if fallout.global_var(38) == 1 then
            fallout.destroy_object(self_obj)
        else
            fallout.float_msg(self_obj, fallout.message_str(47, 271), 3)
        end
        misc.set_team(self_obj, 0)
    else
        misc.set_team(self_obj, 12)
    end
    if fallout.item_caps_total(self_obj) == 0 then
        fallout.item_caps_adjust(self_obj, fallout.random(10, 150))
    end
end

function pickup_p_proc()
    ILLEGAL = true
    ILLEGBEFORE = true
    TRESPASS = false
    fallout.dialogue_system_enter()
end

function talk_p_proc()
    get_stuff_from_safe()
    if fallout.local_var(7) == 1 and not TRESPASS then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if fallout.global_var(42) ~= 1 and fallout.global_var(41) ~= 1 and fallout.global_var(38) == 1 and fallout.local_var(9) == 0 then
            Killian89()
        else
            reaction.get_reaction()
            if fallout.external_var("Killian_barter_var") >= 0 then
                if fallout.external_var("Killian_barter_var") == 1 then
                    fallout.move_obj_inven_to_obj(fallout.external_var("Killian_store1_ptr"), fallout.self_obj())
                elseif fallout.external_var("Killian_barter_var") == 2 then
                    fallout.move_obj_inven_to_obj(fallout.external_var("Killian_store2_ptr"), fallout.self_obj())
                elseif fallout.external_var("Killian_barter_var") == 3 then
                    fallout.move_obj_inven_to_obj(fallout.external_var("Killian_store3_ptr"), fallout.self_obj())
                elseif fallout.external_var("Killian_barter_var") == 4 then
                    fallout.move_obj_inven_to_obj(fallout.external_var("Killian_store4_ptr"), fallout.self_obj())
                end
            end
            fallout.start_gdialog(47, fallout.self_obj(), 4, 10, 7)
            fallout.gsay_start()
            if ILLEGAL then
                if ILLEGBEFORE then
                    Killian30()
                else
                    ILLEGBEFORE = true
                    if TRESPASS then
                        Killian31()
                    else
                        Killian29()
                    end
                end
            else
                if fallout.external_var("Killian_barter_var") == -1 then
                    fallout.set_local_var(8, fallout.local_var(8) + 1)
                    fallout.set_external_var("Killian_barter_var", 0)
                    if fallout.local_var(8) == 1 then
                        Killian42()
                    elseif fallout.local_var(8) == 2 then
                        Killian43()
                    elseif fallout.local_var(8) == 3 then
                        Killian44()
                    else
                        Killian30()
                    end
                elseif fallout.external_var("Killian_barter_var") ~= 0 then
                    fallout.gsay_reply(47, 115)
                    fallout.giq_option(4, 47, 118, Killian_barter, 50)
                    fallout.giq_option(4, 47, 121, Killianx, 50)
                    fallout.giq_option(-3, 47, 122, Killianx, 50)
                elseif fallout.map_var(2) ~= 0 then
                    Killian47()
                elseif fallout.local_var(5) == 1 then
                    if fallout.global_var(42) == 1 or fallout.global_var(41) == 1 and fallout.map_var(6) == 0 then
                        Killian54()
                    elseif fallout.local_var(1) >= 2 then
                        Killian24()
                    else
                        Killian26()
                    end
                else
                    Killian01()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    if fallout.map_var(5) == 1 and fallout.local_var(7) == 0 and fallout.global_var(39) == 0 then
        local critter_obj = fallout.create_object_sid(16777528, 0, 0, 510)
        local item_obj = fallout.create_object_sid(10, 0, 0, -1)
        fallout.add_obj_to_inven(critter_obj, item_obj)
        misc.set_team(critter_obj, 13)
        misc.set_ai(critter_obj, 1)
        fallout.critter_attempt_placement(critter_obj, 28283, 0)
        fallout.set_map_var(5, 2)
    end
    if fallout.map_var(6) == 1 then
        fallout.set_map_var(6, 2)
        fallout.display_msg(fallout.message_str(47, 270))
        fallout.give_exp_points(500)
    end
    put_stuff_in_safe()
    if fallout.external_var("Killian_barter_var") >= 0 then
        local item_obj = fallout.obj_carrying_pid_obj(fallout.self_obj(), 18)
        fallout.rm_obj_from_inven(fallout.self_obj(), item_obj)
        if fallout.external_var("Killian_barter_var") == 1 then
            fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Killian_store1_ptr"))
        elseif fallout.external_var("Killian_barter_var") == 2 then
            fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Killian_store2_ptr"))
        elseif fallout.external_var("Killian_barter_var") == 3 then
            fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Killian_store3_ptr"))
        else
            fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Killian_store4_ptr"))
        end
        fallout.set_external_var("Killian_barter_var", 0)
        fallout.add_obj_to_inven(fallout.self_obj(), item_obj)
    end
    if go_to_jail then
        fallout.set_global_var(155, fallout.global_var(155) - 1)
        go_to_jail = false
        fallout.load_map(10, 6)
    end
end

function KillianEnd()
end

function KillianCbt()
    hostile = true
end

function Killian0a()
    fallout.gsay_reply(47, 109)
    fallout.gsay_option(47, 110, Killianx, 50)
    fallout.gsay_option(47, 111, Killianx, 50)
end

function Killian01()
    fallout.set_local_var(5, 1)
    if fallout.map_var(5) == 0 and fallout.global_var(38) == 0 and fallout.map_var(6) == 0 and fallout.global_var(36) == 0 then
        fallout.set_map_var(5, 1)
    end
    if fallout.local_var(1) == 3 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.gsay_reply(47, 112)
        else
            fallout.gsay_reply(47, 113)
        end
    else
        if fallout.local_var(1) == 1 then
            fallout.gsay_reply(47, 114)
        else
            fallout.gsay_reply(47, 115)
        end
    end
    killian00()
end

function Killian02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(47, 123)
    fallout.giq_option(4, 47,
        fallout.message_str(47, 124) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(47, 125), Killian02b, 50)
    fallout.giq_option(4, 47,
        fallout.message_str(47, 126) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(47, 127), Killian03, 50)
    fallout.giq_option(5, 47, 128, Killian02a, 51)
end

function Killian03()
    fallout.gsay_reply(47, 129)
    fallout.giq_option(4, 47, 130, Killian05, 51)
    fallout.giq_option(6, 47, 131, Killian03aa, 50)
    fallout.giq_option(5, 47, 132, Killian03ba, 50)
    fallout.giq_option(5, 47, 133, Killian03ca, 51)
end

function Killian03a()
    fallout.gsay_message(47, 134, 50)
    Killian08()
end

function Killian04()
    fallout.gsay_message(47, 135, 50)
    killian00()
end

function Killian05()
    fallout.gsay_reply(47, 136)
    fallout.giq_option(4, 47, 137, Killian06, 49)
    fallout.giq_option(5, 47, 138, Killian04, 49)
end

function Killian06()
    fallout.gsay_reply(47, 139)
    killian00()
end

function Killian08()
    fallout.gsay_reply(47, 140)
    fallout.giq_option(5, 47, 141, Killian09, 50)
    fallout.giq_option(4, 47, 142, killian00, 50)
end

function Killian09()
    if fallout.global_var(73) == 0 then
        fallout.set_global_var(73, 1)
    end
    if fallout.global_var(72) == 0 then
        fallout.set_global_var(72, 1)
    end
    fallout.gsay_reply(47, 143)
    fallout.giq_option(5, 47, 144, Killian10, 50)
    fallout.giq_option(5, 47, 145, Killian09a, 51)
    fallout.giq_option(4, 47, 146, Killianx, 50)
end

function Killian09a()
    reaction.DownReactLevel()
    Killian04()
end

function Killian10()
    if fallout.local_var(1) >= 2 then
        fallout.gsay_reply(47, 147)
    else
        fallout.gsay_reply(47, 148)
    end
    killian00()
end

function Killian11()
    fallout.gsay_reply(47, 149)
    fallout.giq_option(4, 47, 150, Killian12, 50)
    fallout.giq_option(5, 47, 151, Killian13, 50)
    fallout.giq_option(6, 47, 152, Killian08, 50)
    fallout.giq_option(4, 47, 153, Killian11a, 50)
end

function Killian11a()
    fallout.gsay_reply(47, " ")
    killian00()
end

function Killian12()
    fallout.gsay_reply(47, 154)
    killian00()
end

function Killian13()
    fallout.gsay_reply(47, 155)
    fallout.giq_option(4, 47, 156, Killian13b, 50)
    fallout.giq_option(6, 47, 157, Killian13a, 51)
end

function Killian13a()
    reaction.DownReactLevel()
    Killian14()
end

function Killian13b()
    fallout.gsay_reply(0, 0)
    killian00()
end

function Killian14()
    fallout.gsay_reply(47, 158)
    fallout.giq_option(4, 47, 159, Killian15, 50)
    fallout.giq_option(6, 47, 160, Killian16, 51)
end

function Killian15()
    fallout.gsay_reply(47, 161)
    killian00()
end

function Killian16()
    fallout.gsay_message(47, 162, 51)
end

function Killian21()
    fallout.gsay_reply(47, 163)
    fallout.giq_option(4, 634, 106, Killian_barter, 50)
end

function Killian22()
    fallout.gsay_message(47, 164, 50)
end

function Killian23()
    fallout.gsay_message(47, 165, 50)
end

function Killian24()
    fallout.gsay_reply(47, 166)
    killian00()
end

function Killian26()
    fallout.gsay_reply(47, 167)
    killian00()
end

function Killian27()
    fallout.gsay_message(47, 168, 50)
end

function Killian28()
    fallout.gsay_reply(47, 169)
    Killianx1()
end

function Killian29()
    fallout.gsay_message(47, 170, 50)
end

function Killian30()
    ILLEGAL = false
    ILLEGBEFORE = false
    fallout.gsay_reply(47, 171)
    Killianx1()
end

function Killian31()
    TRESPASS = false
    fallout.gsay_reply(47, 172)
    fallout.giq_option(4, 47, 173, Killian34, 50)
    fallout.giq_option(5, 47, 174, Killian32, 50)
    fallout.giq_option(4, 47, 175, Killian35, 50)
end

function Killian32()
    fallout.gsay_reply(47, 176)
    fallout.giq_option(4, 47, 177, Killian32a, 51)
    fallout.giq_option(5, 47, 178, KillianCbt, 51)
end

function Killian34()
    fallout.gsay_reply(47, 179)
    fallout.giq_option(4, 47, 180, Killianx2, 50)
    fallout.giq_option(5, 47, 181, KillianCbt, 51)
end

function Killian35()
    fallout.gsay_reply(47, 182)
    Killianx1()
end

function Killian36()
    fallout.gsay_message(47, 185, 50)
end

function Killian37()
    fallout.gsay_message(47, 186, 50)
end

function Killian38()
    fallout.gsay_message(47, 187, 50)
end

function Killian39()
    fallout.gsay_message(47, 188, 50)
end

function Killian40()
    fallout.gsay_message(47, 189, 50)
end

function Killian41()
    fallout.gsay_message(47, 190, 50)
end

function Killian42()
    fallout.gsay_message(47, 191, 50)
    Killianx()
end

function Killian43()
    fallout.gsay_message(47, 192, 50)
    Killianx()
end

function Killian44()
    fallout.gsay_reply(47, 193)
    Killianx1()
end

function Killian45()
    fallout.gsay_reply(47, 194)
    fallout.giq_option(4, 47, 195, Killian45a, 50)
    fallout.giq_option(4, 47, 196, Killian46, 50)
end

function Killian45a()
    fallout.gsay_reply(47, " ")
    killian00()
end

function Killian46()
    fallout.gsay_message(47, 197, 50)
    Killianx()
end

function Killian47()
    fallout.set_map_var(2, 0)
    fallout.gsay_reply(47, 198)
    fallout.giq_option(4, 47, 199, Killian48, 50)
    fallout.giq_option(4, 47, 200, Killian50, 50)
    fallout.giq_option(4, 47, 201, Killian90, 49)
    fallout.giq_option(-3, 47, 110, Killian90, 49)
    fallout.giq_option(-3, 47, 111, Killian52, 50)
end

function Killian48()
    fallout.gsay_reply(47, 202)
    fallout.giq_option(4, 47, 203, Killian49, 50)
    fallout.giq_option(4, 47, 204, Killian51, 50)
    fallout.giq_option(6, 47, 205, Killian52, 50)
end

function Killian49()
    fallout.gsay_reply(47, 206)
    fallout.giq_option(4, 47, 207, Killian50, 50)
    fallout.giq_option(5, 47, 208, Killian51, 50)
    fallout.giq_option(4, 47, 209, Killian52, 50)
end

function Killian50()
    fallout.gsay_reply(47, 210)
    fallout.giq_option(4, 47, 211, Killian53, 50)
    fallout.giq_option(4, 47, 212, Killian52, 50)
    fallout.giq_option(5, 47, 213, Killian51, 50)
end

function Killian51()
    fallout.gsay_reply(47, 214)
    fallout.giq_option(4, 47, 215, Killian53, 50)
    fallout.giq_option(4, 47, 216, Killian52, 51)
end

function Killian52()
    fallout.set_global_var(104, 2)
    fallout.set_map_var(6, 2)
    fallout.gsay_message(47, 217, 51)
    fallout.set_global_var(348, 1)
    Killianx1()
end

function Killian53()
    fallout.gsay_message(47, 218, 50)
    Killianx4()
end

function Killian54()
    fallout.gsay_reply(47, 219)
    fallout.giq_option(4, 47, 220, Killian55, 50)
    fallout.giq_option(-3, 47, 111, Killian55, 50)
    if fallout.global_var(41) == 1 or fallout.global_var(42) == 1 then
        fallout.giq_option(4, 47, 221, Killian56, 49)
        fallout.giq_option(-3, 47, 110, Killian56, 49)
    end
end

function Killian55()
    fallout.gsay_message(47, 222, 50)
    Killianx()
end

function Killian56()
    fallout.gsay_reply(47, 223)
    if fallout.global_var(41) ~= 0 then
        fallout.giq_option(4, 47, 224, Killian57, 50)
        fallout.giq_option(-3, 47, 108, Killian57, 50)
    end
    if fallout.global_var(42) ~= 0 then
        fallout.giq_option(4, 47, 225, Killian58, 50)
    end
end

function Killian57()
    fallout.gsay_message(47, 226, 49)
    soundcheck()
end

function Killian58()
    fallout.gsay_reply(47, 228)
    fallout.giq_option(0, 634, 106, playback, 49)
end

function Killian59()
    if fallout.map_var(6) == 0 then
        fallout.set_map_var(6, 1)
    end
    fallout.gsay_reply(47, 230)
    fallout.giq_option(4, 47, 231, Killian60, 50)
    fallout.giq_option(4, 47, 232, Killian61, 50)
    fallout.giq_option(5, 47, 233, Killian64, 50)
    fallout.giq_option(-3, 47, 110, Killian60, 50)
    fallout.giq_option(-3, 47, 111, Killian64, 50)
end

function Killian60()
    fallout.set_local_var(1, 3)
    reaction.LevelToReact()
    fallout.set_global_var(104, 1)
    fallout.gsay_message(47, 234, 49)
    Killianx()
end

function Killian61()
    fallout.gsay_reply(47, 235)
    fallout.giq_option(4, 47, 236, Killian62, 50)
    fallout.giq_option(4, 47, 237, Killian63, 50)
end

function Killian62()
    fallout.set_global_var(104, 1)
    fallout.gsay_message(47, 238, 50)
    Killianx()
end

function Killian63()
    fallout.gsay_reply(47, 239)
    fallout.giq_option(4, 47, 240, Killian62, 50)
    fallout.giq_option(4, 47, 241, Killian63a, 51)
end

function Killian64()
    fallout.gsay_message(47, 242, 50)
    Killianx()
end

function Killian65()
    fallout.gsay_message(47, 243, 50)
end

function Killian66()
    fallout.gsay_message(47, 244, 50)
end

function Killian67()
    fallout.gsay_message(47, 245, 50)
end

function Killian68()
    fallout.gsay_message(47, 246, 50)
end

function Killian71()
    fallout.gsay_message(47, 249, 50)
end

function Killian72()
    fallout.gsay_message(47, 250, 50)
end

function Killian73()
    fallout.gsay_message(47, 251, 50)
end

function Killian74()
    fallout.gsay_message(47, 252, 50)
end

function Killian75()
    fallout.gsay_message(47, 253, 50)
end

function Killian76()
    fallout.gsay_message(47, 254, 50)
end

function Killian88()
    fallout.gsay_reply(47, 243)
    fallout.giq_option(4, 47, 273, Killianx, 50)
    fallout.giq_option(4, 47, 274, KillianCbt, 51)
    fallout.giq_option(4, 47, 275, Killian48, 49)
end

function Killian89()
    fallout.set_local_var(9, 1)
    fallout.set_map_var(2, 0)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(47, 284), 0)
end

function Killian90()
    fallout.gsay_reply(47, 165)
    fallout.giq_option(4, 634, 106, Killian53, 49)
end

function Killianx()
end

function Killianx1()
    fallout.giq_option(4, 47, 183, Killianx3, 50)
    fallout.giq_option(4, 47, 184, KillianCbt, 51)
    fallout.giq_option(-3, 47, 108, KillianCbt, 51)
end

function Killianx2()
end

function Killianx3()
    go_to_jail = true
end

function Killianx4()
    local item_obj = fallout.create_object_sid(57, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) > 3 then
        item_obj = fallout.create_object_sid(104, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    end
    fallout.set_global_var(36, 1)
end

function Killian_barter()
    fallout.gdialog_mod_barter(0)
    fallout.gsay_reply(47, " ")
    fallout.giq_option(0, 634, 108, Killianx, 50)
end

function Killian_give_stuff()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_is_carrying_obj_pid(dude_obj, 104) ~= 0 then
        fallout.destroy_object(fallout.obj_carrying_pid_obj(dude_obj, 104))
    end
    if fallout.obj_is_carrying_obj_pid(dude_obj, 57) ~= 0 then
        fallout.destroy_object(fallout.obj_carrying_pid_obj(dude_obj, 57))
    end
    fallout.giq_option(4, 47, 276, Killian_give_shotgun, 49)
    fallout.giq_option(4, 47, 277, Killian_give_armor, 49)
    fallout.giq_option(4, 47, 278, Killian_give_doctor_bag, 49)
    fallout.giq_option(4, 47, 279, Killian_give_stimpaks, 49)
    fallout.giq_option(4, 47, 280, Killian59, 49)
    fallout.giq_option(-3, 47, 111, Killian59, 49)
end

function Killian_give_shotgun()
    local item_obj
    item_obj = fallout.create_object_sid(94, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    item_obj = fallout.create_object_sid(95, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), item_obj, 5)
    Killian59()
end

function Killian_give_armor()
    local item_obj = fallout.create_object_sid(1, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    Killian59()
end

function Killian_give_doctor_bag()
    local item_obj = fallout.create_object_sid(91, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    Killian59()
end

function Killian_give_stimpaks()
    local item_obj = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), item_obj, 5)
    Killian59()
end

function soundcheck()
    fallout.gsay_reply(47, 227)
    Killian_give_stuff()
end

function playback()
    fallout.gsay_reply(47, 229)
    Killian_give_stuff()
end

function Killian02a()
    reaction.DownReactLevel()
    Killian16()
end

function Killian02b()
    fallout.gsay_reply(0, 0)
    killian00()
end

function Killian03aa()
    reaction.DownReactLevel()
    Killian04()
end

function Killian03ba()
    reaction.DownReactLevel()
    Killian03a()
end

function Killian03ca()
    reaction.DownReactLevel()
    Killian16()
end

function Killian32a()
    reaction.DownReactLevel()
    Killianx2()
end

function Killian63a()
    reaction.DownReactLevel()
    Killian64()
end

function get_stuff_from_safe()
    local kill_safe_obj = fallout.external_var("KillSafe_ptr")
    local self_obj = fallout.self_obj()
    local item_obj
    if fallout.item_caps_total(kill_safe_obj) ~= 0 then
        fallout.item_caps_adjust(self_obj, fallout.item_caps_total(kill_safe_obj))
        fallout.item_caps_adjust(kill_safe_obj, -fallout.item_caps_total(kill_safe_obj))
    end
    if fallout.obj_is_carrying_obj_pid(kill_safe_obj, 18) ~= 0 then
        item_obj = fallout.obj_carrying_pid_obj(kill_safe_obj, 18)
        fallout.rm_obj_from_inven(kill_safe_obj, item_obj)
        fallout.add_obj_to_inven(self_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(kill_safe_obj, 40) ~= 0 then
        item_obj = fallout.obj_carrying_pid_obj(kill_safe_obj, 40)
        fallout.rm_obj_from_inven(kill_safe_obj, item_obj)
        fallout.add_obj_to_inven(self_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(kill_safe_obj, 31) ~= 0 then
        item_obj = fallout.obj_carrying_pid_obj(kill_safe_obj, 31)
        fallout.rm_obj_from_inven(kill_safe_obj, item_obj)
        fallout.add_obj_to_inven(self_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(kill_safe_obj, 34) ~= 0 then
        item_obj = fallout.obj_carrying_pid_obj(kill_safe_obj, 34)
        fallout.rm_obj_from_inven(kill_safe_obj, item_obj)
        fallout.add_obj_to_inven(self_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(kill_safe_obj, 30) ~= 0 then
        item_obj = fallout.obj_carrying_pid_obj(kill_safe_obj, 30)
        fallout.rm_obj_from_inven(kill_safe_obj, item_obj)
        fallout.add_obj_to_inven(self_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(kill_safe_obj, 4) ~= 0 then
        item_obj = fallout.obj_carrying_pid_obj(kill_safe_obj, 4)
        fallout.rm_obj_from_inven(kill_safe_obj, item_obj)
        fallout.add_obj_to_inven(self_obj, item_obj)
    end
end

function put_stuff_in_safe()
    local kill_safe_obj = fallout.external_var("KillSafe_ptr")
    local self_obj = fallout.self_obj()
    local item_obj
    if fallout.item_caps_total(self_obj) ~= 0 then
        fallout.item_caps_adjust(kill_safe_obj, fallout.item_caps_total(self_obj))
        fallout.item_caps_adjust(self_obj, -fallout.item_caps_total(self_obj))
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 18) > 1 then
        item_obj = fallout.obj_carrying_pid_obj(self_obj, 18)
        fallout.rm_obj_from_inven(self_obj, item_obj)
        fallout.add_obj_to_inven(kill_safe_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 40) > 1 then
        item_obj = fallout.obj_carrying_pid_obj(self_obj, 40)
        fallout.rm_obj_from_inven(self_obj, item_obj)
        fallout.add_obj_to_inven(kill_safe_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 31) > 1 then
        item_obj = fallout.obj_carrying_pid_obj(self_obj, 31)
        fallout.rm_obj_from_inven(self_obj, item_obj)
        fallout.add_obj_to_inven(kill_safe_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 34) > 1 then
        item_obj = fallout.obj_carrying_pid_obj(self_obj, 34)
        fallout.rm_obj_from_inven(self_obj, item_obj)
        fallout.add_obj_to_inven(kill_safe_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 30) > 1 then
        item_obj = fallout.obj_carrying_pid_obj(self_obj, 30)
        fallout.rm_obj_from_inven(self_obj, item_obj)
        fallout.add_obj_to_inven(kill_safe_obj, item_obj)
    end
    if fallout.obj_is_carrying_obj_pid(self_obj, 4) > 1 then
        item_obj = fallout.obj_carrying_pid_obj(self_obj, 4)
        fallout.rm_obj_from_inven(self_obj, item_obj)
        fallout.add_obj_to_inven(kill_safe_obj, item_obj)
    end
end

function killian00()
    if fallout.local_var(4) == 0 then
        fallout.giq_option(4, 47, 101, Killian02, 50)
    end
    fallout.giq_option(5, 47, 102, Killian11, 50)
    fallout.giq_option(5, 47, 103, Killian22, 50)
    fallout.giq_option(4, 47, 104, Killian21, 50)
    fallout.giq_option(5, 47, 105, Killian13, 50)
    if fallout.global_var(39) == 1 and fallout.global_var(38) == 0 and fallout.global_var(36) == 0 then
        fallout.giq_option(4, 47, 272, Killian88, 50)
    end
    if fallout.global_var(36) == 1 and fallout.global_var(38) == 0 and fallout.map_var(6) == 0 then
        fallout.giq_option(5, 47, 106, Killian23, 50)
    end
    fallout.giq_option(4, 47, 107, Killianx, 50)
    fallout.giq_option(-3, 47, 108, Killian0a, 50)
end

function killian69()
    fallout.gsay_message(47, 247, 50)
end

function killian70()
    fallout.gsay_message(47, 248, 50)
end

function killian76a()
    fallout.gsay_message(47, 255, 50)
end

function killian77()
    fallout.gsay_message(47, 256, 50)
end

function killian78()
    fallout.gsay_message(47, 257, 50)
end

function killian79()
    fallout.gsay_message(47, 258, 50)
end

function killian80()
    fallout.gsay_message(47, 259, 50)
end

function killian81()
    fallout.gsay_message(47, 260, 50)
end

function killian82()
    fallout.gsay_message(47, 261, 50)
end

function killian83()
    fallout.gsay_message(47, 262, 50)
end

function killian84()
    fallout.gsay_message(47, 263, 50)
end

function killian85()
    fallout.gsay_message(47, 264, 50)
end

function killian86()
    fallout.gsay_message(47, 265, 50)
end

function killian87()
    fallout.gsay_message(47, 266, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
