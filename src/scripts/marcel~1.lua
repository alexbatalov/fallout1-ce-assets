local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Raider0
local Raider1
local Raider2
local Raider3
local Raider4
local Raider5
local Raider6
local Raider7
local Raider8
local Raider9
local Raider10
local Raider10a
local Raider11
local Raider12
local Raider13
local Raider14
local Raider14a
local Raider15
local Raider16
local Raider17
local Raider17a
local Raider17b
local Raider18
local Raider19
local Raider20
local Raider21
local Raider22
local Raider22a
local Raider23
local Raider24
local Raider24a
local Raider25
local Raider26
local Raider27
local Raider27a
local Raider28
local Raider29
local Raider29a
local Raider30
local Raider30a
local Raider31
local Raider32
local Raider33
local Raider34
local Raiderend
local RaiderCombat
local RaiderSnap
local safe

local hostile = 0
local known = 0
local pissed = 0
local sfx_name = 0
local Sinthia_is_safe = 0
local shoot_Sinthia = 0
local will_negotiate = 0
local line184flag = 0

local exit_line = 0

function start()
    fallout.set_external_var("JTRaider_ptr", fallout.self_obj())
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 14 then
            damage_p_proc()
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
                            else
                                if fallout.script_action() == 22 then
                                    timed_event_p_proc()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) and (line184flag == 0) and (fallout.has_skill(fallout.dude_obj(), 8) >= 50) then
        line184flag = 1
        fallout.display_msg(fallout.message_str(337, 184))
    else
        if hostile then
            hostile = 0
            pissed = 1
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if pissed and (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 4) then
                hostile = 1
            else
                if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (known == 0) and (fallout.using_skill(fallout.dude_obj(), 8) == 0) then
                    fallout.dialogue_system_enter()
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.using_skill(fallout.dude_obj(), 8) then
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 8, 0)) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(337, 183))
                fallout.critter_injure(fallout.self_obj(), 2)
                fallout.critter_injure(fallout.self_obj(), 1)
                fallout.set_map_var(1, 1)
                fallout.set_map_var(3, 3)
                fallout.terminate_combat()
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_map_var(1, 2)
    end
    fallout.set_global_var(143, 2)
    fallout.set_map_var(3, 3)
    if fallout.map_var(0) ~= 2 then
        fallout.set_external_var("award", 400)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        if reputation.has_rep_berserker() then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if reputation.has_rep_champion() then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 5) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(337, 100))
end

function map_enter_p_proc()
    fallout.set_external_var("JTRaider_ptr", fallout.self_obj())
    misc.set_team(fallout.self_obj(), 15)
end

function pickup_p_proc()
    hostile = 1
    pissed = 1
    will_negotiate = 0
end

