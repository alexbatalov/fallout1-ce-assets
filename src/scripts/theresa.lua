local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Theresa01
local Theresa02
local Theresa02a
local Theresa03
local Theresa04
local Theresa05
local Theresa06
local Theresa07
local Theresa08
local Theresa09
local Theresa10
local Theresa11
local Theresa12
local Theresa13
local Theresa14
local Theresa15
local Theresa16
local Theresa17
local Theresa18
local Theresa19
local Theresa20
local Theresa21
local Theresa22
local Theresa23
local Theresa24
local Theresa25
local TheresaEnd
local TheresaCombat
local begin_meeting
local say_lines
local rebel_meeting
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local not_at_meeting = 1
local line = 0
local hostile = 0
local exp_flag = 0

local exit_line = 0

function start()
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
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (time.game_time_in_days() > fallout.map_var(5)) and (fallout.global_var(238) ~= 2) then
            fallout.destroy_object(fallout.self_obj())
        end
        if (fallout.game_time_hour() >= 1700) and (fallout.game_time_hour() < 1710) then
            if fallout.global_var(238) ~= 2 then
                if not_at_meeting then
                    rebel_meeting()
                end
            end
        end
        sleeping()
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(8, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(238, 2)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(378, 100))
end

function map_enter_p_proc()
    if not(fallout.local_var(4)) then
        fallout.set_local_var(4, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(4)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    sleep_tile = home_tile
    sleep_time = 1915
    wake_time = 715
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.map_var(5) == 250 then
        fallout.set_map_var(5, time.game_time_in_days() + 3)
    end
    reaction.get_reaction()
    if fallout.local_var(5) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if fallout.global_var(261) or fallout.local_var(8) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(378, 174), 2)
        else
            fallout.start_gdialog(378, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if fallout.global_var(101) == 2 then
                Theresa24()
            else
                if fallout.global_var(238) == 2 then
                    Theresa23()
                else
                    if (fallout.global_var(238) ~= 2) and (fallout.game_time_hour() > 1700) and (fallout.game_time_hour() < 1710) then
                        Theresa15()
                    else
                        if fallout.local_var(1) >= 2 then
                            Theresa01()
                        else
                            Theresa14()
                        end
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    if exp_flag then
        exp_flag = 0
        fallout.give_exp_points(750)
        fallout.display_msg(fallout.message_str(378, 173))
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        not_at_meeting = 1
    else
        if fallout.fixed_param() == 2 then
            begin_meeting()
        else
            if fallout.fixed_param() == 3 then
                say_lines()
            else
                if fallout.fixed_param() == 4 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 2)
                end
            end
        end
    end
end

function Theresa01()
    fallout.gsay_reply(378, fallout.message_str(378, 101) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(378, 102))
    fallout.giq_option(4, 378, 103, Theresa02, 50)
    fallout.giq_option(4, 378, 104, Theresa03, 50)
    fallout.giq_option(-3, 378, 105, Theresa04, 50)
end

function Theresa02()
    fallout.gsay_reply(378, 106)
    fallout.giq_option(4, 378, 107, Theresa05, 51)
    fallout.giq_option(4, 378, 108, Theresa06, 50)
    fallout.giq_option(4, 378, 109, Theresa07, 50)
    fallout.giq_option(6, 378, 110, Theresa02a, 50)
end

function Theresa02a()
    local v0 = 0
    if not(fallout.local_var(7)) then
        fallout.set_local_var(7, 1)
        v0 = fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)
        if fallout.is_success(v0) then
            Theresa08()
        else
            Theresa09()
        end
    else
        Theresa25()
    end
end

function Theresa03()
    fallout.gsay_reply(378, 111)
    fallout.giq_option(4, 378, 112, Theresa07, 50)
    fallout.giq_option(4, 378, 113, Theresa06, 50)
end

function Theresa04()
    fallout.gsay_message(378, 114, 50)
end

function Theresa05()
    reaction.DownReact()
    fallout.gsay_reply(378, 115)
    fallout.giq_option(4, 378, 116, Theresa09, 50)
    fallout.giq_option(6, 378, 117, Theresa02a, 50)
end

function Theresa06()
    fallout.gsay_message(378, 118, 50)
end

function Theresa07()
    fallout.gsay_reply(378, 119)
    fallout.giq_option(4, 378, 120, Theresa11, 50)
    fallout.giq_option(4, 378, 121, Theresa12, 50)
end

