local fallout = require("fallout")
local reaction = require("lib.reaction")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local timed_event_p_proc
local do_dialogue
local pre_dialogue
local guard00a
local guard01a
local guard02a
local guard00
local guard00i
local guard00ii
local guard01
local guard01i
local guard02
local guard02i
local guard03
local guard04
local guard05
local guard06
local guard06i
local guard07
local guard08
local guard08i
local guard09
local guard10
local guard11
local guard12
local guard12i
local guard13
local guard14
local guard15
local guard16
local guard17
local Guard18
local guard00N
local guard00Na
local guard01N
local guard02N
local guard03N
local guard04N
local guardend

local sneaking = 0
local RoundCounter = 0
local hostile = 0
local warned = 0
local line166flag = 0

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
                if fallout.script_action() == 15 then
                    map_enter_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            pre_dialogue()
                        else
                            if fallout.script_action() == 21 then
                                fallout.script_overrides()
                                fallout.display_msg(fallout.message_str(135, 100))
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
    if hostile and not(fallout.local_var(4)) then
        hostile = 0
        fallout.set_local_var(4, 1)
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.global_var(247) == 1 then
                if line166flag == 0 then
                    fallout.dialogue_system_enter()
                end
            else
                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(fallout.local_var(4)) and (fallout.global_var(36) == 0) and (fallout.global_var(104) == 0) then
                    if not(fallout.external_var("weapon_checked")) then
                        fallout.set_external_var("weapon_checked", 1)
                        fallout.rm_timer_event(fallout.self_obj())
                        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
                        fallout.dialogue_system_enter()
                    end
                else
                    if fallout.using_skill(fallout.dude_obj(), 8) and not(fallout.external_var("sneak_checked")) then
                        sneaking = 1
                        fallout.set_external_var("sneak_checked", 1)
                        fallout.rm_timer_event(fallout.self_obj())
                        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 2)
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
        if time.is_night() then
            if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 27106) > fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 25905) then
                if fallout.local_var(5) == 0 then
                    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                        if not(warned) then
                            if not(fallout.using_skill(fallout.dude_obj(), 8)) then
                                warned = 1
                                fallout.dialogue_system_enter()
                                fallout.rm_timer_event(fallout.self_obj())
                                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 4)
                            end
                        end
                    end
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        fallout.set_local_var(6, 1)
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
        fallout.kill_critter(fallout.self_obj(), 59)
    end
end

function pickup_p_proc()
    hostile = 1
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            hostile = 1
        else
            fallout.set_external_var("weapon_checked", 0)
        end
    else
        if fallout.fixed_param() == 2 then
            fallout.set_external_var("sneak_checked", 0)
        else
            if fallout.fixed_param() == 3 then
                hostile = 1
            else
                if fallout.fixed_param() == 4 then
                    if time.is_night() then
                        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 27106) > fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 25905) then
                            if fallout.local_var(5) == 0 then
                                if not(fallout.using_skill(fallout.dude_obj(), 8)) then
                                    hostile = 1
                                end
                            end
                        else
                            warned = 0
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    reaction.get_reaction()
    if time.is_night() and (fallout.local_var(7) == 1) then
        if fallout.local_var(5) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(135, 167), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(135, 156), 0)
        end
    else
        fallout.start_gdialog(135, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(fallout.local_var(4)) then
            guard00()
        else
            if sneaking then
                guard06()
            else
                if time.is_night() then
                    guard00N()
                else
                    if fallout.local_var(8) == 0 then
                        guard10()
                    end
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function pre_dialogue()
    if (fallout.global_var(247) == 1) and (line166flag == 0) then
        Guard18()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(fallout.local_var(4)) then
            do_dialogue()
        else
            if sneaking then
                do_dialogue()
            else
                if time.is_night() then
                    do_dialogue()
                else
                    if fallout.local_var(8) == 0 then
                        do_dialogue()
                    else
                        guard02a()
                    end
                end
            end
        end
    end
end

function guard00a()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(135, fallout.random(101, 103)), 2)
end

function guard01a()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(135, fallout.random(104, 106)), 3)
end

function guard02a()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(135, fallout.random(107, 109)), 0)
end