function talk_p_proc()
    reaction.get_reaction()
    if hostile then
        Raider34()
    else
        if fallout.global_var(143) == 1 then
            fallout.start_gdialog(337, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if not(known) then
                Raider0()
            else
                if fallout.map_var(3) == 1 then
                    if fallout.local_var(1) < 2 then
                        Raider17()
                    else
                        Raider9()
                    end
                    fallout.set_map_var(3, 2)
                else
                    if will_negotiate then
                        Raider21()
                    else
                        Raider31()
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.display_msg(fallout.message_str(337, 178))
        end
    end
    if shoot_Sinthia then
        fallout.game_ui_disable()
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(fallout.self_obj(), 43, -1)
        fallout.reg_anim_animate(fallout.self_obj(), 45, -1)
        sfx_name = fallout.sfx_build_weapon_name(1, fallout.obj_carrying_pid_obj(fallout.self_obj(), 8), 0, fallout.external_var("Sinthia_ptr"))
        fallout.reg_anim_play_sfx(fallout.self_obj(), sfx_name, 0)
        fallout.reg_anim_animate(fallout.self_obj(), 44, -1)
        fallout.reg_anim_func(3, 0)
        shoot_Sinthia = 0
        fallout.add_timer_event(fallout.self_obj(), 5, 2)
    end
    if Sinthia_is_safe == 1 then
        fallout.set_map_var(3, 3)
        fallout.set_global_var(143, 2)
        fallout.gfade_out(600)
        fallout.gfade_in(600)
        fallout.destroy_object(fallout.self_obj())
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.game_ui_enable()
        hostile = 1
    else
        if fallout.fixed_param() == 2 then
            fallout.critter_dmg(fallout.external_var("Sinthia_ptr"), 75, 0)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
        end
    end
end

function Raider0()
    known = 1
    fallout.gsay_reply(337, 101)
    fallout.giq_option(-3, 337, 102, Raider1, 50)
    fallout.giq_option(4, 337, 103, Raider2, 50)
    fallout.giq_option(4, 337, 104, Raider8, 50)
    fallout.giq_option(7, 337, 105, Raider4, 50)
end

function Raider1()
    fallout.gsay_message(337, 106, 50)
    RaiderSnap()
end

function Raider2()
    fallout.gsay_reply(337, 107)
    fallout.giq_option(4, 337, 108, Raider3, 50)
end

function Raider3()
    reaction.DownReact()
    fallout.gsay_message(337, 109, 51)
    pissed = 1
end

function Raider4()
    fallout.gsay_reply(337, 110)
    fallout.giq_option(7, 337, 111, Raider5, 50)
    fallout.giq_option(7, 337, 112, Raider7, 50)
end

function Raider5()
    fallout.gsay_reply(337, 113)
    fallout.giq_option(7, 337, 114, Raider6, 49)
end

function Raider6()
    reaction.UpReact()
    pissed = 1
    fallout.gsay_message(337, 115, 49)
end

function Raider7()
    fallout.gsay_message(337, 116, 51)
    pissed = 1
end

function Raider8()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(337, 119, 51)
    else
        fallout.gsay_message(337, 120, 51)
    end
    RaiderSnap()
end

function Raider9()
    fallout.gsay_reply(337, 121)
    fallout.giq_option(4, 337, 122, Raider10, 50)
    fallout.giq_option(7, 337, 123, Raider14, 50)
end

function Raider10()
    fallout.gsay_reply(337, 124)
    fallout.giq_option(4, 337, 125, Raider11, 50)
    fallout.giq_option(4, 337, 126, Raider10a, 50)
end

function Raider10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        will_negotiate = 1
        Raider12()
    else
        Raider13()
    end
end

function Raider11()
    fallout.gsay_reply(337, 127)
    fallout.giq_option(4, 337, 128, RaiderCombat, 51)
end

function Raider12()
    fallout.gsay_message(337, 129, 50)
end

function Raider13()
    fallout.gsay_message(337, 130, 50)
end

function Raider14()
    fallout.gsay_reply(337, 131)
    fallout.giq_option(7, 337, 132, Raider14a, 50)
end

function Raider14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        will_negotiate = 1
        Raider16()
    else
        Raider15()
    end
end

function Raider15()
    fallout.gsay_message(337, 133, 50)
end

function Raider16()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(337, 136, 50)
    else
        fallout.gsay_message(337, 137, 50)
    end
end

function Raider17()
    fallout.gsay_reply(337, 138)
    fallout.giq_option(4, 337, 139, Raider17a, 50)
    fallout.giq_option(6, 337, 140, Raider18, 50)
    fallout.giq_option(8, 337, 141, Raider17b, 50)
end

function Raider17a()
    will_negotiate = 0
end

function Raider17b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        will_negotiate = 1
        Raider20()
    else
        Raider19()
    end
end

function Raider18()
    fallout.gsay_message(337, 142, 51)
    RaiderSnap()
end

function Raider19()
    fallout.gsay_message(337, 143, 51)
    will_negotiate = 0
end

function Raider20()
    reaction.UpReact()
    fallout.gsay_message(337, 144, 49)
end

function Raider21()
    fallout.gsay_reply(337, 145)
    fallout.giq_option(4, 337, 146, Raider22, 50)
end

function Raider22()
    fallout.gsay_reply(337, 147)
    fallout.giq_option(4, 337, 148, Raider23, 50)
    fallout.giq_option(4, 337, 149, Raider24, 50)
    fallout.giq_option(5, 337, 150, Raider22a, 50)
    fallout.giq_option(6, 337, 151, Raider27, 50)
end

function Raider22a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Raider26()
    else
        Raider23()
    end
end

function Raider23()
    fallout.gsay_message(337, 152, 51)
    RaiderSnap()
end

function Raider24()
    fallout.gsay_reply(337, 153)
    fallout.giq_option(4, 337, 154, Raider24a, 50)
    fallout.giq_option(4, 337, 155, Raider25, 50)
end

function Raider24a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 100 then
        fallout.item_caps_adjust(fallout.dude_obj(), -100)
        safe()
    else
        Raider23()
    end
end

function Raider25()
    fallout.gsay_message(337, 156, 51)
    RaiderSnap()
end

function Raider26()
    fallout.gsay_message(337, 157, 49)
    safe()
end

function Raider27()
    fallout.gsay_reply(337, 158)
    fallout.giq_option(5, 337, 159, Raider28, 50)
    fallout.giq_option(5, 337, 160, Raider27a, 50)
end

function Raider27a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Raider29()
    else
        Raider28()
    end
end

function Raider28()
    fallout.gsay_message(337, 161, 51)
    RaiderSnap()
end

function Raider29()
    fallout.gsay_reply(337, 162)
    fallout.giq_option(5, 337, 163, Raider29a, 50)
    fallout.giq_option(5, 337, 164, Raider30, 50)
end

function Raider29a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 100 then
        fallout.item_caps_adjust(fallout.dude_obj(), -100)
        safe()
    else
        Raider23()
    end
end

function Raider30()
    fallout.gsay_reply(337, 165)
    fallout.giq_option(5, 337, 166, Raider23, 50)
    fallout.giq_option(5, 337, 167, Raider30a, 50)
end

function Raider30a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 200 then
        fallout.item_caps_adjust(fallout.dude_obj(), -200)
        safe()
    else
        Raider23()
    end
end

function Raider31()
    fallout.gsay_reply(337, 168)
    fallout.giq_option(4, 337, 169, Raider32, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(6, 337, 172, Raider33, 51)
    else
        fallout.giq_option(6, 337, 173, Raider33, 51)
    end
end

function Raider32()
    fallout.gsay_message(337, 174, 51)
    RaiderSnap()
end

function Raider33()
    fallout.gsay_message(337, 175, 51)
    RaiderCombat()
end

function Raider34()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(337, 176), 2)
    RaiderSnap()
end

function Raiderend()
end

function RaiderCombat()
    hostile = 1
end

function RaiderSnap()
    shoot_Sinthia = 1
end

function safe()
    fallout.set_external_var("award", 1000)
    pissed = 0
    Sinthia_is_safe = 1
    fallout.set_obj_visibility(fallout.self_obj(), 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
