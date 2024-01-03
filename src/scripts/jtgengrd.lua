local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 7000
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 0
local g6 = 0

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local damage_p_proc
local JTGenGrd00
local JTGenGrd00a
local JTGenGrd00b
local JTGenGrd01
local JTGenGrd01a
local JTGenGrd02
local JTGenGrd02a
local JTGenGrd03
local JTGenGrd04
local JTGenGrd05
local JTGenGrd06
local JTGenGrd06a
local JTGenGrd07
local JTGenGrd08
local JTGenGrd08a
local JTGenGrd09
local JTGenGrd16
local JTGenGrd18
local JTGenGrd19
local JTGenGrd20
local JTGenGrdEnd

-- ?import? variable dest_tile
-- ?import? variable hostile
-- ?import? variable initialized
-- ?import? variable sneaking
-- ?import? variable warned_about_picking
-- ?import? variable waypoint
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
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
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
end

function critter_p_proc()
    if g1 then
        g1 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (fallout.cur_map_index() == 12) or (fallout.cur_map_index() == 10) then
            if fallout.tile_num(fallout.self_obj()) ~= fallout.local_var(5) then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(5), 0)
            end
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
                if fallout.global_var(247) == 1 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 138), 2)
                    g1 = 1
                else
                    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and (fallout.local_var(4) == 0) and (fallout.map_var(2) == 0) and (fallout.global_var(36) == 0) and (fallout.global_var(104) == 0) and (fallout.cur_map_index() == 12) then
                        if not(fallout.external_var("weapon_checked")) then
                            fallout.set_external_var("weapon_checked", 1)
                            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
                            fallout.dialogue_system_enter()
                        end
                    else
                        if fallout.using_skill(fallout.dude_obj(), 8) and not(fallout.external_var("sneak_checked")) then
                            g3 = 1
                            fallout.set_external_var("sneak_checked", 1)
                            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 2)
                            fallout.dialogue_system_enter()
                        else
                            if fallout.cur_map_index() == 12 then
                                if (fallout.map_var(8) == 1) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) then
                                    fallout.set_map_var(8, 0)
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 136), 2)
                                    if g4 then
                                        g1 = 1
                                    else
                                        g4 = 1
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if fallout.cur_map_index() == 11 then
                if fallout.map_var(2) == 2 then
                    if g5 ~= 0 then
                        if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), g0) > 3 then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), g0, 0)
                        else
                            if g5 == 1 then
                                g0 = 20284
                                g5 = 2
                            else
                                if g5 == 2 then
                                    g0 = 23465
                                end
                                if (fallout.tile_distance(fallout.tile_num(fallout.self_obj()), g0) > 3) and (g5 ~= 0) then
                                    fallout.animate_move_obj_to_tile(fallout.self_obj(), g0, 0)
                                else
                                    if g5 == 2 then
                                        g0 = 26855
                                        g5 = 3
                                    else
                                        if g5 == 3 then
                                            fallout.destroy_object(fallout.self_obj())
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
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(37, 100))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 11)
    end
    if fallout.cur_map_index() == 11 then
        if fallout.map_var(2) == 1 then
            fallout.set_map_var(1, fallout.map_var(1) - 1)
        end
    end
end

function map_enter_p_proc()
    if fallout.cur_map_index() == 12 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 12)
    else
        if fallout.cur_map_index() == 10 then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 11)
        else
            if fallout.cur_map_index() == 11 then
                fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
                g0 = 23666
                g5 = 1
                if fallout.map_var(2) == 0 then
                    fallout.destroy_object(fallout.self_obj())
                end
            end
        end
    end
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, fallout.tile_num(fallout.self_obj()))
    end
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(136, 138)), 2)
    g1 = 1
end

