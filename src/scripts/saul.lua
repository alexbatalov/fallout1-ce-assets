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

local start
local combat_p_proc
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local map_update_p_proc
local talk_p_proc
local timed_event_p_proc
local damage_p_proc
local Saul06
local Saul07
local Saul08
local Saul09
local Saul10
local Saul11
local Saul12
local Saul13
local Saul14
local Saul15
local Saul16
local Saul17
local Saul18
local Saul18a
local Saul19
local Saul20
local Saul21
local Saul22
local Saul23
local Saul24
local SaulBoxing
local SaulCombat
local SaulEnd
local create_challenger
local sleeping

-- ?import? variable night_person
-- ?import? variable wake_time
-- ?import? variable sleep_time
-- ?import? variable home_tile
-- ?import? variable sleep_tile
-- ?import? variable hostile
-- ?import? variable initialized
-- ?import? variable round_counter
-- ?import? variable sleeping_disabled
-- ?import? variable challenger_hits
-- ?import? variable Saul_hits
-- ?import? variable whose_turn
-- ?import? variable removal_ptr

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

function start()
    if fallout.script_action() == 13 then
        combat_p_proc()
    else
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
                            if fallout.script_action() == 23 then
                                map_update_p_proc()
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
end

function combat_p_proc()
    if (fallout.fixed_param() == 4) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        g7 = g7 + 1
    end
    if g7 > 3 then
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    if g5 then
        g5 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.cur_map_index() == 11 then
            if fallout.external_var("fight") then
                fallout.set_external_var("fight", 0)
                g10 = 0
                g9 = 0
                fallout.anim(fallout.self_obj(), 1000, 1)
                if fallout.obj_can_see_obj(fallout.dude_obj(), fallout.self_obj()) then
                    fallout.gfade_out(600)
                    create_challenger()
                    fallout.gfade_in(600)
                else
                    create_challenger()
                end
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
            end
        end
        if g8 == 0 then
            sleeping()
        end
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function description_p_proc()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
        fallout.display_msg(fallout.message_str(528, 102))
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
    fallout.set_global_var(169, 3)
end

function look_at_p_proc()
    fallout.script_overrides()
    if not(fallout.global_var(169)) then
        fallout.display_msg(fallout.message_str(528, 101))
    else
        fallout.display_msg(fallout.message_str(528, 100))
    end
end

function map_enter_p_proc()
    local v0 = 0
    if fallout.global_var(15) == 1 then
        v0 = fallout.create_object_sid(234, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.self_obj(), v0)
        fallout.kill_critter(fallout.self_obj(), 48)
    end
    g8 = 0
    g2 = 2000
    g1 = 700
    if fallout.cur_map_index() == 11 then
        g4 = 7000
        if (time.game_time_in_days() % 3) == 0 then
            g3 = 15094
        else
            g3 = 16892
        end
    end
    if fallout.global_var(169) == 3 then
        fallout.destroy_object(fallout.self_obj())
    end
    fallout.move_to(fallout.self_obj(), g3, 0)
end

function map_update_p_proc()
    if not(fallout.combat_is_initialized()) then
        if (time.game_time_in_days() % 3) == 0 then
            g3 = 15094
        else
            g3 = 16892
        end
        fallout.move_to(fallout.self_obj(), g3, 0)
        if fallout.local_var(8) == 1 then
            fallout.set_local_var(8, 0)
            fallout.reg_anim_animate(fallout.self_obj(), 0, 0)
        end
        sleeping()
    end
end

function talk_p_proc()
    get_reaction()
    if fallout.local_var(4) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if fallout.critter_state(fallout.self_obj()) & 1 then
            fallout.display_msg(fallout.message_str(528, 115))
        else
            if fallout.global_var(247) ~= 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 104), 2)
            else
                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                    Saul06()
                else
                    fallout.start_gdialog(528, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    if fallout.global_var(169) ~= 0 then
                        Saul23()
                    else
                        Saul07()
                    end
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
    if not(fallout.global_var(557) & 16) and (fallout.global_var(557) & 8) then
        fallout.set_global_var(557, fallout.global_var(557) + 16)
        fallout.display_msg(fallout.message_str(342, 173))
        fallout.give_exp_points(250)
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if fallout.obj_pid(fallout.external_var("challenger_ptr")) == 16777227 then
            if fallout.random(0, 4) == 0 then
                g11 = 1
            else
                g11 = 0
            end
        else
            if fallout.random(0, 2) then
                g11 = 1
            else
                g11 = 0
            end
        end
        SaulBoxing()
    else
        if fallout.fixed_param() == 2 then
            fallout.set_external_var("Saul_wins", 1)
        else
            if fallout.fixed_param() == 3 then
                fallout.set_external_var("Saul_loses", 1)
                fallout.set_local_var(8, 1)
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function Saul06()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(528, 104), 2)
end

