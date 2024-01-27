local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local round_counter = 0
local sleeping_disabled = false
local challenger_hits = 0
local Saul_hits = 0
local whose_turn = 0

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

function start()
    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(247) == 0 then
            fallout.set_global_var(247, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.cur_map_index() == 11 then
            if fallout.external_var("fight") ~= 0 then
                fallout.set_external_var("fight", 0)
                Saul_hits = 0
                challenger_hits = 0
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
        if not sleeping_disabled then
            behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
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
    if fallout.global_var(169) == 0 then
        fallout.display_msg(fallout.message_str(528, 101))
    else
        fallout.display_msg(fallout.message_str(528, 100))
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(15) == 1 then
        local item_obj = fallout.create_object_sid(234, 0, 0, -1)
        fallout.add_obj_to_inven(self_obj, item_obj)
        fallout.kill_critter(self_obj, 48)
    end
    sleeping_disabled = false
    sleep_time = 2000
    wake_time = 700
    if fallout.cur_map_index() == 11 then
        sleep_tile = 7000
        if time.game_time_in_days() % 3 == 0 then
            home_tile = 15094
        else
            home_tile = 16892
        end
    end
    if fallout.global_var(169) == 3 then
        fallout.destroy_object(self_obj)
    end
    fallout.move_to(self_obj, home_tile, 0)
end

function map_update_p_proc()
    if not fallout.combat_is_initialized() then
        if time.game_time_in_days() % 3 == 0 then
            home_tile = 15094
        else
            home_tile = 16892
        end
        fallout.move_to(fallout.self_obj(), home_tile, 0)
        if fallout.local_var(8) == 1 then
            fallout.set_local_var(8, 0)
            fallout.reg_anim_animate(fallout.self_obj(), 0, 0)
        end
        behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(4) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if fallout.critter_state(fallout.self_obj()) & 1 ~= 0 then
            fallout.display_msg(fallout.message_str(528, 115))
        else
            if fallout.global_var(247) ~= 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 104), 2)
            else
                if misc.is_armed(fallout.dude_obj()) then
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
    if fallout.global_var(557) & 16 == 0 and fallout.global_var(557) & 8 ~= 0 then
        fallout.set_global_var(557, fallout.global_var(557) + 16)
        fallout.display_msg(fallout.message_str(342, 173))
        fallout.give_exp_points(250)
    end
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if fallout.obj_pid(fallout.external_var("challenger_ptr")) == 16777227 then
            if fallout.random(0, 4) == 0 then
                whose_turn = 1
            else
                whose_turn = 0
            end
        else
            if fallout.random(0, 2) then
                whose_turn = 1
            else
                whose_turn = 0
            end
        end
        SaulBoxing()
    elseif event == 2 then
        fallout.set_external_var("Saul_wins", 1)
    elseif event == 3 then
        fallout.set_external_var("Saul_loses", 1)
        fallout.set_local_var(8, 1)
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
    fallout.giq_option(4, 528,
        fallout.message_str(528, 109) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(528, 110), Saul09, 50)
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
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 528, 138, Saul13, 50)
    end
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 528, 139, Saul14, 50)
    end
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul12()
    reaction.UpReact()
    if fallout.local_var(1) == 1 then
        fallout.gsay_reply(528, 140)
    else
        fallout.gsay_reply(528, 141)
        fallout.giq_option(5, 528, 142, Saul15, 49)
    end
    fallout.giq_option(4, 528, 143, Saul13, 50)
    fallout.giq_option(4, 528, 144, Saul14, 50)
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul13()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(528, 145)
    fallout.giq_option(4, 528, 146, Saul19, 50)
    fallout.giq_option(4, 528, 147, Saul14, 50)
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul14()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(528, 148)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 528, 149, Saul13, 50)
    end
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul15()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(528, 150)
    fallout.giq_option(4, 528, 151, Saul17, 50)
    fallout.giq_option(4, 528, 152, Saul18, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.giq_option(6, 528, 153, Saul16, 49)
    else
        fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
    end
    fallout.giq_option(6, 528, 154, Saul24, 50)
end

function Saul16()
    reaction.UpReact()
    fallout.gsay_reply(528, 155)
    fallout.giq_option(4, 528, 156, Saul18, 50)
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul17()
    fallout.gsay_reply(528, 157)
    fallout.giq_option(4, 528, 158, Saul18, 50)
    if fallout.global_var(557) & 1 ~= 0 or fallout.global_var(557) & 4 ~= 0 then
        fallout.giq_option(5, 528, 159, Saul20, 50)
    end
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul18()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(528, 160)
    else
        fallout.gsay_reply(528, 161)
    end
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 528, 162, Saul13, 50)
    end
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 528, 163, Saul14, 50)
    end
    fallout.giq_option(4, 528, 164, Saul18a, 51)
    fallout.giq_option(4, 528, 165, SaulEnd, 50)