function talk_p_proc()
    get_reaction()
    if g3 and (fallout.external_var("times_caught_sneaking") >= 3) then
        JTGenGrd18()
    else
        if not(fallout.local_var(4)) and ((fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3)) or (g3 and (fallout.external_var("times_caught_sneaking") < 3)) then
            fallout.start_gdialog(37, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                JTGenGrd00()
            else
                if g3 then
                    JTGenGrd06()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if fallout.global_var(158) > 2 then
                JTGenGrd19()
            else
                if reputation.has_rep_berserker() or (fallout.local_var(1) == 1) then
                    JTGenGrd09()
                else
                    if reputation.has_rep_champion() or (fallout.local_var(1) == 3) then
                        JTGenGrd16()
                    else
                        JTGenGrd20()
                    end
                end
            end
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if fallout.external_var("weapon_checked") then
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 134), 0)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 3)
            else
                fallout.set_external_var("weapon_checked", 0)
            end
        end
    else
        if fallout.fixed_param() == 2 then
            fallout.set_external_var("sneak_checked", 0)
        else
            if fallout.fixed_param() == 3 then
                g1 = 1
            else
                if fallout.fixed_param() == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 139), 0)
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 11)
    end
end

function JTGenGrd00()
    DownReact()
    fallout.gsay_reply(37, 110)
    fallout.giq_option(4, 37, 111, JTGenGrd01, 50)
    fallout.giq_option(4, 37, 112, JTGenGrd00a, 51)
    fallout.giq_option(4, 634, 105, JTGenGrdEnd, 50)
    fallout.giq_option(6, 37, 113, JTGenGrd00b, 49)
    fallout.giq_option(-3, 37, 114, JTGenGrd05, 50)
end

function JTGenGrd00a()
    DownReact()
    JTGenGrd02()
end

function JTGenGrd00b()
    UpReact()
    JTGenGrd04()
end

function JTGenGrd01()
    fallout.gsay_reply(37, 115)
    fallout.giq_option(4, 37, 116, JTGenGrd02, 50)
    fallout.giq_option(4, 37, 117, JTGenGrd01a, 50)
end

function JTGenGrd01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        JTGenGrd03()
    else
        JTGenGrd02()
    end
end

function JTGenGrd02()
    fallout.gsay_reply(37, 118)
    fallout.giq_option(4, 37, 119, JTGenGrdEnd, 50)
    fallout.giq_option(4, 37, 120, JTGenGrd02a, 51)
end

function JTGenGrd02a()
    g1 = 1
end

function JTGenGrd03()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(37, 121, 50)
end

function JTGenGrd04()
    fallout.gsay_message(37, 122, 50)
end

function JTGenGrd05()
    fallout.gsay_message(37, 123, 50)
end

function JTGenGrd06()
    fallout.set_external_var("times_caught_sneaking", fallout.external_var("times_caught_sneaking") + 1)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 2)
    fallout.gsay_reply(37, 124)
    fallout.giq_option(4, 37, 125, JTGenGrd07, 50)
    fallout.giq_option(5, 37, 126, JTGenGrd06a, 50)
    fallout.giq_option(-3, 37, 127, JTGenGrd07, 50)
end

function JTGenGrd06a()
    local v0 = 0
    v0 = -5 * fallout.external_var("times_caught_sneaking")
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, v0)) then
        JTGenGrd08()
    else
        JTGenGrd07()
    end
end

function JTGenGrd07()
    fallout.gsay_message(37, 128, 50)
end

function JTGenGrd08()
    fallout.gsay_reply(37, 130)
    fallout.giq_option(5, 37, 131, JTGenGrdEnd, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(5, 37, 132, JTGenGrd08a, 50)
    else
        fallout.giq_option(5, 37, 133, JTGenGrd08a, 50)
    end
end

function JTGenGrd08a()
    if fallout.random(0, 1) then
        DownReact()
    else
        UpReact()
    end
end

function JTGenGrd09()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(101, 103)), 51)
end

function JTGenGrd16()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(104, 106)), 49)
end

function JTGenGrd18()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 135), 2)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 3)
end

function JTGenGrd19()
    fallout.display_msg(fallout.message_str(37, 129))
    g1 = 1
end

function JTGenGrd20()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(107, 109)), 0)
end

function JTGenGrdEnd()
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
        if reputation.has_rep_champion() then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if reputation.has_rep_berserker() then
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
    g6 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
