local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local look_at_p_proc
local map_enter_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local destroy_p_proc
local Morbid00
local Morbid00a
local Morbid01
local Morbid02
local Morbid03
local Morbid04
local Morbid04a
local Morbid05
local Morbid05a
local Morbid06
local Morbid07
local Morbid08
local Morbid09
local Morbid09a
local Morbid10
local Morbid11
local Morbid12
local Morbid13
local Morbid14
local Morbid15
local Morbid16
local Morbid17
local Morbid18
local Morbid19
local Morbid20
local Morbid21
local Morbid22
local Morbid23
local Morbid24
local Morbid25
local Morbid26
local Morbid27
local Morbid28
local Morbid00L
local Morbid00La
local Morbid01L
local Morbid02L
local Morbid02La
local Morbid03L
local Morbid04L
local Morbid05L
local Morbid06L
local Morbid07L
local Morbid08L
local Morbid09L
local Morbid10L
local Morbid00N
local Morbid00Na
local Morbid00Nb
local Morbid01N
local Morbid02N
local Morbid03N
local Morbid04N
local get_eye
local MorbidCombat
local MorbidEnd
local combat_p_proc
local damage_p_proc

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local heal = 0
local cost = 0
local getting_eye = false
local got_eye = false
local I_Hate_Player = false

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
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if getting_eye then
            get_eye()
        else
            local game_time_hour = fallout.game_time_hour()
            if game_time_hour > 2000 and game_time_hour < 2330 then
                if fallout.elevation(self_obj) ~= 1 then
                    fallout.use_obj(fallout.external_var("ladder_down"))
                else
                    if fallout.tile_num(self_obj) ~= 12702 then
                        fallout.animate_move_obj_to_tile(self_obj, 12702, 0)
                    end
                end
            else
                behaviour.sleeping(6, night_person, wake_time, sleep_time, home_tile, sleep_tile)
            end
        end
    end
    if fallout.global_var(346) == 1 then
        if fallout.obj_can_see_obj(self_obj, fallout.dude_obj()) then
            if not I_Hate_Player then
                hostile = true
                I_Hate_Player = true
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(104, 100))
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    misc.set_team(self_obj, 19)
    fallout.set_external_var("Morbid_ptr", self_obj)
    sleep_time = 2340
    wake_time = 810
    home_tile = 13501
    sleep_tile = 14098
    if not fallout.combat_is_initialized() then
        behaviour.sleeping(6, night_person, wake_time, sleep_time, home_tile, sleep_tile)
        local game_time_hour = fallout.game_time_hour()
        if game_time_hour > 1700 and game_time_hour < 2330 then
            fallout.move_to(self_obj, 12702, 1)
        elseif game_time_hour >= 2330 or game_time_hour < 800 then
            fallout.move_to(self_obj, sleep_tile, 1)
        else
            fallout.move_to(self_obj, home_tile, 0)
        end
    end
    fallout.rm_timer_event(self_obj)
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(10, 30)), 2)
end

