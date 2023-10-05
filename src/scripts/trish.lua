local fallout = require("fallout")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local map_update_p_proc
local talk_p_proc
local Trish0
local Trish1
local Trish2
local Trish3
local Trish4
local Trish5
local Trish6
local Trish6a
local Trish7
local Trish8
local Trish9
local Trish10
local Trish11
local Trish12
local Trish13
local Trish14
local Trish15
local Trish16
local Trish17
local Trish18
local Trish19
local Trish20
local Trish21
local Trish22
local Trish23
local Trish24
local Trish25
local Trish26
local Trish27
local Trish28
local Trish29
local TrishEnd
local TrishCola
local TrishBeer
local TrishBooze
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local initialized = 0
local item = 0

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
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        else
                            if fallout.script_action() == 22 then
                                fallout.dialogue_system_enter()
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.cur_map_index() == 12 then
        if fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) then
            if not((fallout.global_var(557) & 1) or (fallout.global_var(557) & 4)) then
                fallout.anim(fallout.self_obj(), 37, 0)
                fallout.set_local_var(4, 0)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
            end
        end
    end
    if fallout.global_var(557) & 32 then
        fallout.destroy_object(fallout.self_obj())
    else
        sleeping()
    end
    if fallout.cur_map_index() == 11 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if (fallout.map_var(0) == 1) and (fallout.map_var(1) == 1) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
                fallout.dialogue_system_enter()
            end
        end
        if (fallout.game_time_hour() > (wake_time + 20)) or (fallout.game_time_hour() < sleep_time) then
            if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                if (fallout.global_var(282) == 0) or (fallout.global_var(555) == 2) then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                end
            end
        end
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(159, fallout.global_var(159) + 1)
            if (fallout.global_var(159) % 2) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) - 1)
            end
        end
    end
    fallout.set_global_var(557, fallout.global_var(557) + 32)
end

function look_at_p_proc()
    fallout.script_overrides()
    if (fallout.global_var(557) & 1) or (fallout.global_var(557) & 4) then
        fallout.display_msg(fallout.message_str(342, 100))
    else
        fallout.display_msg(fallout.message_str(342, 167))
    end
end

function map_enter_p_proc()
    night_person = 1
    fallout.set_external_var("Trish_ptr", fallout.self_obj())
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 26)
    if fallout.cur_map_index() == 11 then
        sleep_tile = 7000
        home_tile = 20083
    else
        sleep_tile = 16297
        home_tile = 19960
    end
    sleep_time = 330
    wake_time = 1400
end

function map_update_p_proc()
    if fallout.global_var(557) & 32 then
        fallout.destroy_object(fallout.self_obj())
    end
end

function talk_p_proc()
    get_reaction()
    if fallout.local_var(4) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(342, 151), 0)
    else
        if fallout.cur_map_index() == 12 then
            if not((fallout.global_var(557) & 1) or (fallout.global_var(557) & 4)) then
                Trish0()
            else
                if (fallout.global_var(557) & 4) and not(fallout.global_var(557) & 1) then
                    Trish11()
                else
                    if (fallout.global_var(169) == 3) and not(fallout.local_var(7)) then
                        Trish17()
                    else
                        if (fallout.global_var(169) == 1) and not(fallout.local_var(5)) then
                            Trish3()
                        else
                            if (fallout.global_var(557) & 8) and not(fallout.local_var(6)) then
                                Trish16()
                            else
                                Trish15()
                            end
                        end
                    end
                end
            end
        else
            if (fallout.game_time_hour() >= 1300) and (fallout.game_time_hour() < 1600) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(342, 152), 0)
            else
                Trish25()
            end
        end
    end
    if not(fallout.global_var(557) & 16) and (fallout.global_var(557) & 8) then
        fallout.set_global_var(557, fallout.global_var(557) + 16)
        fallout.display_msg(fallout.message_str(342, 173))
        fallout.set_global_var(155, fallout.global_var(155) + 2)
        fallout.give_exp_points(250)
    end
