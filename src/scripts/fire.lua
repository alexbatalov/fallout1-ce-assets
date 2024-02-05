local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local Fire00
local Fire01
local Fire02
local Fire03
local Fire04
local Fire05
local Fire06
local Fire07
local Fire08
local Fire09
local Fire10
local Fire11
local Fire12
local Fire13
local Fire14
local Fire15
local Fire16
local Fire17
local Fire18
local Fire19
local Fire20
local Fire21
local FireCombat
local FireEnd
local follow_player
local show_true_name
local show_false_name

local hostile = false
local initialized = false
local prev_tile = 7000
local dest_tile = 7000

local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and fallout.global_var(136) < 41 then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(136, fallout.global_var(136) - 1)
    fallout.set_global_var(131, 0)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    if fallout.global_var(135) == 2 or fallout.get_critter_stat(fallout.dude_obj(), 6) > 6 then
        show_true_name()
    elseif fallout.get_critter_stat(fallout.dude_obj(), 6) < 4 then
        show_false_name()
    elseif fallout.get_critter_stat(fallout.dude_obj(), 4) < 5 then
        show_false_name()
    else
        if fallout.random(0, 1) then
            show_false_name()
        else
            show_true_name()
        end
    end
end

function map_update_p_proc()
    local self_obj = fallout.self_obj()
    if not initialized then
        misc.set_ai(self_obj, 27)
        if fallout.cur_map_index() == 44 then
            misc.set_team(self_obj, 47)
        elseif fallout.cur_map_index() == 17 or fallout.cur_map_index() == 18 then
            fallout.party_add(self_obj)
            if fallout.global_var(131) == 1 then
                fallout.set_obj_visibility(self_obj, 0)
                misc.set_team(self_obj, 0)
                fallout.add_timer_event(self_obj, fallout.game_ticks(1), 1)
            else
                fallout.set_obj_visibility(self_obj, true)
            end
        else
            fallout.party_remove(self_obj)
        end
        initialized = true
    end
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local dude_elevation = fallout.elevation(dude_obj)
    if fallout.elevation(self_obj) ~= dude_elevation and fallout.global_var(131) == 1 then
        fallout.move_to(self_obj, fallout.tile_num_in_direction(dude_tile_num, fallout.random(4, 5), 1), dude_elevation)
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(280, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_local_var(4, 1)
    if time.is_night() then
        Fire18()
    else
        if fallout.global_var(135) == 2 then
            Fire21()
        else
            if fallout.global_var(135) == 1 then
                if fallout.global_var(131) == 1 then
                    Fire19()
                else
                    Fire20()
                end
            else
                Fire00()
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Fire00()
    fallout.gsay_reply(280, 111)
    fallout.giq_option(-3, 280, 112, Fire01, 50)
    fallout.giq_option(4, 280, 113, Fire07, 50)
    fallout.giq_option(6, 280, 114, Fire11, 50)
    fallout.giq_option(5, 280, 115, FireCombat, 50)
    fallout.giq_option(4, 280, 116, FireEnd, 50)
    fallout.giq_option(6, 280, 117, Fire17, 50)
end

function Fire01()
    fallout.gsay_reply(280, 118)
    fallout.giq_option(-3, 280, 119, Fire02, 50)
    fallout.giq_option(-3, 280, 120, Fire05, 50)
    fallout.giq_option(-3, 280, 121, Fire06, 50)
end

function Fire02()
    fallout.gsay_reply(280, 122)
    fallout.giq_option(-3, 280, 123, Fire03, 50)
    fallout.giq_option(-3, 280, 124, Fire04, 50)
end

function Fire03()
    fallout.gsay_message(280, 125, 50)
end

function Fire04()
    fallout.gsay_message(280, 126, 50)
    FireCombat()
end

function Fire05()
    fallout.gsay_message(280, 127, 50)
    FireCombat()
end

function Fire06()
    fallout.gsay_message(280, 128, 50)
end

function Fire07()
    fallout.gsay_reply(280, 129)
    fallout.giq_option(4, 280, 130, FireEnd, 50)
    fallout.giq_option(4, 280, 131, Fire08, 50)
    fallout.giq_option(5, 280, 132, Fire09, 50)
    fallout.giq_option(7, 280, 133, Fire10, 50)
end

function Fire08()
    fallout.gsay_message(280, 134, 50)
    FireCombat()
end

function Fire09()
    fallout.gsay_reply(280, 135)
    fallout.giq_option(5, 280, 136, FireEnd, 50)
    fallout.giq_option(5, 280, 137, Fire08, 50)
end

function Fire10()
    fallout.gsay_message(280, 138, 50)
end

function Fire11()
    fallout.gsay_reply(280, 139)
    fallout.giq_option(6, 280, 140, Fire12, 50)
    fallout.giq_option(6, 280, 141, Fire15, 50)
    fallout.giq_option(6, 280, 142, Fire16, 50)
end

function Fire12()
    fallout.gsay_reply(280, 143)
    fallout.giq_option(6, 280, 144, Fire13, 50)
    fallout.giq_option(6, 280, 145, Fire14, 50)
end

function Fire13()
    fallout.gsay_message(280, 146, 50)
end

function Fire14()
    fallout.gsay_message(280, 147, 50)
    FireCombat()
end

function Fire15()
    fallout.gsay_message(280, 148, 50)
end

function Fire16()
    fallout.gsay_message(280, 149, 50)
    FireCombat()
end

function Fire17()
    fallout.gsay_message(280, 150, 50)
    FireCombat()
end

function Fire18()
    fallout.gsay_message(280, 151, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 2)
end

function Fire19()
    fallout.gsay_message(280, 152, 50)
end

function Fire20()
    fallout.gsay_message(280, 153, 50)
end

function Fire21()
    fallout.gsay_message(280, 154, 50)
end

function FireCombat()
    hostile = true
end

function FireEnd()
end

function follow_player()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local self_obj = fallout.self_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)

    prev_tile = dest_tile

    local rotation = (fallout.has_trait(1, dude_obj, 10) + fallout.random(4, 5)) % 6
    local distance = fallout.random(2, 3)
    dest_tile = fallout.tile_num_in_direction(dude_tile_num, rotation, distance)
    if fallout.tile_distance(prev_tile, dude_tile_num) > fallout.tile_distance(dest_tile, dude_tile_num) then
        if distance_self_to_dude > 8 then
            fallout.animate_move_obj_to_tile(self_obj, dest_tile, 1 | 16)
        else
            fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0 | 16)
        end
    else
        if distance_self_to_dude > 8 then
            fallout.animate_move_obj_to_tile(self_obj, dest_tile, 1)
        else
            fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
        end
    end
    if distance_self_to_dude > 3 then
        fallout.add_timer_event(self_obj, fallout.game_ticks(1), 1)
    else
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(2, 5)), 1)
    end
end

function show_true_name()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(280, 100))
    else
        fallout.display_msg(fallout.message_str(280, 103))
    end
end

function show_false_name()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(280, fallout.random(104, 110)))
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        follow_player()
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            hostile = true
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