function map_update_p_proc()
    if not fallout.combat_is_initialized() then
        local game_time_hour = fallout.game_time_hour()
        if game_time_hour > 1700 and game_time_hour < 2330 then
            fallout.move_to(fallout.self_obj(), 12702, 1)
        elseif game_time_hour >= 2330 or game_time_hour < 800 then
            fallout.move_to(fallout.self_obj(), sleep_tile, 1)
        else
            fallout.move_to(fallout.self_obj(), home_tile, 0)
        end
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.local_var(6) == 1 then
        fallout.display_msg(fallout.message_str(104, 232))
    else
        if fallout.local_var(9) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 101), 2)
        else
            reaction.get_reaction()
            fallout.start_gdialog(104, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if got_eye then
                Morbid09L()
            else
                if fallout.elevation(fallout.self_obj()) == 1 then
                    if fallout.local_var(5) == 0 then
                        Morbid00L()
                    else
                        Morbid01L()
                    end
                else
                    if time.game_time_in_days() >= 80 then
                        if fallout.local_var(7) == 0 then
                            Morbid17()
                        else
                            Morbid21()
                        end
                    else
                        if time.is_night() then
                            if fallout.local_var(4) ~= 0 then
                                Morbid04N()
                            else
                                Morbid00N()
                            end
                        else
                            if fallout.local_var(4) ~= 0 then
                                if fallout.local_var(1) > 1 then
                                    Morbid13()
                                else
                                    Morbid16()
                                end
                            else
                                if fallout.local_var(1) > 1 then
                                    Morbid00()
                                else
                                    Morbid15()
                                end
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

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        fallout.critter_injure(fallout.dude_obj(), 64)
        fallout.game_ui_enable()
        got_eye = true
        fallout.dialogue_system_enter()
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 2)
    elseif event == 2 then
        local self_obj = fallout.self_obj()
        local game_time_hour = fallout.game_time_hour()
        if fallout.elevation(self_obj) == 1 and game_time_hour > 1700 and game_time_hour < 2330 then
            fallout.reg_anim_func(2, self_obj)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_animate(self_obj, 11, -1)
            fallout.reg_anim_obj_move_to_tile(self_obj, 12901, -1)
            fallout.reg_anim_animate(self_obj, 10, -1)
            fallout.reg_anim_obj_move_to_tile(self_obj, 12702, -1)
            fallout.reg_anim_func(3, 0)
        end
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(10, 30)), 2)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
        reputation.inc_good_critter()
    end
end

function Morbid00()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(104, 101)
    fallout.giq_option(4, 104, 102, Morbid03, 50)
    fallout.giq_option(5, 104, 103, Morbid03, 50)
    fallout.giq_option(4, 104, 104, Morbid02, 50)
    fallout.giq_option(-3, 104, 105, Morbid00a, 51)
    fallout.giq_option(-3, 104, 106, Morbid03, 50)
    if fallout.global_var(305) == 1 and fallout.local_var(8) == 0 then
        fallout.giq_option(4, 104, 233, Morbid27, 51)
    end
end

function Morbid00a()
    reaction.DownReact()
    Morbid01()
end

function Morbid01()
    fallout.gsay_message(104, 107, 50)
end

function Morbid02()
    fallout.gsay_reply(104, 108)
    fallout.giq_option(4, 104, 109, MorbidEnd, 50)
    fallout.giq_option(4, 104, 110, reaction.DownReact, 51)
end

function Morbid03()
    fallout.gsay_message(104, 111, 0)
    if fallout.get_critter_stat(fallout.dude_obj(), 35) == fallout.get_critter_stat(fallout.dude_obj(), 7)
        and fallout.get_poison(fallout.dude_obj()) == 0
        and fallout.get_critter_stat(fallout.dude_obj(), 37) < 31 then
        Morbid04()
    else
        Morbid09()
    end
end

function Morbid04()
    fallout.gsay_reply(104, 112)
    fallout.giq_option(4, 104, 113, Morbid04a, 51)
    fallout.giq_option(4, 104, 114, Morbid07, 50)
end

function Morbid04a()
    reaction.DownReact()
    reaction.DownReact()
    Morbid05()
end

function Morbid05()
    fallout.gsay_reply(104, 115)
    fallout.giq_option(4, 104, 116, Morbid07, 50)
    fallout.giq_option(4, 104, 117, Morbid05a, 51)
end

function Morbid05a()
    reaction.DownReact()
    reaction.DownReact()
    Morbid06()
end

function Morbid06()
    fallout.set_external_var("fetch_dude", 1)
    fallout.gsay_message(104, 118, 50)
end

function Morbid07()
    if fallout.item_caps_total(fallout.dude_obj()) < 10 then
        Morbid08()
    else
        fallout.item_caps_adjust(fallout.dude_obj(), -10)
        fallout.gsay_message(104, 119, 50)
    end
end

function Morbid08()
    fallout.set_external_var("fetch_dude", 1)
    fallout.gsay_message(104, 120, 50)
end