end

function Trish0()
    fallout.start_gdialog(342, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if not(fallout.global_var(557) & 1) then
        fallout.set_global_var(557, fallout.global_var(557) + 1)
    end
    fallout.gsay_reply(342, 101)
    fallout.giq_option(-3, 342, 102, Trish1, 50)
    fallout.giq_option(4, 342, 103, Trish2, 50)
    fallout.giq_option(4, 342, 104, TrishEnd, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Trish1()
    fallout.gsay_message(342, 105, 50)
end

function Trish2()
    fallout.gsay_message(342, 106, 50)
end

function Trish3()
    fallout.start_gdialog(342, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(342, 107)
    fallout.giq_option(-3, 342, 108, Trish1, 50)
    fallout.giq_option(4, 342, 109, Trish2, 50)
    fallout.giq_option(5, 342, 110, Trish4, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Trish4()
    fallout.gsay_reply(342, 111)
    fallout.giq_option(5, 342, 112, Trish5, 50)
    fallout.giq_option(5, 342, 113, Trish6, 50)
end

function Trish5()
    fallout.gsay_reply(342, 114)
    fallout.giq_option(5, 342, 115, Trish9, 50)
    fallout.giq_option(7, 342, 116, Trish10, 50)
end

function Trish6()
    fallout.gsay_reply(342, 117)
    fallout.giq_option(5, 342, 118, Trish6a, -10)
    fallout.giq_option(5, 342, 119, Trish7, 0)
    fallout.giq_option(6, 342, 169, Trish8, 0)
end

function Trish6a()
    DownReact()
    Trish7()
end

function Trish7()
    fallout.gsay_message(342, 120, 0)
end

function Trish8()
    local v0 = 0
    v0 = fallout.message_str(342, 121)
    if not(fallout.global_var(38)) then
        v0 = v0 + fallout.message_str(342, 168)
    end
    fallout.gsay_message(342, v0, 49)
    fallout.set_global_var(557, fallout.global_var(557) + 8)
end

function Trish9()
    fallout.gsay_reply(342, 122)
    fallout.giq_option(5, 342, 123, Trish8, 50)
    fallout.giq_option(5, 342, 124, Trish7, 50)
end

function Trish10()
    fallout.gsay_reply(342, 125)
    fallout.giq_option(5, 342, 126, Trish8, 50)
end

function Trish11()
    if not(fallout.global_var(557) & 1) then
        fallout.set_global_var(557, fallout.global_var(557) + 1)
    end
    fallout.start_gdialog(342, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.gsay_reply(342, 127)
    fallout.giq_option(-3, 342, 128, Trish7, 50)
    fallout.giq_option(4, 342, 129, Trish12, -10)
    fallout.giq_option(5, 342, 130, Trish13, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Trish12()
    DownReact()
    fallout.gsay_message(342, 131, 0)
end

function Trish13()
    fallout.gsay_reply(342, 132)
    fallout.giq_option(5, 342, 133, TrishEnd, 0)
end

function Trish14()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(342, fallout.random(134, 136)), 0)
end

function Trish15()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(342, 137), 0)
end

function Trish16()
    fallout.set_local_var(6, 1)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(342, 138), 0)
end

function Trish17()
    fallout.set_local_var(7, 1)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(342, 139), 0)
end

function Trish18()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(342, 140)
    fallout.giq_option(-3, 342, 141, TrishEnd, 50)
    fallout.giq_option(4, 342, 142, TrishEnd, 50)
    fallout.giq_option(6, 342, 143, Trish19, 50)
end

function Trish19()
    fallout.gsay_reply(342, 144)
    fallout.giq_option(6, 342, 145, Trish20, 50)
    if not(fallout.global_var(170) == 3) then
        fallout.giq_option(6, 342, 146, Trish21, 50)
    end
    if (fallout.local_var(12) == 0) and (fallout.global_var(557) & 2) then
        fallout.giq_option(6, 342, 147, Trish22, 50)
    end
    fallout.giq_option(6, 342, 148, TrishEnd, 50)
end

function Trish20()
    fallout.set_local_var(10, 1)
    fallout.gsay_reply(342, 149)
    Trish24()
end

function Trish21()
    local v0 = 0
    fallout.set_local_var(11, 1)
    v0 = fallout.message_str(342, 154)
    if not(fallout.global_var(37)) then
        v0 = v0 + fallout.message_str(342, 155)
    end
    fallout.gsay_reply(342, v0)
    Trish24()
end

function Trish22()
    fallout.set_local_var(12, 1)
    fallout.gsay_reply(342, 158)
    Trish24()
end

function Trish23()
    if fallout.global_var(170) == 3 then
        fallout.gsay_reply(342, 162)
    else
        fallout.gsay_reply(342, 163)
    end
    Trish24()
end

function Trish24()
    if not(fallout.local_var(10)) then
        fallout.giq_option(6, 342, 145, Trish20, 50)
    end
    if not(fallout.local_var(11)) then
        if not(fallout.global_var(38)) then
            fallout.giq_option(6, 342, 146, Trish21, 50)
        end
    end
    if (fallout.local_var(12) == 0) and (fallout.global_var(557) & 2) then
        fallout.giq_option(6, 342, 147, Trish22, 50)
    end
    fallout.giq_option(6, 342, 148, TrishEnd, 50)
end

function Trish25()
    fallout.start_gdialog(342, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if not(fallout.global_var(557) & 4) then
        fallout.set_global_var(557, fallout.global_var(557) + 4)
    end
    fallout.gsay_reply(342, 156)
    fallout.giq_option(4, 342, 157, Trish26, 50)
    fallout.giq_option(4, 342, 159, Trish27, 50)
    fallout.giq_option(4, 342, 153, TrishEnd, 50)
    fallout.giq_option(-3, 342, 170, Trish28, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Trish26()
    fallout.gsay_reply(342, 161)
    fallout.giq_option(4, 342, 164, TrishCola, 50)
    fallout.giq_option(4, 342, 165, TrishBeer, 50)
    fallout.giq_option(4, 342, 166, TrishBooze, 50)
    fallout.giq_option(4, 342, 153, TrishEnd, 50)
end

function Trish27()
    if fallout.local_var(1) < 2 then
        fallout.gsay_message(342, 160, 51)
    else
        Trish19()
    end
end

function Trish28()
    fallout.gsay_message(342, 171, 50)
end

function Trish29()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(342, 140), 0)
    fallout.display_msg(fallout.message_str(342, 172))
    fallout.give_exp_points(250)
    BigUpReact()
    fallout.set_map_var(1, 0)
    fallout.set_map_var(0, 0)
end

function TrishEnd()
end

function TrishCola()
    if fallout.item_caps_total(fallout.dude_obj()) >= 3 then
        fallout.item_caps_adjust(fallout.dude_obj(), -3)
        item = fallout.create_object_sid(106, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item)
        fallout.gsay_message(342, 174, 0)
    end
end

function TrishBeer()
    if fallout.item_caps_total(fallout.dude_obj()) >= 5 then
        fallout.item_caps_adjust(fallout.dude_obj(), -5)
        item = fallout.create_object_sid(124, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item)
        fallout.gsay_message(342, 174, 0)
    end
end

function TrishBooze()
    if fallout.item_caps_total(fallout.dude_obj()) >= 20 then
        fallout.item_caps_adjust(fallout.dude_obj(), -20)
        item = fallout.create_object_sid(125, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item)
        fallout.gsay_message(342, 174, 0)
    end
end

function sleeping()
    if fallout.local_var(4) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(4, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(4, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(4, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
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
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.talk_p_proc = talk_p_proc
return exports