function Saul07()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(528, 105)
    else
        fallout.gsay_reply(528, 106)
    end
    fallout.giq_option(4, 528, 107, Saul08, 50)
    fallout.giq_option(4, 528, 108, Saul09, 51)
    fallout.giq_option(4, 528, fallout.message_str(528, 109) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(528, 110), Saul09, 50)
end

function Saul08()
    fallout.gsay_reply(528, 111)
    fallout.giq_option(4, 528, 112, Saul09, 51)
    fallout.giq_option(4, 528, 113, Saul11, 50)
    fallout.giq_option(4, 528, 103, SaulEnd, 50)
end

function Saul09()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(528, 128)
    else
        fallout.gsay_reply(528, 129)
    end
    if fallout.local_var(1) == 1 then
        fallout.giq_option(4, 528, 130, Saul10, 50)
        fallout.giq_option(4, 528, 188, SaulCombat, 51)
    end
    fallout.giq_option(4, 528, 131, Saul10, 50)
    if fallout.local_var(1) == 3 then
        fallout.giq_option(4, 528, 135, Saul11, 50)
    end
    fallout.giq_option(4, 528, 132, SaulEnd, 50)
end

function Saul10()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(528, 133)
    else
        fallout.gsay_reply(528, 134)
    end
    fallout.giq_option(4, 528, 135, Saul11, 50)
    fallout.giq_option(4, 528, 136, Saul12, 49)
    fallout.giq_option(4, 528, 132, SaulEnd, 50)
end

function Saul11()
    fallout.gsay_reply(528, 137)
    fallout.giq_option(4, 528, 136, Saul12, 49)
    if not(fallout.local_var(5)) then
        fallout.giq_option(4, 528, 138, Saul13, 50)
    end
    if not(fallout.local_var(6)) then
        fallout.giq_option(4, 528, 139, Saul14, 50)
    end
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul12()
    UpReact()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(528, 140)
    else
        fallout.gsay_reply(528, 141)
        fallout.giq_option(5, 528, 142, Saul15, 49)
    end
    fallout.giq_option(4, 528, 143, Saul13, 50)
    fallout.giq_option(4, 528, 144, Saul14, 50)
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul13()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(528, 145)
    fallout.giq_option(4, 528, 146, Saul19, 50)
    fallout.giq_option(4, 528, 147, Saul14, 50)
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul14()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(528, 148)
    if not(fallout.local_var(5)) then
        fallout.giq_option(4, 528, 149, Saul13, 50)
    end
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul15()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(528, 150)
    fallout.giq_option(4, 528, 151, Saul17, 50)
    fallout.giq_option(4, 528, 152, Saul18, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.giq_option(6, 528, 153, Saul16, 49)
    else
        Goodbyes()
        fallout.giq_option(4, 528, g12, SaulEnd, 50)
    end
    fallout.giq_option(6, 528, 154, Saul24, 50)
end

function Saul16()
    UpReact()
    fallout.gsay_reply(528, 155)
    fallout.giq_option(4, 528, 156, Saul18, 50)
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul17()
    fallout.gsay_reply(528, 157)
    fallout.giq_option(4, 528, 158, Saul18, 50)
    if (fallout.global_var(557) & 1) or (fallout.global_var(557) & 4) then
        fallout.giq_option(5, 528, 159, Saul20, 50)
    end
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul18()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(528, 160)
    else
        fallout.gsay_reply(528, 161)
    end
    if not(fallout.local_var(5)) then
        fallout.giq_option(4, 528, 162, Saul13, 50)
    end
    if not(fallout.local_var(6)) then
        fallout.giq_option(4, 528, 163, Saul14, 50)
    end
    fallout.giq_option(4, 528, 164, Saul18a, 51)
    fallout.giq_option(4, 528, 165, SaulEnd, 50)
end

function Saul18a()
    fallout.set_local_var(1, 1)
    LevelToReact()
    Saul09()
end

function Saul19()
    fallout.gsay_reply(528, 166)
    fallout.giq_option(4, 528, 168, Saul18, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.giq_option(6, 528, 167, UpReact, 49)
    else
        Goodbyes()
        fallout.giq_option(4, 528, 169, SaulEnd, 50)
    end
end

function Saul20()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(528, 169)
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            fallout.gsay_reply(528, fallout.message_str(528, 170) .. fallout.message_str(528, 171))
            if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
                fallout.giq_option(6, 528, 172, Saul21, 49)
            else
                fallout.giq_option(4, 528, 173, Saul22, 50)
            end
        else
            fallout.gsay_reply(528, fallout.message_str(528, 170))
        end
    end
    fallout.giq_option(4, 528, 174, Saul18, 50)
    fallout.giq_option(4, 528, 175, SaulEnd, 50)
end

function Saul21()
    UpReact()
    fallout.set_global_var(557, fallout.global_var(557) + 8)
    fallout.gsay_message(528, 176, 49)
end

function Saul22()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Saul21()
    else
        fallout.gsay_reply(528, 177)
        fallout.giq_option(4, 528, 178, Saul18, 50)
        fallout.giq_option(4, 528, 179, SaulEnd, 50)
    end
end

function Saul23()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(528, 180)
    else
        fallout.gsay_reply(528, 181)
    end
    fallout.giq_option(4, 528, 182, Saul09, 51)
    if (fallout.global_var(557) & 1) or (fallout.global_var(557) & 4) and not(fallout.global_var(557) & 8) then
        fallout.giq_option(4, 528, 183, Saul20, 50)
    end
    if not(fallout.local_var(5)) then
        fallout.giq_option(4, 528, 184, Saul13, 50)
    end
    Goodbyes()
    fallout.giq_option(4, 528, g12, SaulEnd, 50)
end

function Saul24()
    fallout.gsay_reply(528, 185)
    fallout.giq_option(4, 528, 186, SaulEnd, 0)
    fallout.giq_option(4, 528, 187, Saul18, 0)
end

function SaulBoxing()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(2, fallout.external_var("challenger_ptr"))
    if g11 == 1 then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(fallout.self_obj(), 16, -1)
        if fallout.is_success(fallout.roll_vs_skill(fallout.self_obj(), 3, 0)) then
            if g9 >= (fallout.get_critter_stat(fallout.external_var("challenger_ptr"), 2) * 2) then
                fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 20, 4)
                fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 48, -1)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 2)
            else
                fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 14, 4)
                g9 = g9 + 1
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 2)), 1)
            end
        else
            fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 13, 4)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 2)), 1)
        end
        fallout.reg_anim_func(3, 0)
    else
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 16, -1)
        if fallout.is_success(fallout.roll_vs_skill(fallout.external_var("challenger_ptr"), 3, 0)) then
            if g10 >= (fallout.get_critter_stat(fallout.self_obj(), 2) * 2) then
                fallout.reg_anim_animate(fallout.self_obj(), 20, 4)
                fallout.reg_anim_animate(fallout.self_obj(), 48, -1)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 3)
            else
                fallout.reg_anim_animate(fallout.self_obj(), 14, 4)
                g10 = g10 + 1
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 2)), 1)
            end
        else
            fallout.reg_anim_animate(fallout.self_obj(), 13, 4)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 2)), 1)
        end
        fallout.reg_anim_func(3, 0)
    end