end

function Saul18a()
    fallout.set_local_var(1, 1)
    reaction.LevelToReact()
    Saul09()
end

function Saul19()
    fallout.gsay_reply(528, 166)
    fallout.giq_option(4, 528, 168, Saul18, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.giq_option(6, 528, 167, reaction.UpReact, 49)
    else
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
    reaction.UpReact()
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
    if fallout.global_var(557) & 1 ~= 0 or fallout.global_var(557) & 4 ~= 0 and fallout.global_var(557) & 8 == 0 then
        fallout.giq_option(4, 528, 183, Saul20, 50)
    end
    if fallout.local_var(5) == 0 then
        fallout.giq_option(4, 528, 184, Saul13, 50)
    end
    fallout.giq_option(4, 528, reaction.Goodbyes(), SaulEnd, 50)
end

function Saul24()
    fallout.gsay_reply(528, 185)
    fallout.giq_option(4, 528, 186, SaulEnd, 0)
    fallout.giq_option(4, 528, 187, Saul18, 0)
end

function SaulBoxing()
    local self_obj = fallout.self_obj()
    local challenger_obj = fallout.external_var("challenger_ptr")
    fallout.reg_anim_func(2, self_obj)
    fallout.reg_anim_func(2, challenger_obj)
    if whose_turn == 1 then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(self_obj, 16, -1)
        if fallout.is_success(fallout.roll_vs_skill(self_obj, 3, 0)) then
            if challenger_hits >= fallout.get_critter_stat(challenger_obj, 2) * 2 then
                fallout.reg_anim_animate(challenger_obj, 20, 4)
                fallout.reg_anim_animate(challenger_obj, 48, -1)
                fallout.add_timer_event(self_obj, fallout.game_ticks(2), 2)
            else
                fallout.reg_anim_animate(challenger_obj, 14, 4)
                challenger_hits = challenger_hits + 1
                fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 2)), 1)
            end
        else
            fallout.reg_anim_animate(challenger_obj, 13, 4)
            fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 2)), 1)
        end
        fallout.reg_anim_func(3, 0)
    else
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(challenger_obj, 16, -1)
        if fallout.is_success(fallout.roll_vs_skill(challenger_obj, 3, 0)) then
            if Saul_hits >= fallout.get_critter_stat(self_obj, 2) * 2 then
                fallout.reg_anim_animate(self_obj, 20, 4)
                fallout.reg_anim_animate(self_obj, 48, -1)
                fallout.add_timer_event(self_obj, fallout.game_ticks(2), 3)
            else
                fallout.reg_anim_animate(self_obj, 14, 4)
                Saul_hits = Saul_hits + 1
                fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 2)), 1)
            end
        else
            fallout.reg_anim_animate(self_obj, 13, 4)
            fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 2)), 1)
        end
        fallout.reg_anim_func(3, 0)
    end
end

function SaulCombat()
    hostile = true
end

function SaulEnd()
end

function create_challenger()
    local challenger_obj
    local rnd = fallout.random(0, 4)
    if rnd == 4 then
        challenger_obj = fallout.create_object_sid(16777226, 0, 0, 25)
    elseif rnd == 3 then
        challenger_obj = fallout.create_object_sid(16777227, 0, 0, 25)
    elseif rnd == 2 then
        challenger_obj = fallout.create_object_sid(16777238, 0, 0, 25)
    elseif rnd == 1 then
        challenger_obj = fallout.create_object_sid(16777218, 0, 0, 25)
    elseif rnd == 0 then
        challenger_obj = fallout.create_object_sid(16777243, 0, 0, 25)
    end
    fallout.critter_attempt_placement(challenger_obj,
        fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 1, 1), 0)
    fallout.anim(challenger_obj, 1000, 4)
    fallout.set_external_var("challenger_ptr", challenger_obj)
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
