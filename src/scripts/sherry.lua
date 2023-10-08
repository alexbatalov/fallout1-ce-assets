local fallout = require("fallout")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Sherry01
local Sherry02
local Sherry03
local Sherry04
local Sherry05
local Sherry06
local Sherry07
local Sherry08
local Sherry09
local Sherry10
local Sherry11
local Sherry12
local Sherry13
local Sherry14
local Sherry15
local Sherry16
local Sherry17
local Sherry18
local Sherry18a
local Sherry19
local Sherry20
local Sherry21
local Sherry22
local Sherry23
local Sherry24
local Sherry25
local Sherry26
local Sherry27
local Sherry27a
local Sherry28
local Sherry29
local SherryCombat
local SherryCook
local SherryEnd

local hostile = 0
local initialized = 0
local feed_dude = 0

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
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
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
        if fallout.global_var(556) == 1 then
            if (time.game_time_in_days() - fallout.local_var(6)) > 1 then
                fallout.critter_add_trait(fallout.self_obj(), 1, 6, 26)
                fallout.set_global_var(556, 2)
                fallout.set_local_var(6, 0)
                home_tile = 18125
                sleep_tile = 17924
            end
        end
        if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() <= 1930) then
            if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            end
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

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(388, 100))
    else
        fallout.display_msg(fallout.message_str(388, 101))
    end
end

function map_enter_p_proc()
    sleep_time = 2000
    wake_time = 630
    if fallout.global_var(556) == 0 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 14)
        home_tile = 15513
        sleep_tile = 13494
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 26)
        home_tile = 18125
        sleep_tile = 17924
    end
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(388, 102), 0)
    hostile = 1
end