end

function SaulCombat()
    g5 = 1
end

function SaulEnd()
end

function create_challenger()
    fallout.set_external_var("challenger_ptr", fallout.random(0, 4))
    if fallout.external_var("challenger_ptr") == 4 then
        fallout.set_external_var("challenger_ptr", fallout.create_object_sid(16777226, 0, 0, 25))
    else
        if fallout.external_var("challenger_ptr") == 3 then
            fallout.set_external_var("challenger_ptr", fallout.create_object_sid(16777227, 0, 0, 25))
        else
            if fallout.external_var("challenger_ptr") == 2 then
                fallout.set_external_var("challenger_ptr", fallout.create_object_sid(16777238, 0, 0, 25))
            else
                if fallout.external_var("challenger_ptr") == 1 then
                    fallout.set_external_var("challenger_ptr", fallout.create_object_sid(16777218, 0, 0, 25))
                else
                    if fallout.external_var("challenger_ptr") == 0 then
                        fallout.set_external_var("challenger_ptr", fallout.create_object_sid(16777243, 0, 0, 25))
                    end
                end
            end
        end
    end
    fallout.critter_attempt_placement(fallout.external_var("challenger_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 1, 1), 0)
    fallout.anim(fallout.external_var("challenger_ptr"), 1000, 4)
end

function sleeping()
    if fallout.local_var(4) == 1 then
        if not(g0) and (fallout.game_time_hour() >= g1) and (fallout.game_time_hour() < g2) or (g0 and ((fallout.game_time_hour() >= g1) or (fallout.game_time_hour() < g2))) then
            if ((fallout.game_time_hour() - g1) < 10) and ((fallout.game_time_hour() - g1) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= g3 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), g3, 0)
                else
                    fallout.set_local_var(4, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), g3, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == g3 then
                    fallout.set_local_var(4, 0)
                end
            end
        end
    else
        if g0 and (fallout.game_time_hour() >= g2) and (fallout.game_time_hour() < g1) or (not(g0) and ((fallout.game_time_hour() >= g2) or (fallout.game_time_hour() < g1))) then
            if ((fallout.game_time_hour() - g2) < 10) and ((fallout.game_time_hour() - g2) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= g4 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(4, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= g4 then
                    fallout.move_to(fallout.self_obj(), g4, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(4, 1)
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
    g12 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
