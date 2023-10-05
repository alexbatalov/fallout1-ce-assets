local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local talk_p_proc
local timed_event_p_proc
local Sinthia00
local Sinthia00a
local Sinthia00b
local Sinthia01
local Sinthia02
local Sinthia03
local Sinthia04
local Sinthia05
local Sinthia06
local Sinthia07
local Sinthia08
local Sinthia09
local Sinthia10
local Sinthia11
local Sinthia12
local Sinthia12a
local Sinthia13
local Sinthia13a
local Sinthia14
local Sinthia15
local Sinthia16
local Sinthia16a
local Sinthia17
local Sinthia18
local Sinthia19
local Sinthia20
local Sinthia20a
local Sinthia21
local Sinthia22
local Sinthia23
local Sinthia24
local Sinthia25
local Sinthia26
local Sinthia27
local Sinthia28
local Sinthia29
local Sin
local SinOn
local SinthiaQuestions
local SinthiaEnd

local do_it = 0
local leaving = 0
local dest_tile = 0
local raider_fall_down = 0
local remove_Raider = 0
local sleeping_disabled = 0
local waypoint = 7000
local line08flag = 0
local line23flag = 0
local line24flag = 0
local line25flag = 0
local line26flag = 0

local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0

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

local damage_p_proc

function start()
    fallout.set_external_var("Sinthia_ptr", fallout.self_obj())
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

function critter_p_proc()
    if fallout.map_var(1) == 2 then
        if (fallout.local_var(6) == 0) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
            fallout.dialogue_system_enter()
        end
    else
        if fallout.map_var(1) == 1 then
            if (fallout.local_var(7) == 0) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) and (raider_fall_down == 0) then
                fallout.rm_timer_event(fallout.self_obj())
                fallout.add_timer_event(fallout.self_obj(), 15, 2)
                fallout.reg_anim_func(2, fallout.external_var("JTRaider_ptr"))
                fallout.reg_anim_func(1, 1)
                fallout.reg_anim_animate(fallout.external_var("JTRaider_ptr"), 21, -1)
                fallout.reg_anim_animate(fallout.external_var("JTRaider_ptr"), 49, -1)
                fallout.reg_anim_func(3, 0)
                raider_fall_down = 1
            end
        end
    end
    if fallout.global_var(143) == 2 then
        if fallout.map_var(1) ~= fallout.external_var("raider_dead") then
            if sleeping_disabled == 0 then
                sleeping()
            end
        else
            fallout.set_map_var(0, 1)
            sleeping_disabled = 1
            if waypoint == 0 then
                dest_tile = 22502
                waypoint = 1
            end
            if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), dest_tile) > 3 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
            else
                if waypoint == 1 then
                    dest_tile = 31930
                    waypoint = 2
                else
                    if waypoint == 2 then
                        fallout.destroy_object(fallout.self_obj())
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_external_var("Sinthia_ptr", 0)
    fallout.set_global_var(143, 2)
    if fallout.map_var(0) ~= 1 then
        fallout.set_map_var(0, 2)
    end
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
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(5) == 1 then
        fallout.display_msg(fallout.message_str(338, 100))
    else
        fallout.display_msg(fallout.message_str(338, 101))
    end
end

function map_enter_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 16)
    fallout.set_external_var("Sinthia_ptr", fallout.self_obj())
    home_tile = 17485
    sleep_tile = 16681
    sleep_time = 2300
    wake_time = 1000
    if fallout.local_var(6) == 1 then
        fallout.set_external_var("Sinthia_ptr", 0)
        fallout.destroy_object(fallout.self_obj())
    end
end

function talk_p_proc()
    if fallout.local_var(6) == 1 then
        fallout.display_msg(fallout.message_str(338, 171))
    else
        if (fallout.map_var(3) > 0) and (fallout.map_var(3) < 3) then
            Sinthia07()
        else
            get_reaction()
            fallout.start_gdialog(338, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            fallout.set_local_var(5, 1)
            if fallout.map_var(1) == 2 then
                Sinthia16()
            else
                if (fallout.map_var(1) == 1) and (fallout.local_var(7) == 0) then
                    Sinthia17()
                else
                    if not(line08flag) and (fallout.global_var(143) == 2) then
                        Sinthia08()
                    else
                        if fallout.map_var(3) < 3 then
                            Sinthia00()
                        else
                            if fallout.local_var(1) < 2 then
                                Sinthia29()
                            else
                                Sinthia20()
                            end
                        end
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
            if do_it then
                Sin()
            end
            if remove_Raider then
                if fallout.external_var("JTRaider_ptr") ~= 0 then
                    fallout.display_msg(fallout.message_str(338, 177))
                    fallout.destroy_object(fallout.external_var("JTRaider_ptr"))
                    fallout.set_external_var("JTRaider_ptr", 0)
                    remove_Raider = 0
                end
            end
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 2 then
        fallout.dialogue_system_enter()
    else
        fallout.anim(fallout.self_obj(), 1000, 3)
    end
end

function Sinthia00()
    fallout.gsay_reply(338, 102)
    fallout.giq_option(4, 338, 103, SinthiaEnd, 50)
    fallout.giq_option(6, 338, 104, Sinthia00a, 50)
    fallout.giq_option(-3, 338, 105, Sinthia00b, 50)
end

function Sinthia00a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        Sinthia04()
    else
        Sinthia03()
    end
end

function Sinthia00b()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        Sinthia01()
    else
        Sinthia02()
    end
end

function Sinthia01()
    fallout.gsay_message(338, 106, 50)
end

function Sinthia02()
    fallout.gsay_message(338, 107, 50)
end

function Sinthia03()
    fallout.gsay_message(338, 108, 50)
end

function Sinthia04()
    fallout.gsay_reply(338, 109)
    fallout.giq_option(6, 338, 110, Sinthia05, 50)
    if fallout.global_var(5) then
        fallout.giq_option(6, 338, 111, Sinthia06, 50)
    end
end

function Sinthia05()
    fallout.gsay_message(338, 112, 50)
end

function Sinthia06()
    DownReact()
    fallout.gsay_message(338, 113, 50)
end

function Sinthia07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(338, fallout.random(114, 117)), 7)
end