function talk_p_proc()
    if fallout.local_var(5) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        get_reaction()
        fallout.start_gdialog(388, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.global_var(556) == 2 then
            Sherry22()
        else
            if fallout.local_var(4) == 1 then
                Sherry15()
            else
                Sherry01()
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    if feed_dude then
        SherryCook()
    end
end

function Sherry01()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(388, 103)
    fallout.giq_option(4, 388, fallout.message_str(388, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(388, 105), Sherry02, 50)
    fallout.giq_option(4, 388, 106, Sherry03, 50)
    fallout.giq_option(-3, 388, 107, Sherry04, 50)
end

function Sherry02()
    fallout.gsay_reply(388, 108)
    fallout.giq_option(4, 388, 109, SherryCombat, 51)
    fallout.giq_option(4, 388, 110, SherryEnd, 50)
    fallout.giq_option(5, 388, 111, Sherry05, 50)
    fallout.giq_option(6, 388, 112, Sherry07, 50)
end

function Sherry03()
    DownReact()
    fallout.gsay_reply(388, 113)
    fallout.giq_option(4, 388, 114, SherryEnd, 50)
    fallout.giq_option(4, 388, 115, SherryCombat, 50)
end

function Sherry04()
    fallout.gsay_message(388, 116, 50)
end

function Sherry05()
    fallout.gsay_reply(388, 117)
    fallout.giq_option(4, 388, 118, Sherry11, 50)
    fallout.giq_option(4, 388, 119, SherryEnd, 50)
end

function Sherry06()
    fallout.gsay_reply(388, 120)
    fallout.giq_option(4, 388, 121, Sherry07, 50)
    fallout.giq_option(4, 388, 122, Sherry08, 50)
    fallout.giq_option(4, 388, 123, SherryEnd, 50)
end

function Sherry07()
    fallout.gsay_message(388, 124, 51)
end

function Sherry08()
    fallout.gsay_reply(388, 125)
    Sherry13()
end

function Sherry09()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(388, 126)
    fallout.giq_option(4, 388, 127, Sherry10, 50)
    Sherry13()
end

function Sherry10()
    fallout.gsay_reply(388, 128)
    Sherry13()
end

function Sherry11()
    fallout.gsay_reply(388, 129)
    Sherry13()
end

function Sherry12()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(388, 130)
    fallout.giq_option(4, 388, 131, Sherry26, 50)
    Sherry13()
end

function Sherry13()
    if not(fallout.local_var(7)) then
        fallout.giq_option(5, 388, 133, Sherry09, 50)
    end
    if not(fallout.local_var(8)) then
        fallout.giq_option(4, 388, 132, Sherry12, 50)
    end
    if not(fallout.local_var(9)) then
        fallout.giq_option(6, 388, 134, Sherry14, 50)
    end
    Goodbyes()
    fallout.giq_option(4, 388, exit_line, SherryEnd, 50)
end

function Sherry14()
    fallout.set_local_var(9, 1)
    fallout.gsay_reply(388, 135)
    Sherry13()
end

function Sherry15()
    fallout.gsay_reply(388, 136)
    fallout.giq_option(4, 388, 137, Sherry16, 50)
    if fallout.local_var(6) == 0 then
        fallout.giq_option(5, 388, 138, Sherry17, 50)
    end
    Goodbyes()
    fallout.giq_option(4, 388, exit_line, SherryEnd, 50)
end

function Sherry16()
    fallout.gsay_message(388, 139, 51)
    SherryCombat()
end

function Sherry17()
    fallout.gsay_reply(388, 140)
    fallout.giq_option(4, 388, 141, SherryEnd, 50)
    fallout.giq_option(6, 388, 142, Sherry18, 50)
end

function Sherry18()
    fallout.gsay_reply(388, 143)
    fallout.giq_option(4, 388, 144, SherryEnd, 50)
    fallout.giq_option(6, 388, 145, Sherry18a, 50)
end

function Sherry18a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Sherry19()
    else
        Sherry20()
    end
end

function Sherry19()
    fallout.gsay_reply(388, 146)
    fallout.giq_option(6, 388, 147, Sherry21, 50)
end

function Sherry20()
    DownReact()
    fallout.gsay_message(388, 148, 51)
end

function Sherry21()
    fallout.set_local_var(6, time.game_time_in_days())
    fallout.set_global_var(556, 1)
    fallout.gsay_message(388, 149, 50)
end

function Sherry22()
    fallout.gsay_reply(388, 150)
    fallout.giq_option(4, 388, 151, SherryEnd, 50)
    fallout.giq_option(4, 388, 152, Sherry23, 50)
    fallout.giq_option(4, 388, 153, Sherry24, 50)
    if (fallout.local_var(10) == 0) and fallout.global_var(555) then
        fallout.giq_option(4, 388, 166, Sherry27, 50)
    end
end

function Sherry23()
    fallout.gsay_reply(388, 154)
    fallout.giq_option(4, 388, 155, Sherry25, 50)
    fallout.giq_option(4, 388, 156, SherryEnd, 50)
end

function Sherry24()
    fallout.gsay_message(388, 157, 50)
end

function Sherry25()
    feed_dude = 1
end

function Sherry26()
    fallout.gsay_reply(388, 159)
    Sherry13()
end

function Sherry27()
    fallout.set_local_var(10, 1)
    fallout.gsay_reply(388, 160)
    fallout.giq_option(4, 388, 161, Sherry27a, 50)
    fallout.giq_option(4, 388, 162, SherryEnd, 50)
    fallout.giq_option(6, 388, 163, Sherry28, 50)
end

function Sherry27a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Sherry28()
    else
        Sherry29()
    end
end

function Sherry28()
    fallout.gsay_message(388, 164, 50)
    fallout.set_global_var(257, 1)
end

function Sherry29()
    fallout.gsay_message(388, 165, 50)
end

function SherryCombat()
    hostile = 1
end

function SherryCook()
    fallout.use_obj(fallout.dude_obj())
    fallout.float_msg(fallout.self_obj(), fallout.message_str(388, 158), 0)
    fallout.critter_heal(fallout.dude_obj(), 1)
    feed_dude = 0
end

function SherryEnd()
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
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
