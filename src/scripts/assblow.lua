local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local look_at_p_proc
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

local sneaking = false
local hostile = false
local warned = false
local line166flag = false

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        pre_dialogue()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if hostile and fallout.local_var(4) == 0 then
        hostile = false
        fallout.set_local_var(4, 1)
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.global_var(247) == 1 then
                if line166flag == 0 then
                    fallout.dialogue_system_enter()
                end
            else
                if misc.is_armed(dude_obj)
                    and fallout.local_var(4) == 0
                    and fallout.global_var(36) == 0
                    and fallout.global_var(104) == 0 then
                    if fallout.external_var("weapon_checked") == 0 then
                        fallout.set_external_var("weapon_checked", 1)
                        fallout.rm_timer_event(self_obj)
                        fallout.add_timer_event(self_obj, fallout.game_ticks(5), 1)
                        fallout.dialogue_system_enter()
                    end
                else
                    if fallout.using_skill(dude_obj, 8) and fallout.external_var("sneak_checked") == 0 then
                        sneaking = true
                        fallout.set_external_var("sneak_checked", 1)
                        fallout.rm_timer_event(self_obj)
                        fallout.add_timer_event(self_obj, fallout.game_ticks(5), 2)
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
        if time.is_night() then
            if fallout.tile_distance(fallout.tile_num(dude_obj), 27106) > fallout.tile_distance(fallout.tile_num(dude_obj), 25905) then
                if fallout.local_var(5) == 0 then
                    if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                        if not warned then
                            if not fallout.using_skill(dude_obj, 8) then
                                warned = true
                                fallout.dialogue_system_enter()
                                fallout.rm_timer_event(self_obj)
                                fallout.add_timer_event(self_obj, fallout.game_ticks(3), 4)
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
        reputation.inc_good_critter()
    end
end

function map_enter_p_proc()
    if fallout.global_var(15) == 1 then
        fallout.kill_critter(fallout.self_obj(), 59)
    end
end

function pickup_p_proc()
    hostile = true
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(135, 100))
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if misc.is_armed(fallout.dude_obj()) then
            hostile = true
        else
            fallout.set_external_var("weapon_checked", 0)
        end
    elseif event == 2 then
        fallout.set_external_var("sneak_checked", 0)
    elseif event == 3 then
        hostile = true
    elseif event == 4 then
        if time.is_night() then
            local dude_obj = fallout.dude_obj()
            local dude_tile_num = fallout.tile_num(dude_obj)
            if fallout.tile_distance(dude_tile_num, 27106) > fallout.tile_distance(dude_tile_num, 25905) then
                if fallout.local_var(5) == 0 then
                    if not fallout.using_skill(dude_obj, 8) then
                        hostile = true
                    end
                end
            else
                warned = false
            end
        end
    end
end

function do_dialogue()
    reaction.get_reaction()
    if time.is_night() and fallout.local_var(7) == 1 then
        if fallout.local_var(5) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(135, 167), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(135, 156), 0)
        end
    else
        fallout.start_gdialog(135, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if misc.is_armed(fallout.dude_obj()) and fallout.local_var(4) == 0 then
            guard00()
        elseif sneaking then
            guard06()
        elseif time.is_night() then
            guard00N()
        elseif fallout.local_var(8) == 0 then
            guard10()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function pre_dialogue()
    if fallout.global_var(247) == 1 and not line166flag then
        Guard18()
    elseif misc.is_armed(fallout.dude_obj()) and fallout.local_var(4) == 0 then
        do_dialogue()
    elseif sneaking then
        do_dialogue()
    elseif time.is_night() then
        do_dialogue()
    elseif fallout.local_var(8) == 0 then
        do_dialogue()
    else
        guard02a()
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
    hostile = true
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
    sneaking = false
    fallout.gsay_reply(135, 124)
    fallout.giq_option(4, 135, 125, guard07, 50)
    fallout.giq_option(5, 135, 126, guard06i, 50)
    fallout.giq_option(-3, 135, 127, guard07, 50)
end

function guard06i()
    fallout.set_external_var("times_caught_sneaking", fallout.external_var("times_caught_sneaking") + 1)
    local modifier = -5 * fallout.external_var("times_caught_sneaking")
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, modifier)) then
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
    local self_obj = fallout.self_obj()
    fallout.float_msg(self_obj, fallout.message_str(135, 166), 2)
    fallout.rm_timer_event(self_obj)
    fallout.add_timer_event(self_obj, fallout.game_ticks(5), 3)
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
    fallout.gsay_message(135,
        fallout.message_str(135, 164) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(135, 165), 50)
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
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