function Morbid09()
    local dude_obj = fallout.dude_obj()
    local current_hp = fallout.get_critter_stat(dude_obj, 35)
    local max_hp = fallout.get_critter_stat(dude_obj, 7)
    fallout.gsay_message(104, 121, 50)
    local msg = fallout.message_str(104, 122)
    if current_hp == max_hp then
        msg = msg .. fallout.message_str(104, 178)
    elseif current_hp > max_hp * 0.7 then
        msg = msg .. fallout.message_str(104, 179)
    elseif current_hp > max_hp * 0.5 then
        msg = msg .. fallout.message_str(104, 180)
    elseif current_hp > max_hp * 0.3 then
        msg = msg .. fallout.message_str(104, 181)
    else
        msg = msg .. fallout.message_str(104, 182)
    end
    msg = msg .. fallout.message_str(104, fallout.random(183, 186))
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        msg = msg .. fallout.message_str(104, fallout.random(187, 190))
    end
    local rads = fallout.get_critter_stat(fallout.dude_obj(), 37)
    if rads > 30 then
        if rads < 101 then
            msg = msg .. fallout.message_str(104, 191)
        elseif rads < 201 then
            msg = msg .. fallout.message_str(104, 192)
        elseif rads < 401 then
            msg = msg .. fallout.message_str(104, 193)
        else
            msg = msg .. fallout.message_str(104, 194)
        end
    end
    if rads > 30 and rads < 251 then
        msg = msg .. fallout.message_str(104, 195)
    end
    heal = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    if fallout.local_var(1) >= 2 then
        cost = 20 * heal
        if fallout.get_poison(fallout.dude_obj()) ~= 0 then
            cost = cost + 50
        end
    else
        cost = 25 * heal
        if fallout.get_poison(fallout.dude_obj()) ~= 0 then
            cost = cost + 75
        end
    end
    if time.is_night() then
        cost = cost * 3 // 2
    end
    fallout.gsay_message(104, msg, 50)
    Morbid09a()
end

function Morbid09a()
    fallout.gsay_reply(104, fallout.message_str(104, 123) .. cost .. fallout.message_str(104, 124))
    fallout.giq_option(4, 104, 125, Morbid12, 50)
    fallout.giq_option(4, 104, 126, Morbid10, 51)
    fallout.giq_option(4, 104, 127, Morbid11, 50)
    fallout.giq_option(-3, 104, 128, Morbid12, 50)
    fallout.giq_option(-3, 104, 129, Morbid11, 50)
end

function Morbid10()
    reaction.DownReact()
    fallout.gsay_message(104, 130, 51)
end

function Morbid11()
    fallout.gsay_message(104, 131, 50)
end

function Morbid12()
    if fallout.item_caps_total(fallout.dude_obj()) < cost then
        Morbid08()
    else
        local dude_obj = fallout.dude_obj()
        fallout.item_caps_adjust(dude_obj, -cost)
        reaction.UpReact()
        fallout.gsay_message(104, 132, 50)
        fallout.gfade_out(600)
        local delay = 300 * heal
        if fallout.get_poison(dude_obj) then
            delay = delay + 1200
        end
        fallout.critter_heal(dude_obj,
            fallout.get_critter_stat(dude_obj, 7) - fallout.get_critter_stat(dude_obj, 35))
        fallout.poison(dude_obj, -fallout.get_poison(dude_obj))
        fallout.game_time_advance(fallout.game_ticks(delay))
        fallout.gfade_in(600)
        fallout.gsay_message(104, 133, 50)
    end
end

function Morbid13()
    fallout.gsay_reply(104, 134)
    fallout.giq_option(4, 104, 135, Morbid03, 50)
    fallout.giq_option(4, 104, 136, Morbid14, 50)
    fallout.giq_option(-3, 104, 137, Morbid03, 50)
    if fallout.global_var(305) == 1 and fallout.local_var(8) == 0 then
        fallout.giq_option(4, 104, 233, Morbid27, 51)
    end
end

function Morbid14()
    fallout.gsay_message(104, 138, 50)
end

