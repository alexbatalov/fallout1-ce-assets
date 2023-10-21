local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

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
local sleeping

-- ?import? variable night_person
-- ?import? variable wake_time
-- ?import? variable sleep_time
-- ?import? variable home_tile
-- ?import? variable sleep_tile
-- ?import? variable hostile
-- ?import? variable heal
-- ?import? variable COST
-- ?import? variable BONUS
-- ?import? variable DIAGNOSIS
-- ?import? variable rndx
-- ?import? variable getting_eye
-- ?import? variable got_eye
-- ?import? variable I_Hate_Player
-- ?import? variable ladder_up

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

local combat_p_proc
local damage_p_proc

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
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
                    if fallout.script_action() == 23 then
                        map_update_p_proc()
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
    if g5 then
        g5 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if g11 then
            get_eye()
        else
            if (fallout.game_time_hour() > 2000) and (fallout.game_time_hour() < 2330) then
                if fallout.elevation(fallout.self_obj()) ~= 1 then
                    fallout.use_obj(fallout.external_var("ladder_down"))
                else
                    if fallout.tile_num(fallout.self_obj()) ~= 12702 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 12702, 0)
                    end
                end
            else
                sleeping()
            end
        end
    end
    if fallout.global_var(346) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if g13 == 0 then
                g5 = 1
                g13 = 1
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(104, 100))
end

function map_enter_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 19)
    fallout.set_external_var("Morbid_ptr", fallout.self_obj())
    g2 = 2340
    g1 = 810
    g3 = 13501
    g4 = 14098
    if fallout.combat_is_initialized() == 0 then
        sleeping()
        if (fallout.game_time_hour() > 1700) and (fallout.game_time_hour() < 2330) then
            fallout.move_to(fallout.self_obj(), 12702, 1)
        else
            if (fallout.game_time_hour() >= 2330) or (fallout.game_time_hour() < 800) then
                fallout.move_to(fallout.self_obj(), g4, 1)
            else
                fallout.move_to(fallout.self_obj(), g3, 0)
            end
        end
    end
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 2)
end

function map_update_p_proc()
    if fallout.combat_is_initialized() == 0 then
        if (fallout.game_time_hour() > 1700) and (fallout.game_time_hour() < 2330) then
            fallout.move_to(fallout.self_obj(), 12702, 1)
        else
            if (fallout.game_time_hour() >= 2330) or (fallout.game_time_hour() < 800) then
                fallout.move_to(fallout.self_obj(), g4, 1)
            else
                fallout.move_to(fallout.self_obj(), g3, 0)
            end
        end
    end
end

function pickup_p_proc()
    g5 = 1
end

function talk_p_proc()
    if fallout.local_var(6) == 1 then
        fallout.display_msg(fallout.message_str(104, 232))
    else
        if fallout.local_var(9) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 101), 2)
        else
            get_reaction()
            fallout.start_gdialog(104, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if g12 then
                Morbid09L()
            else
                if fallout.elevation(fallout.self_obj()) == 1 then
                    if not(fallout.local_var(5)) then
                        Morbid00L()
                    else
                        Morbid01L()
                    end
                else
                    if time.game_time_in_days() >= 80 then
                        if not(fallout.local_var(7)) then
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
    if fallout.fixed_param() == 1 then
        fallout.critter_injure(fallout.dude_obj(), 64)
        fallout.game_ui_enable()
        g12 = 1
        fallout.dialogue_system_enter()
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 2)
    else
        if fallout.fixed_param() == 2 then
            if (fallout.elevation(fallout.self_obj()) == 1) and (fallout.game_time_hour() > 1700) and (fallout.game_time_hour() < 2330) then
                fallout.reg_anim_func(2, fallout.self_obj())
                fallout.reg_anim_func(1, 1)
                fallout.reg_anim_animate(fallout.self_obj(), 11, -1)
                fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 12901, -1)
                fallout.reg_anim_animate(fallout.self_obj(), 10, -1)
                fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 12702, -1)
                fallout.reg_anim_func(3, 0)
            end
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 2)
        end
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
    if (fallout.global_var(305) == 1) and (fallout.local_var(8) == 0) then
        fallout.giq_option(4, 104, 233, Morbid27, 51)
    end
