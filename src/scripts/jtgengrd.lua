local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

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

local dest_tile = 7000
local hostile = false
local sneaking = false
local warned_about_picking = false
local waypoint = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        local cur_map_index = fallout.cur_map_index()
        if cur_map_index == 12 or cur_map_index == 10 then
            if fallout.tile_num(self_obj) ~= fallout.local_var(5) then
                fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(5), 0)
            end
            if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                if fallout.global_var(247) == 1 then
                    fallout.float_msg(self_obj, fallout.message_str(37, 138), 2)
                    hostile = true
                else
                    if misc.is_armed(dude_obj)
                        and fallout.local_var(4) == 0
                        and fallout.map_var(2) == 0
                        and fallout.global_var(36) == 0
                        and fallout.global_var(104) == 0
                        and cur_map_index == 12 then
                        if fallout.external_var("weapon_checked") == 0 then
                            fallout.set_external_var("weapon_checked", 1)
                            fallout.add_timer_event(self_obj, fallout.game_ticks(10), 1)
                            fallout.dialogue_system_enter()
                        end
                    else
                        if fallout.using_skill(dude_obj, 8) and fallout.external_var("sneak_checked") == 0 then
                            sneaking = true
                            fallout.set_external_var("sneak_checked", 1)
                            fallout.add_timer_event(self_obj, fallout.game_ticks(5), 2)
                            fallout.dialogue_system_enter()
                        else
                            if cur_map_index == 12 then
                                if fallout.map_var(8) == 1 and fallout.tile_distance_objs(self_obj, dude_obj) < 8 then
                                    fallout.set_map_var(8, 0)
                                    fallout.float_msg(self_obj, fallout.message_str(37, 136), 2)
                                    if warned_about_picking then
                                        hostile = true
                                    else
                                        warned_about_picking = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        elseif cur_map_index == 11 then
            if fallout.map_var(2) == 2 then
                if waypoint ~= 0 then
                    if fallout.tile_distance(fallout.tile_num(self_obj), dest_tile) > 3 then
                        fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
                    else
                        if waypoint == 1 then
                            dest_tile = 20284
                            waypoint = 2
                        else
                            if waypoint == 2 then
                                dest_tile = 23465
                            end
                            if fallout.tile_distance(fallout.tile_num(self_obj), dest_tile) > 3 and waypoint ~= 0 then
                                fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
                            else
                                if waypoint == 2 then
                                    dest_tile = 26855
                                    waypoint = 3
                                elseif waypoint == 3 then
                                    fallout.destroy_object(self_obj)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
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
    local self_obj = fallout.self_obj()
    local cur_map_index = fallout.cur_map_index()
    if cur_map_index == 12 then
        fallout.critter_add_trait(self_obj, 1, 6, 12)
    elseif cur_map_index == 10 then
        fallout.critter_add_trait(self_obj, 1, 6, 11)
    elseif cur_map_index == 11 then
        fallout.critter_add_trait(self_obj, 1, 6, 0)
        dest_tile = 23666
        waypoint = 1
        if fallout.map_var(2) == 0 then
            fallout.destroy_object(self_obj)
        end
    end
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, fallout.tile_num(self_obj))
    end
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(136, 138)), 2)
    hostile = true
end

function talk_p_proc()
    reaction.get_reaction()
    if sneaking and (fallout.external_var("times_caught_sneaking") >= 3) then
        JTGenGrd18()
    else
        if fallout.local_var(4) == 0 and misc.is_armed(fallout.dude_obj()) or (sneaking and (fallout.external_var("times_caught_sneaking") < 3)) then
            fallout.start_gdialog(37, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if misc.is_armed(fallout.dude_obj()) then
                JTGenGrd00()
            else
                if sneaking then
                    JTGenGrd06()
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if fallout.global_var(158) > 2 then
                JTGenGrd19()
            elseif reputation.has_rep_berserker() or fallout.local_var(1) == 1 then
                JTGenGrd09()
            elseif reputation.has_rep_champion() or fallout.local_var(1) == 3 then
                JTGenGrd16()
            else
                JTGenGrd20()
            end
        end
    end
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if fallout.external_var("weapon_checked") ~= 0 then
            if misc.is_armed(fallout.dude_obj()) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 134), 0)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 3)
            else
                fallout.set_external_var("weapon_checked", 0)
            end
        end
    elseif event == 2 then
        fallout.set_external_var("sneak_checked", 0)
    elseif event == 3 then
        hostile = true
    elseif event == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 139), 0)
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 11)
    end
end

function JTGenGrd00()
    reaction.DownReact()
    fallout.gsay_reply(37, 110)
    fallout.giq_option(4, 37, 111, JTGenGrd01, 50)
    fallout.giq_option(4, 37, 112, JTGenGrd00a, 51)
    fallout.giq_option(4, 634, 105, JTGenGrdEnd, 50)
    fallout.giq_option(6, 37, 113, JTGenGrd00b, 49)
    fallout.giq_option(-3, 37, 114, JTGenGrd05, 50)
end

function JTGenGrd00a()
    reaction.DownReact()
    JTGenGrd02()
end

function JTGenGrd00b()
    reaction.UpReact()
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
    hostile = true
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
    local modifier = -5 * fallout.external_var("times_caught_sneaking")
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, modifier)) then
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
        reaction.DownReact()
    else
        reaction.UpReact()
    end
end

function JTGenGrd09()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(101, 103)), 51)
end

function JTGenGrd16()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(104, 106)), 49)
end

function JTGenGrd18()
    local self_obj = fallout.self_obj()
    fallout.float_msg(self_obj, fallout.message_str(37, 135), 2)
    fallout.add_timer_event(self_obj, fallout.game_ticks(5), 3)
end

function JTGenGrd19()
    fallout.display_msg(fallout.message_str(37, 129))
    hostile = true
end

function JTGenGrd20()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(37, fallout.random(107, 109)), 0)
end

function JTGenGrdEnd()
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
