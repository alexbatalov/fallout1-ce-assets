local fallout = require("fallout")

local start
local combat_p_proc
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local WtrThief01
local WtrThief02
local WtrThief03
local WtrThief04
local WtrThief05
local WtrThief06
local WtrThief07
local WtrThief08
local WtrThief09
local WtrThief10
local WtrThief11
local WtrThief11a
local WtrThiefCombat
local finish_quest
local WtrThiefBye
local WtrThiefEnd

local dest_tile = 7000
local hostile = 0
local watched = 0
local got_water = 0
local on_the_way = 0
local searched = 0
local scared = 0

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
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        if fallout.external_var("Officer_ptr") ~= 0 then
            fallout.critter_add_trait(fallout.external_var("Officer_ptr"), 1, 6, 0)
        end
    end
end

function critter_p_proc()
    local v0 = 0
    if hostile then
        hostile = 0
        scared = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.game_time_hour() <= 600 then
            if fallout.global_var(188) == 1 then
                if not(got_water) then
                    if not(on_the_way) then
                        on_the_way = 1
                        dest_tile = 22728
                        fallout.move_to(fallout.self_obj(), 16912, 2)
                        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
                    end
                end
            end
            if fallout.tile_num(fallout.self_obj()) ~= dest_tile then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 0)
            end
        else
            got_water = 0
            on_the_way = 0
            if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 126) then
                fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.self_obj(), 126))
            end
        end
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.external_var("VaultBox_ptr")) < 4 then
            if not(got_water) then
                if fallout.anim_busy(fallout.self_obj()) == 0 then
                    fallout.use_obj(fallout.external_var("VaultBox_ptr"))
                    got_water = 1
                    v0 = fallout.create_object_sid(126, 0, 0, -1)
                    fallout.add_obj_to_inven(fallout.self_obj(), v0)
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
                    if fallout.obj_can_see_obj(fallout.dude_obj(), fallout.self_obj()) then
                        fallout.display_msg(fallout.message_str(461, 103))
                    end
                end
            end
        end
        if got_water and (fallout.tile_num(fallout.self_obj()) == 16912) then
            fallout.move_to(fallout.self_obj(), 7000, 0)
            dest_tile = 7000
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    watched = 1
    fallout.display_msg(fallout.message_str(461, 102))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(160, fallout.global_var(160) + 1)
            if (fallout.global_var(160) % 6) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) + 1)
            end
        end
        fallout.display_msg(fallout.message_str(461, 104))
        fallout.give_exp_points(500)
    end
    fallout.set_global_var(188, 2)
    if fallout.external_var("Officer_ptr") ~= 0 then
        fallout.critter_add_trait(fallout.external_var("Officer_ptr"), 1, 6, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if not(watched) then
        watched = fallout.is_success(fallout.do_check(fallout.self_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0)))
    end
    if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 2) and not(watched) then
        fallout.display_msg(fallout.message_str(461, 100))
    else
        fallout.display_msg(fallout.message_str(461, 101))
    end
end

function map_enter_p_proc()
    fallout.set_external_var("WtrThief_ptr", fallout.self_obj())
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 1)
    if fallout.global_var(188) == 0 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    else
        fallout.set_obj_visibility(fallout.self_obj(), 0)
    end
end

function map_update_p_proc()
    if fallout.global_var(188) == 0 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    else
        fallout.set_obj_visibility(fallout.self_obj(), 0)
    end
    if (fallout.game_time_hour() > 700) and (fallout.tile_num(fallout.self_obj()) ~= 7000) then
        fallout.move_to(fallout.self_obj(), 7000, 0)
        dest_tile = 7000
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if scared then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 16912, 1)
    else
        fallout.start_gdialog(461, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        watched = 1
        WtrThief01()
        fallout.gsay_end()
        fallout.end_dialogue()
        if fallout.global_var(188) == 2 then
            fallout.gfade_out(600)
            fallout.move_to(fallout.self_obj(), 7000, 2)
            if fallout.external_var("Officer_ptr") ~= 0 then
                fallout.move_to(fallout.external_var("Officer_ptr"), 22093, 2)
                fallout.move_to(fallout.dude_obj(), 22293, 2)
                fallout.anim(fallout.dude_obj(), 1000, 5)
                fallout.anim(fallout.external_var("Officer_ptr"), 1000, 2)
                fallout.float_msg(fallout.external_var("Officer_ptr"), fallout.message_str(461, 105), 0)
            end
            fallout.gfade_in(600)
            fallout.display_msg(fallout.message_str(461, 106))
            fallout.give_exp_points(1000)
        end
        if searched then
            fallout.display_msg(fallout.message_str(461, 130))
            searched = 0
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            dest_tile = 16912
        else
            dest_tile = 20706
        end
    else
        if fallout.fixed_param() == 2 then
            dest_tile = 16912
        end
    end
end

function WtrThief01()
    local v0 = 0
    v0 = fallout.message_str(461, 107)
    v0 = v0 + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1)
    v0 = v0 .. fallout.message_str(461, 108)
    fallout.gsay_reply(461, v0)
    fallout.giq_option(4, 461, 109, WtrThief02, 50)
    fallout.giq_option(-3, 461, 110, WtrThiefEnd, 50)
end

function WtrThief02()
    fallout.gsay_reply(461, 111)
    fallout.giq_option(4, 461, 112, WtrThiefBye, 50)
    fallout.giq_option(4, 461, 113, WtrThief03, 50)
    if fallout.global_var(188) == 1 then
        fallout.giq_option(4, 461, 114, WtrThief05, 50)
    end
end

function WtrThief03()
    fallout.gsay_reply(461, 115)
    fallout.giq_option(4, 461, 116, WtrThief04, 50)
    fallout.giq_option(4, 461, 117, WtrThief05, 51)
end

function WtrThief04()
    fallout.gsay_reply(461, 118)
    fallout.giq_option(4, 461, 119, WtrThiefBye, 50)
end

function WtrThief05()
    if got_water then
        WtrThief08()
    else
        WtrThief06()
    end
end

function WtrThief06()
    fallout.gsay_reply(461, 120)
    fallout.giq_option(4, 461, 121, WtrThief07, 50)
end

function WtrThief07()
    searched = 1
end

function WtrThief08()
    fallout.gsay_reply(461, 122)
    fallout.giq_option(4, 461, 123, WtrThiefEnd, 50)
    fallout.giq_option(4, 461, 124, WtrThief09, 51)
end

function WtrThief09()
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        WtrThief10()
    else
        WtrThief11()
    end
end

function WtrThief10()
    fallout.gsay_reply(461, 125)
    fallout.giq_option(4, 461, 126, finish_quest, 50)
end

function WtrThief11()
    fallout.gsay_reply(461, 127)
    fallout.giq_option(4, 461, 121, WtrThief11a, 50)
end

function WtrThief11a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        finish_quest()
    else
        WtrThiefCombat()
    end
end

function WtrThiefCombat()
    hostile = 1
end

function finish_quest()
    fallout.set_global_var(188, 2)
end

function WtrThiefBye()
    fallout.gsay_reply(461, 128)
    fallout.giq_option(4, 461, 129, WtrThiefEnd, 50)
end

function WtrThiefEnd()
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
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
