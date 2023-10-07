local fallout = require("fallout")

local start
local critter_p_proc
local damage_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Cindy01
local Cindy02
local Cindy03
local Cindy04
local Cindy05
local Cindy06
local Cindy07
local CindyEnd
local flee_dude
local get_rations

local crying = 0
local hostile = 0
local ration_tile = 7000
local sleeping_disabled = 0

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
        if fallout.script_action() == 14 then
            damage_p_proc()
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
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(6) == 1 then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
                flee_dude()
            else
                if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), home_tile) > 3 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                end
            end
        else
            if fallout.global_var(101) == 0 then
                if fallout.local_var(7) == 0 then
                    if (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.external_var("WtrGrd_ptr"))) and (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.dude_obj())) then
                        if (fallout.game_time_hour() > 700) and (fallout.game_time_hour() < 900) then
                            get_rations()
                        end
                    end
                end
            end
            if not((fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800)) then
                fallout.set_local_var(7, 0)
            end
            if sleeping_disabled == 0 then
                sleeping()
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(6, 1)
    end
end

function description_p_proc()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(168, 101))
    end
end

function destroy_p_proc()
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
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(168, 100))
end

function map_enter_p_proc()
    sleep_tile = 24883
    home_tile = 24687
    sleep_time = fallout.random(1900, 1930)
    wake_time = fallout.random(600, 630)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
end

function pickup_p_proc()
    if (fallout.game_time() // (10 * 60 * 60 * 24)) >= 30 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 122), 2)
    end
    hostile = 1
end

function talk_p_proc()
    if not(fallout.local_var(4)) then
        if (fallout.global_var(261) == 1) or (fallout.local_var(6) == 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 125), 0)
            fallout.set_local_var(4, 1)
        else
            if fallout.global_var(101) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 123), 0)
            else
                if fallout.global_var(188) == 2 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 124), 0)
                else
                    fallout.start_gdialog(168, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Cindy01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
end

function Cindy01()
    fallout.gsay_reply(168, fallout.message_str(168, 102) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(168, 103))
    fallout.giq_option(4, 168, 104, Cindy03, 50)
    fallout.giq_option(4, 168, 105, Cindy04, 50)
    fallout.giq_option(-3, 168, 106, Cindy02, 50)
end

function Cindy02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(168, 107)
    fallout.giq_option(-3, 168, 108, CindyEnd, 50)
end

function Cindy03()
    fallout.gsay_message(168, fallout.random(109, 111), 50)
end

function Cindy04()
    if (fallout.game_time() // (10 * 60 * 60 * 24)) < 30 then
        fallout.gsay_reply(168, 126)
        fallout.giq_option(4, 168, 127, CindyEnd, 49)
        fallout.giq_option(4, 168, 128, CindyEnd, 51)
    else
        fallout.gsay_reply(168, 113)
        fallout.giq_option(4, 168, 114, Cindy05, 50)
        fallout.giq_option(4, 168, 115, Cindy06, 50)
    end
end

function Cindy05()
    fallout.gsay_reply(168, 116)
    fallout.giq_option(4, 168, 117, CindyEnd, 50)
end

function Cindy06()
    fallout.gsay_reply(168, 118)
    fallout.giq_option(4, 168, 119, Cindy07, 50)
end

function Cindy07()
    fallout.set_global_var(188, 1)
    fallout.gsay_reply(168, 120)
    fallout.giq_option(4, 168, 121, CindyEnd, 50)
    fallout.giq_option(4, 168, 112, Cindy05, 50)
end

function CindyEnd()
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

function get_rations()
    if fallout.tile_num(fallout.self_obj()) ~= ration_tile then
        sleeping_disabled = 1
        if fallout.random(0, 1) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), ration_tile, 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), ration_tile, 1)
        end
    else
        if not(fallout.external_var("recipient")) then
            fallout.set_external_var("recipient", fallout.self_obj())
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
            fallout.set_local_var(7, 1)
            sleeping_disabled = 0
        end
    end
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
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