end

function Morbid00a()
    DownReact()
    Morbid01()
end

function Morbid01()
    fallout.gsay_message(104, 107, 50)
end

function Morbid02()
    fallout.gsay_reply(104, 108)
    fallout.giq_option(4, 104, 109, MorbidEnd, 50)
    fallout.giq_option(4, 104, 110, DownReact, 51)
end

function Morbid03()
    fallout.gsay_message(104, 111, 0)
    if (fallout.get_critter_stat(fallout.dude_obj(), 35) == fallout.get_critter_stat(fallout.dude_obj(), 7)) and not(fallout.get_poison(fallout.dude_obj())) and (fallout.get_critter_stat(fallout.dude_obj(), 37) < 31) then
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
    DownReact()
    DownReact()
    Morbid05()
end

function Morbid05()
    fallout.gsay_reply(104, 115)
    fallout.giq_option(4, 104, 116, Morbid07, 50)
    fallout.giq_option(4, 104, 117, Morbid05a, 51)
end

function Morbid05a()
    DownReact()
    DownReact()
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
    local v0 = 0
    fallout.gsay_message(104, 121, 50)
    g9 = fallout.message_str(104, 122)
    if fallout.get_critter_stat(fallout.dude_obj(), 35) == fallout.get_critter_stat(fallout.dude_obj(), 7) then
        g9 = g9 .. fallout.message_str(104, 178)
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 35) > (fallout.get_critter_stat(fallout.dude_obj(), 7) * 0.70000) then
            g9 = g9 .. fallout.message_str(104, 179)
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 35) > (fallout.get_critter_stat(fallout.dude_obj(), 7) * 0.50000) then
                g9 = g9 .. fallout.message_str(104, 180)
            else
                if fallout.get_critter_stat(fallout.dude_obj(), 35) > (fallout.get_critter_stat(fallout.dude_obj(), 7) * 0.30000) then
                    g9 = g9 .. fallout.message_str(104, 181)
                else
                    g9 = g9 .. fallout.message_str(104, 182)
                end
            end
        end
    end
    g9 = g9 .. fallout.message_str(104, fallout.random(183, 186))
    if fallout.get_poison(fallout.dude_obj()) then
        g9 = g9 .. fallout.message_str(104, fallout.random(187, 190))
    end
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 37)
    if v0 > 30 then
        if v0 < 101 then
            g9 = g9 .. fallout.message_str(104, 191)
        else
            if v0 < 201 then
                g9 = g9 .. fallout.message_str(104, 192)
            else
                if v0 < 401 then
                    g9 = g9 .. fallout.message_str(104, 193)
                else
                    g9 = g9 .. fallout.message_str(104, 194)
                end
            end
        end
    end
    if (v0 > 30) and (v0 < 251) then
        g9 = g9 .. fallout.message_str(104, 195)
    end
    g6 = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    if fallout.local_var(1) >= 2 then
        g7 = 20 * g6
        if fallout.get_poison(fallout.dude_obj()) then
            g7 = g7 + 50
        end
    else
        g7 = 25 * g6
        if fallout.get_poison(fallout.dude_obj()) then
            g7 = g7 + 75
        end
    end
    if time.is_night() then
        g7 = g7 * (3 // 2)
    end
    fallout.gsay_message(104, g9, 50)
    Morbid09a()
end

function Morbid09a()
    fallout.gsay_reply(104, fallout.message_str(104, 123) .. g7 .. fallout.message_str(104, 124))
    fallout.giq_option(4, 104, 125, Morbid12, 50)
    fallout.giq_option(4, 104, 126, Morbid10, 51)
    fallout.giq_option(4, 104, 127, Morbid11, 50)
    fallout.giq_option(-3, 104, 128, Morbid12, 50)
    fallout.giq_option(-3, 104, 129, Morbid11, 50)
end

function Morbid10()
    DownReact()
    fallout.gsay_message(104, 130, 51)
end

function Morbid11()
    fallout.gsay_message(104, 131, 50)
end

function Morbid12()
    if fallout.item_caps_total(fallout.dude_obj()) < g7 then
        Morbid08()
    else
        fallout.item_caps_adjust(fallout.dude_obj(), -g7)
        UpReact()
        fallout.gsay_message(104, 132, 50)
        fallout.gfade_out(600)
        g10 = 300 * g6
        if fallout.get_poison(fallout.dude_obj()) then
            g10 = g10 + 1200
        end
        fallout.critter_heal(fallout.dude_obj(), fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35))
        fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
        fallout.game_time_advance(fallout.game_ticks(g10))
        fallout.gfade_in(600)
        fallout.gsay_message(104, 133, 50)
    end
