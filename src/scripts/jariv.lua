local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local guard00
local guard01
local guard02
local guard03
local guard04
local guard05
local guard06
local guard07
local guard08
local guard09
local guard10
local guard11
local guard12
local guard13
local guard06a
local guard07a
local guard07_1
local guardend
local set_sleep_tile
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = 0
local initialized = 0
local round_counter = 0
local Warned_Tile = 0

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
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
        if fallout.local_var(10) == 0 then
            fallout.set_local_var(10, fallout.tile_num(fallout.self_obj()))
        end
        home_tile = fallout.local_var(10)
        initialized = 1
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 21 then
                        look_at_p_proc()
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

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(246) == 0 then
            fallout.set_global_var(246, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(246) == 1 then
            hostile = 1
        end
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                if fallout.map_var(0) == 1 then
                    guard11()
                end
            end
            if fallout.global_var(246) then
                hostile = 1
            end
        end
        if fallout.local_var(7) == 1 then
            if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), fallout.tile_num(fallout.dude_obj())) < fallout.tile_distance(fallout.tile_num(fallout.self_obj()), Warned_Tile) then
                hostile = 1
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(113, 100))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
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
        if (fallout.global_var(159) % 5) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(113, 100))
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.set_global_var(156, 1)
        fallout.set_global_var(157, 0)
    end
    get_reaction()
    if fallout.local_var(9) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if fallout.global_var(246) then
            fallout.set_local_var(4, 1)
            guard00()
        else
            if fallout.global_var(26) == 1 then
                fallout.set_local_var(4, 1)
                guard01()
            else
                if (fallout.global_var(26) == 2) and (fallout.local_var(8) == 0) then
                    fallout.set_local_var(4, 1)
                    guard02()
                else
                    if fallout.global_var(26) == 3 then
                        fallout.set_local_var(4, 1)
                        guard03()
                    else
                        if fallout.local_var(4) == 1 then
                            if fallout.local_var(1) < 2 then
                                guard13()
                            else
                                guard12()
                            end
                        else
                            fallout.set_local_var(4, 1)
                            if fallout.local_var(1) < 2 then
                                guard10()
                            else
                                fallout.start_gdialog(113, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                guard04()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            end
                        end
                    end
                end
            end
        end
    end
end

function timed_event_p_proc()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        hostile = 1
    else
        fallout.set_map_var(0, 0)
    end
end

function guard00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 101), 7)
    Warned_Tile = fallout.tile_num(fallout.dude_obj())
    fallout.set_local_var(7, 1)
end

function guard01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 102), 7)
end

function guard02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 103), 7)
    fallout.set_local_var(8, 1)
    TopReact()
end

function guard03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 104), 7)
end

function guard04()
    fallout.gsay_reply(113, 105)
    fallout.giq_option(4, 113, 106, guard05, 50)
    fallout.giq_option(5, 113, 107, guard07, 50)
    fallout.giq_option(-3, 113, 108, guard05, 50)
end

function guard05()
    fallout.gsay_reply(113, 109)
    fallout.giq_option(4, 113, 110, guard06, 50)
    fallout.giq_option(-3, 113, 111, guardend, 50)
end

function guard06()
    fallout.gsay_reply(113, 112)
    fallout.giq_option(4, 113, 113, guardend, 50)
    fallout.giq_option(4, 113, 114, guard06a, 50)
end

function guard07()
    fallout.gsay_reply(113, 115)
    fallout.gsay_option(113, 126, guard07_1, 50)
end

function guard08()
    fallout.gsay_reply(113, 118)
    fallout.giq_option(4, 113, 119, guardend, 50)
    fallout.giq_option(4, 113, 120, DownReact, 50)
end

function guard09()
    fallout.gsay_reply(113, 121)
    Goodbyes()
    fallout.giq_option(4, 113, exit_line, guardend, 50)
end

function guard10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 122), 7)
end

function guard11()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 123), 7)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
    fallout.set_map_var(0, 1)
end

function guard12()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 124), 7)
end

function guard13()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(113, 125), 7)
end

function guard06a()
    hostile = 1
    BottomReact()
end

function guard07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        guard09()
    else
        guard08()
    end
end

function guard07_1()
    fallout.gsay_reply(113, 116)
    fallout.giq_option(5, 113, 117, guard07a, 50)
end

function guardend()
end

function set_sleep_tile()
    if home_tile == 15283 then
        sleep_tile = 14685
    else
        if home_tile == 15886 then
            sleep_tile = 14479
        else
            if home_tile == 15881 then
                sleep_tile = 15479
            end
        end
    end
    wake_time = fallout.random(610, 650)
    sleep_time = fallout.random(2110, 2150)
end

function sleeping()
    if fallout.local_var(9) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(9, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(9, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(9, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(9, 1)
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
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