function Morbid15()
    fallout.gsay_reply(104, 139)
    fallout.giq_option(4, 104, 140, Morbid03, 50)
    fallout.giq_option(4, 104, 141, Morbid03, 50)
    fallout.giq_option(4, 104, 142, Morbid02, 50)
    fallout.giq_option(-3, 104, 143, Morbid03, 50)
end

function Morbid16()
    fallout.gsay_reply(104, 144)
    fallout.giq_option(4, 104, 145, Morbid03, 50)
    fallout.giq_option(4, 104, 146, Morbid14, 50)
    fallout.giq_option(-3, 104, 147, Morbid03, 50)
end

function Morbid17()
    fallout.set_local_var(7, 1)
    if fallout.local_var(1) < 2 then
        reaction.UpReactLevel()
    end
    fallout.gsay_reply(104, 148)
    fallout.giq_option(4, 104, 149, Morbid03, 50)
    fallout.giq_option(4, 104, 150, Morbid19, 50)
    fallout.giq_option(5, 104, 151, Morbid18, 50)
    fallout.giq_option(-3, 104, 152, Morbid03, 50)
    if (fallout.global_var(305) == 1) and (fallout.local_var(8) == 0) then
        fallout.giq_option(4, 104, 233, Morbid27, 51)
    end
end

function Morbid18()
    fallout.gsay_reply(104, 153)
    fallout.giq_option(5, 104, 154, Morbid03, 50)
    fallout.giq_option(5, 104, 155, Morbid20, 50)
    fallout.giq_option(5, 104, 156, Morbid19, 50)
end

function Morbid19()
    fallout.gsay_message(104, 157, 50)
end

function Morbid20()
    local msg = fallout.message_str(104, 158)
    if fallout.global_var(37) == 0 then
        msg = msg .. fallout.message_str(104, 159)
    end
    msg = msg .. fallout.message_str(104, 160)
    fallout.gsay_reply(104, msg)
    fallout.giq_option(4, 104, 161, Morbid03, 50)
    fallout.giq_option(5, 104, 162, Morbid19, 50)
end

function Morbid21()
    fallout.gsay_reply(104, 163)
    fallout.giq_option(4, 104, 164, Morbid03, 50)
    fallout.giq_option(4, 104, 165, Morbid03, 50)
    fallout.giq_option(-3, 104, 166, Morbid03, 50)
    if fallout.global_var(305) == 1 and fallout.local_var(8) == 0 then
        fallout.giq_option(4, 104, 233, Morbid27, 51)
    end
end

function Morbid22()
    fallout.gsay_reply(104, 167)
    fallout.giq_option(4, 104, 168, Morbid03, 0)
    fallout.giq_option(5, 104, 169, Morbid03, 0)
    fallout.giq_option(-3, 104, 170, Morbid03, 0)
end

function Morbid23()
    fallout.gsay_message(104, 171, 50)
end

function Morbid24()
    fallout.gsay_message(104, 172, 50)
end

function Morbid25()
    fallout.gsay_message(104, 173, 50)
end

function Morbid26()
    fallout.gsay_reply(104, 174)
    fallout.giq_option(4, 104, 175, Morbid03, 50)
    fallout.giq_option(5, 104, 176, Morbid03, 50)
    fallout.giq_option(-3, 104, 177, Morbid03, 50)
end

function Morbid27()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(104, 234)
    fallout.giq_option(4, 104, 235, Morbid28, 51)
end

function Morbid28()
    reaction.BottomReact()
    fallout.gsay_message(104, 236, 51)
end

function Morbid00L()
    fallout.gsay_reply(104, 204)
    fallout.set_local_var(5, 1)
    fallout.giq_option(4, 104, 207, MorbidCombat, 51)
    fallout.giq_option(6, 104, 208, Morbid00La, 50)
    fallout.giq_option(-3, 104, 209, MorbidCombat, 50)
end

function Morbid00La()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Morbid02L()
    else
        Morbid01L()
    end
end

function Morbid01L()
    fallout.gsay_message(104, 210, 51)
    fallout.set_external_var("Gretch_call", 1)
end