end

function Morbid13()
    fallout.gsay_reply(104, 134)
    fallout.giq_option(4, 104, 135, Morbid03, 50)
    fallout.giq_option(4, 104, 136, Morbid14, 50)
    fallout.giq_option(-3, 104, 137, Morbid03, 50)
    if (fallout.global_var(305) == 1) and (fallout.local_var(8) == 0) then
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
        UpReactLevel()
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
    local v0 = 0
    v0 = fallout.message_str(104, 158)
    if not(fallout.global_var(37)) then
        v0 = v0 .. fallout.message_str(104, 159)
    end
    v0 = v0 .. fallout.message_str(104, 160)
    fallout.gsay_reply(104, v0)
    fallout.giq_option(4, 104, 161, Morbid03, 50)
    fallout.giq_option(5, 104, 162, Morbid19, 50)
end

function Morbid21()
    fallout.gsay_reply(104, 163)
    fallout.giq_option(4, 104, 164, Morbid03, 50)
    fallout.giq_option(4, 104, 165, Morbid03, 50)
    fallout.giq_option(-3, 104, 166, Morbid03, 50)
    if (fallout.global_var(305) == 1) and (fallout.local_var(8) == 0) then
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
    BottomReact()
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
    local v0 = 0
    v0 = fallout.message_str(104, 218)
    v0 = v0 .. fallout.message_str(104, 220)
    fallout.gsay_reply(104, v0)
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
    g11 = 1
end

function Morbid09L()
    g12 = 0
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
    if fallout.get_critter_stat(fallout.dude_obj(), 35) < (fallout.get_critter_stat(fallout.dude_obj(), 7) - 7) then
        Morbid03()
    else
        Morbid01()
    end
end

function Morbid00Nb()
    if fallout.get_critter_stat(fallout.dude_obj(), 35) < (fallout.get_critter_stat(fallout.dude_obj(), 7) - 3) then
        Morbid03()
    else
        Morbid02N()
    end
end

function Morbid01N()
    DownReact()
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
    fallout.game_ui_disable()
    g11 = 0
    fallout.reg_anim_func(2, fallout.dude_obj())
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_obj(fallout.self_obj(), fallout.dude_obj(), -1)
    fallout.reg_anim_animate(fallout.self_obj(), 12, -1)
    fallout.reg_anim_func(3, 0)
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
    fallout.display_msg(fallout.message_str(104, 228))
end

function MorbidCombat()
    g5 = 1
end

function MorbidEnd()
end

function sleeping()
    if fallout.local_var(6) == 1 then
        if not(g0) and (fallout.game_time_hour() >= g1) and (fallout.game_time_hour() < g2) or (g0 and ((fallout.game_time_hour() >= g1) or (fallout.game_time_hour() < g2))) then
            if ((fallout.game_time_hour() - g1) < 10) and ((fallout.game_time_hour() - g1) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= g3 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), g3, 0)
                else
                    fallout.set_local_var(6, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), g3, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == g3 then
                    fallout.set_local_var(6, 0)
                end
            end
        end
    else
        if g0 and (fallout.game_time_hour() >= g2) and (fallout.game_time_hour() < g1) or (not(g0) and ((fallout.game_time_hour() >= g2) or (fallout.game_time_hour() < g1))) then
            if ((fallout.game_time_hour() - g2) < 10) and ((fallout.game_time_hour() - g2) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= g4 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(6, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= g4 then
                    fallout.move_to(fallout.self_obj(), g4, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(6, 1)
                end
            end
        end
    end
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
    g14 = fallout.message_str(634, fallout.random(100, 105))
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