function Theresa08()
    reaction.UpReact()
    fallout.set_global_var(238, 2)
    line = 10
    exp_flag = 1
    fallout.gsay_reply(378, 122)
    fallout.giq_option(4, 378, 123, TheresaEnd, 50)
end

function Theresa09()
    reaction.DownReact()
    fallout.gsay_message(378, 124, 50)
end

function Theresa10()
    fallout.gsay_message(378, 125, 50)
end

function Theresa11()
    reaction.DownReact()
    fallout.gsay_reply(378, 126)
    fallout.giq_option(4, 378, 127, TheresaEnd, 50)
    fallout.giq_option(6, 378, 128, Theresa02a, 50)
end

function Theresa12()
    reaction.UpReact()
    fallout.gsay_reply(378, 129)
    fallout.giq_option(4, 378, 130, Theresa13, 50)
    if fallout.global_var(68) ~= 0 then
        fallout.giq_option(4, 378, 131, Theresa13, 50)
    end
end

function Theresa13()
    fallout.gsay_message(378, 132, 50)
end

function Theresa14()
    fallout.gsay_message(378, 133, 50)
end

function Theresa15()
    fallout.gsay_reply(378, 134)
    fallout.giq_option(4, 378, 135, Theresa16, 51)
    fallout.giq_option(4, 378, 136, Theresa17, 50)
    fallout.giq_option(6, 378, 137, Theresa18, 50)
    fallout.giq_option(-3, 378, 138, TheresaEnd, 50)
end

function Theresa16()
    reaction.DownReact()
    fallout.gsay_reply(378, 139)
    fallout.giq_option(4, 378, 140, Theresa20, 50)
    fallout.giq_option(4, 378, 141, TheresaEnd, 50)
end

function Theresa17()
    fallout.gsay_reply(378, 142)
    fallout.giq_option(4, 378, 143, Theresa19, 50)
    fallout.giq_option(6, 378, 144, Theresa21, 50)
end

function Theresa18()
    fallout.gsay_reply(378, 145)
    fallout.giq_option(6, 378, 146, Theresa21, 50)
    fallout.giq_option(6, 378, 147, Theresa19, 50)
end

function Theresa19()
    fallout.gsay_reply(378, 148)
    fallout.giq_option(4, 378, 149, TheresaCombat, 51)
    fallout.giq_option(4, 378, 150, TheresaEnd, 50)
end

function Theresa20()
    fallout.gsay_reply(378, 151)
    fallout.giq_option(4, 378, 152, Theresa17, 50)
    fallout.giq_option(6, 378, 153, Theresa21, 50)
end

function Theresa21()
    if fallout.local_var(7) then
        Theresa25()
    else
        fallout.set_local_var(7, 1)
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            exp_flag = 1
            fallout.set_global_var(238, 2)
            line = 10
            fallout.gsay_message(378, 154, 50)
        else
            fallout.gsay_reply(378, 155)
            fallout.giq_option(4, 378, 156, TheresaCombat, 51)
            fallout.giq_option(4, 378, 157, TheresaEnd, 50)
        end
    end
end

function Theresa22()
    fallout.set_global_var(238, 2)
    line = 10
    exp_flag = 1
    fallout.gsay_reply(378, 158)
    fallout.giq_option(4, 378, 159, TheresaEnd, 50)
end

function Theresa23()
    fallout.gsay_reply(378, 170)
    fallout.giq_option(4, 378, 171, TheresaEnd, 50)
    fallout.giq_option(-3, 378, 138, TheresaEnd, 50)
end

function Theresa24()
    if fallout.global_var(238) ~= 2 then
        fallout.set_global_var(238, 2)
        exp_flag = 0
        line = 10
    end
    fallout.gsay_message(378, 172, 50)
end

function Theresa25()
    fallout.gsay_message(378, 175, 50)
end

function TheresaEnd()
end

function TheresaCombat()
    hostile = 1
end

function begin_meeting()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
    line = 1
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 3)
end

function say_lines()
    local v0 = 0
    v0 = fallout.message_str(378, 159 + line)
    fallout.float_msg(fallout.self_obj(), v0, 0)
    line = line + 1
    if line < 11 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 3)
    else
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(600), 1)
    end
end

function rebel_meeting()
    not_at_meeting = 0
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 4)
end

function sleeping()
    if fallout.local_var(5) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(5, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(5, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(5, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(5, 1)
                end
            end
        end
    end
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
