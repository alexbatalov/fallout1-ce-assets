local fallout = require("fallout")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Ismarc01
local Ismarc02
local Ismarc03
local Ismarc04
local Ismarc05
local Ismarc06
local Ismarc07
local Ismarc08
local Ismarc09
local Ismarc10
local Ismarc11
local Ismarc12
local IsmarcEnd
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = 0
local initialized = 0
local singing = 0
local song_line_base = 0
local song_line_offset = 0
local line05flag = 0
local line06flag = 0
local line07flag = 0
local line08flag = 0
local line11flag = 0
local line12flag = 0

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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(4) == 0 then
            if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            else
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 2 then
                    fallout.anim(fallout.self_obj(), 1000, 2)
                end
            end
        end
        if (fallout.game_time_hour() >= 1500) and (fallout.game_time_hour() <= 1900) and not(singing) then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(30, 60)), 1)
            singing = 1
        end
        sleeping()
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
end

function map_enter_p_proc()
    if fallout.global_var(15) == 1 then
        fallout.destroy_object(fallout.self_obj())
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 26)
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
        fallout.item_caps_adjust(fallout.self_obj(), fallout.random(20, 50))
    end
    sleep_tile = 7000
    home_tile = 19089
    sleep_time = 2210
    wake_time = 1420
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    get_reaction()
    fallout.start_gdialog(668, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Ismarc01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if song_line_base == 0 then
            song_line_base = (fallout.random(0, 2) * 4) + 127
        end
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(fallout.self_obj(), 13, -1)
        fallout.reg_anim_animate(fallout.self_obj(), 15, 3)
        fallout.reg_anim_animate(fallout.self_obj(), 14, 3)
        fallout.reg_anim_animate(fallout.self_obj(), 13, 3)
        fallout.reg_anim_animate(fallout.self_obj(), 0, 3)
        fallout.reg_anim_func(3, 0)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(668, song_line_base + song_line_offset), 0)
        song_line_offset = song_line_offset + 1
        if song_line_offset < 4 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
        else
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1800, 3600)), 2)
        end
    else
        if fallout.fixed_param() == 2 then
            singing = 0
            song_line_offset = 0
            song_line_base = 0
        end
    end
end

function Ismarc01()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(668, 102)
    else
        fallout.gsay_reply(668, 103)
    end
    fallout.giq_option(4, 668, 104, Ismarc02, 49)
    fallout.giq_option(4, 668, 105, Ismarc03, 51)
    fallout.giq_option(4, 668, 106, IsmarcEnd, 50)
    fallout.giq_option(-3, 668, 107, Ismarc04, 51)
end

function Ismarc02()
    UpReact()
    if fallout.local_var(1) == 1 then
        Ismarc03()
    else
        fallout.gsay_reply(668, 109)
        Ismarc10()
    end
end

function Ismarc03()
    fallout.gsay_message(668, 108, 51)
end

function Ismarc04()
    fallout.gsay_message(668, 114, 51)
end

function Ismarc05()
    line05flag = 1
    fallout.gsay_reply(668, 115)
    Ismarc09()
end

function Ismarc06()
    line06flag = 1
    if fallout.global_var(73) < 1 then
        fallout.set_global_var(73, 1)
    end
    fallout.gsay_reply(668, 120)
    Ismarc09()
end

function Ismarc07()
    line07flag = 1
    if fallout.global_var(74) < 1 then
        fallout.set_global_var(74, 1)
    end
    fallout.gsay_reply(668, 121)
    Ismarc09()
end

function Ismarc08()
    line08flag = 1
    if fallout.global_var(75) < 1 then
        fallout.set_global_var(75, 1)
    end
    fallout.gsay_reply(668, 122)
    Ismarc09()
end

function Ismarc09()
    if not(line06flag) then
        fallout.giq_option(4, 668, 116, Ismarc06, 50)
    end
    if not(line07flag) then
        fallout.giq_option(4, 668, 117, Ismarc07, 50)
    end
    if not(line08flag) then
        fallout.giq_option(4, 668, 118, Ismarc08, 50)
    end
    fallout.giq_option(4, 668, 119, IsmarcEnd, 50)
end

function Ismarc10()
    if not(line05flag) then
        fallout.giq_option(4, 668, 110, Ismarc05, 50)
    end
    if not(line11flag) then
        fallout.giq_option(4, 668, 111, Ismarc11, 49)
    end
    if not(line12flag) then
        fallout.giq_option(4, 668, 112, Ismarc12, 50)
    end
    fallout.giq_option(4, 668, 113, IsmarcEnd, 50)
end

function Ismarc11()
    local v0 = 0
    if fallout.item_caps_total(fallout.dude_obj()) >= 5 then
        UpReact()
        v0 = fallout.rm_mult_objs_from_inven(fallout.dude_obj(), fallout.obj_carrying_pid_obj(fallout.dude_obj(), 41), 5)
        v0 = fallout.create_object_sid(41, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.self_obj(), v0, 5)
        fallout.gsay_reply(668, 123)
        fallout.giq_option(0, 634, 106, Ismarc10, 49)
    else
        fallout.gsay_reply(668, 124)
        Ismarc10()
    end
end

function Ismarc12()
    fallout.gsay_reply(668, 125)
    Ismarc10()
end

function IsmarcEnd()
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
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