function guard00()
    fallout.gsay_reply(135, 110)
    fallout.giq_option(4, 135, 111, guard01, 50)
    fallout.giq_option(4, 135, 112, guard00i, 51)
    fallout.giq_option(4, 634, 105, guardend, 50)
    fallout.giq_option(6, 135, 113, guard00ii, 49)
    fallout.giq_option(-3, 135, 114, guard05, 50)
end

function guard00i()
    reaction.BigDownReact()
    guard02()
end

function guard00ii()
    reaction.BigUpReact()
    guard04()
end

function guard01()
    fallout.gsay_reply(135, 115)
    fallout.giq_option(4, 135, 116, guard02, 50)
    fallout.giq_option(4, 135, 117, guard01i, 50)
end

function guard01i()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        guard03()
    else
        guard02()
    end
end

function guard02()
    fallout.gsay_reply(135, 118)
    fallout.giq_option(4, 135, 119, guardend, 50)
    fallout.giq_option(4, 135, 120, guard02i, 51)
end

function guard02i()
    hostile = 1
end

function guard03()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(135, 121, 50)
end

function guard04()
    fallout.gsay_message(135, 122, 50)
end

function guard05()
    fallout.gsay_message(135, 123, 50)
end

function guard06()
    sneaking = 0
    fallout.gsay_reply(135, 124)
    fallout.giq_option(4, 135, 125, guard07, 50)
    fallout.giq_option(5, 135, 126, guard06i, 50)
    fallout.giq_option(-3, 135, 127, guard07, 50)
end

function guard06i()
    local v0 = 0
    fallout.set_external_var("times_caught_sneaking", fallout.external_var("times_caught_sneaking") + 1)
    v0 = -5 * fallout.external_var("times_caught_sneaking")
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, v0)) then
        guard08()
    else
        guard07()
    end
end

function guard07()
    if fallout.external_var("times_caught_sneaking") > 3 then
        fallout.gsay_message(135, 129, 51)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 3)
    else
        fallout.gsay_message(135, 128, 51)
    end
end

function guard08()
    fallout.gsay_reply(135, 130)
    fallout.giq_option(5, 135, 131, guardend, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(5, 135, 132, guard08i, 50)
    else
        fallout.giq_option(5, 135, 133, guard08i, 50)
    end
end

function guard08i()
    if fallout.random(0, 1) then
        reaction.UpReact()
    else
        reaction.DownReact()
    end
end

function guard09()
    fallout.gsay_message(135, 134, 50)
end

function guard10()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(135, 135)
    fallout.giq_option(4, 135, 136, guardend, 50)
    fallout.giq_option(5, 135, 137, guard12, 50)
    fallout.giq_option(6, 135, 138, guard15, 50)
    fallout.giq_option(-3, 135, 139, guard11, 50)
end

function guard11()
    fallout.gsay_message(135, 140, 50)
end

function guard12()
    fallout.gsay_reply(135, 141)
    fallout.giq_option(5, 135, 142, guard12i, 50)
    fallout.giq_option(5, 135, 143, guard14, 50)
end

function guard12i()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 15)) then
        guard13()
    else
        guard14()
    end
end

function guard13()
    fallout.gsay_reply(135, 144)
    fallout.giq_option(5, 135, 145, guardend, 50)
    fallout.giq_option(5, 135, 146, reaction.BigDownReact, 51)
end

function guard14()
    fallout.gsay_message(135, 147, 50)
end

function guard15()
    fallout.gsay_reply(135, 148)
    fallout.giq_option(5, 135, 149, guardend, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.giq_option(5, 135, 150, guard16, 50)
    end
end

function guard16()
    fallout.gsay_message(135, 152, 50)
end

function guard17()
    fallout.gsay_message(135, fallout.random(153, 155), 50)
end

function Guard18()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(135, 166), 2)
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 3)
end

function guard00N()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(135, 156)
    fallout.giq_option(4, 135, 157, guard02N, 50)
    fallout.giq_option(4, 135, 158, guardend, 50)
    fallout.giq_option(5, 135, 159, guard00Na, 50)
    fallout.giq_option(-3, 135, 160, guard01N, 50)
end

function guard00Na()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        guard03N()
    else
        guard02N()
    end
end

function guard01N()
    fallout.gsay_message(135, 161, 50)
end

function guard02N()
    fallout.gsay_message(135, 162, 50)
end

function guard03N()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(135, 163, 50)
end

function guard04N()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(135, fallout.message_str(135, 164) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(135, 165), 50)
end

function guardend()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