function Morbid02L()
    fallout.gsay_reply(104, 211)
    fallout.giq_option(5, 104, 212, Morbid02La, 50)
    if fallout.global_var(305) == 1 then
        fallout.giq_option(5, 104, 213, Morbid03L, 51)
    end
end

function Morbid02La()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Morbid04L()
    else
        Morbid01L()
    end
end

function Morbid03L()
    fallout.gsay_message(104, 214, 51)
    fallout.set_external_var("Gretch_call", 1)
end

function Morbid04L()
    fallout.gsay_reply(104, 215)
    fallout.giq_option(5, 104, 216, Morbid06L, 50)
    fallout.giq_option(5, 104, 217, Morbid05L, 50)
end

function Morbid05L()
    local msg = fallout.message_str(104, 218)
    msg = msg .. fallout.message_str(104, 220)
    fallout.gsay_reply(104, msg)
    fallout.giq_option(5, 104, 221, Morbid07L, 50)
    fallout.giq_option(5, 104, 222, Morbid06L, 50)
end

function Morbid06L()
    fallout.gsay_message(104, 223, 51)
    fallout.set_external_var("Gretch_call", 1)
end

function Morbid07L()
    fallout.gsay_reply(104, 224)
    fallout.giq_option(5, 104, 225, Morbid08L, 50)
    fallout.giq_option(5, 104, 226, Morbid06L, 50)
end

function Morbid08L()
    fallout.gsay_message(104, 227, 50)
    getting_eye = true
end

function Morbid09L()
    got_eye = false
    fallout.gsay_reply(104, 229)
    fallout.giq_option(5, 104, 230, Morbid10L, 50)
end

function Morbid10L()
    fallout.gsay_message(104, 231, 50)
end

function Morbid00N()
    fallout.gsay_reply(104, 196)
    fallout.giq_option(4, 104, 197, Morbid00Na, 50)
    fallout.giq_option(5, 104, 198, Morbid00Nb, 50)
    fallout.giq_option(-3, 104, 199, Morbid03N, 50)
end

function Morbid00Na()
    if fallout.get_critter_stat(fallout.dude_obj(), 35) < fallout.get_critter_stat(fallout.dude_obj(), 7) - 7 then
        Morbid03()
    else
        Morbid01()
    end
end

function Morbid00Nb()
    if fallout.get_critter_stat(fallout.dude_obj(), 35) < fallout.get_critter_stat(fallout.dude_obj(), 7) - 3 then
        Morbid03()
    else
        Morbid02N()
    end
end

function Morbid01N()
    reaction.DownReact()
    fallout.gsay_message(104, 200, 51)
end

function Morbid02N()
    fallout.gsay_message(104, 201, 50)
end

function Morbid03N()
    fallout.gsay_message(104, 202, 50)
end

function Morbid04N()
    fallout.gsay_reply(104, 203)
    fallout.giq_option(4, 104, 197, Morbid00Na, 50)
    fallout.giq_option(5, 104, 198, Morbid00Nb, 50)
    fallout.giq_option(-3, 104, 199, Morbid03N, 50)
end

function get_eye()
    local self_obj = fallout.self_obj()
    fallout.game_ui_disable()
    getting_eye = false
    fallout.reg_anim_func(2, fallout.dude_obj())
    fallout.reg_anim_func(2, self_obj)
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_obj(self_obj, fallout.dude_obj(), -1)
    fallout.reg_anim_animate(self_obj, 12, -1)
    fallout.reg_anim_func(3, 0)
    fallout.rm_timer_event(self_obj)
    fallout.add_timer_event(self_obj, fallout.game_ticks(3), 1)
    fallout.display_msg(fallout.message_str(104, 228))
end

function MorbidCombat()
    hostile = true
end

function MorbidEnd()
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        fallout.set_local_var(9, 1)
        if fallout.elevation(fallout.self_obj()) == 0 then
            fallout.script_overrides()
            fallout.use_obj(fallout.external_var("ladder_down"))
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.combat_p_proc = combat_p_proc
exports.damage_p_proc = damage_p_proc
return exports