function Sinthia08()
    line08flag = 1
    BigUpReact()
    fallout.gsay_reply(338, 118)
    fallout.giq_option(4, 338, 119, Sinthia10, 50)
    fallout.giq_option(5, 338, 120, Sinthia11, 50)
    fallout.giq_option(-3, 338, 121, Sinthia09, 50)
end

function Sinthia09()
    fallout.gsay_message(338, 122, 50)
end

function Sinthia10()
    DownReact()
    fallout.gsay_message(338, 123, 50)
end

function Sinthia11()
    fallout.gsay_reply(338, 124)
    fallout.giq_option(5, 338, 125, Sinthia12, 50)
    fallout.giq_option(5, 338, 126, Sinthia15, 50)
end

function Sinthia12()
    fallout.gsay_reply(338, 127)
    fallout.giq_option(0, 634, 106, Sinthia12a, 49)
end

function Sinthia12a()
    fallout.gsay_reply(338, 128)
    fallout.giq_option(5, 338, 129, Sinthia14, 50)
    fallout.giq_option(5, 338, 130, Sinthia13, 50)
end

function Sinthia13()
    fallout.gsay_reply(338, 131)
    fallout.giq_option(0, 634, 106, Sinthia13a, 50)
end

function Sinthia13a()
    if (fallout.get_critter_stat(fallout.dude_obj(), 34) == 0) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        fallout.gsay_reply(338, 132)
        fallout.giq_option(0, 634, 106, SinOn, 49)
    else
        fallout.gsay_message(338, 133, 49)
    end
end

function Sinthia14()
    fallout.gsay_message(338, 134, 50)
    if not(fallout.global_var(37)) and not(fallout.global_var(38)) then
        fallout.gsay_message(338, 136, 50)
    end
end

function Sinthia15()
    fallout.gsay_reply(338, 137)
    fallout.giq_option(5, 338, 138, Sinthia14, 50)
end

function Sinthia16()
    local v0 = 0
    fallout.set_local_var(6, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(338, 141)
    else
        fallout.gsay_reply(338, 142)
    end
    fallout.giq_option(0, 634, 106, Sinthia16a, 50)
end

function Sinthia16a()
    BottomReact()
    dest_tile = 7521
    fallout.gsay_message(338, 143, 50)
end

function Sinthia17()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(338, 144)
    fallout.giq_option(4, 338, 145, Sinthia19, 50)
    fallout.giq_option(-3, 338, 146, Sinthia18, 50)
end

function Sinthia18()
    BottomReact()
    fallout.gsay_message(338, 147, 50)
end

function Sinthia19()
    fallout.gsay_reply(338, 148)
    fallout.giq_option(4, 338, 149, Sinthia08, 50)
    remove_Raider = 1
end

function Sinthia20()
    fallout.gsay_reply(338, 150)
    fallout.giq_option(4, 338, 151, Sinthia22, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 338, 152, Sinthia20a, 50)
    end
    if not(line23flag) then
        fallout.giq_option(6, 338, 153, Sinthia23, 50)
    end
end

function Sinthia20a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 40 then
        fallout.item_caps_adjust(fallout.dude_obj(), -40)
        Sinthia27()
    else
        Sinthia28()
    end
end

function Sinthia21()
    fallout.gsay_message(338, 154, 50)
end

function Sinthia22()
    fallout.gsay_message(338, 155, 50)
end

function Sinthia23()
    line23flag = 1
    fallout.gsay_reply(338, 156)
    SinthiaQuestions()
end

function Sinthia24()
    line24flag = 1
    fallout.gsay_reply(338, 161)
    SinthiaQuestions()
end

function Sinthia25()
    line25flag = 1
    fallout.gsay_reply(338, 162)
    SinthiaQuestions()
end

function Sinthia26()
    line26flag = 1
    fallout.gsay_reply(338, 163)
    SinthiaQuestions()
end

function Sinthia27()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 3)
    v1 = fallout.message_str(338, 163 + v0)
    fallout.float_msg(fallout.self_obj(), v1, 7)
    SinOn()
end

function Sinthia28()
    DownReact()
    fallout.gsay_message(338, 167, 50)
end

function Sinthia29()
    fallout.gsay_message(338, 168, 50)
end

function Sin()
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(600))
    fallout.move_to(fallout.dude_obj(), 18291, 0)
    if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0))) then
        fallout.set_map_var(7, 1)
    end
    fallout.gfade_in(600)
    do_it = 0
end

function SinOn()
    do_it = 1
end

function SinthiaQuestions()
    if not(line24flag) then
        fallout.giq_option(6, 338, 157, Sinthia24, 50)
    end
    if not(line25flag) then
        fallout.giq_option(6, 338, 158, Sinthia25, 50)
    end
    if not(line26flag) then
        fallout.giq_option(6, 338, 159, Sinthia26, 50)
    end
    fallout.giq_option(6, 338, 160, SinthiaEnd, 50)
end

function SinthiaEnd()
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

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
