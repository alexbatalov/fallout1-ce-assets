local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Curtis01
local Curtis02
local Curtis03
local Curtis03a
local Curtis04
local Curtis05
local Curtis06
local Curtis07
local Curtis08
local CurtisEnd
local flee_dude
local movement
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local initialized = 0
local new_tile = 0
local round_counter = 0
local hostile = 0

function start()
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
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(246) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 5)
            fallout.set_global_var(246, 1)
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
    end
    if fallout.local_var(5) == 1 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            flee_dude()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(5, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(236, 100))
end

function map_enter_p_proc()
    home_tile = 22713
    wake_time = 615
    sleep_time = 2115
    sleep_tile = 27702
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
end

function pickup_p_proc()
    fallout.set_local_var(5, 1)
end

function talk_p_proc()
    if (fallout.local_var(5) == 1) or (fallout.global_var(246) == 1) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.start_gdialog(236, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(3) == 1 then
            Curtis02()
        else
            Curtis01()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    if fallout.local_var(2) == 1 then
        fallout.set_local_var(2, 2)
        fallout.give_exp_points(500)
        fallout.display_msg(fallout.message_str(236, 200))
    end
end

function timed_event_p_proc()
    if fallout.local_var(4) == 0 then
        if fallout.random(0, 3) == 3 then
            fallout.anim(fallout.self_obj(), 10, 0)
        else
            movement()
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 7)), 1)
end

function Curtis01()
    fallout.gsay_reply(236, 101)
    fallout.giq_option(4, 236, 102, Curtis03, 50)
    fallout.giq_option(-3, 236, 103, CurtisEnd, 50)
end

function Curtis02()
    fallout.gsay_reply(236, 104)
    fallout.giq_option(0, 634, 106, Curtis03, 50)
end

function Curtis03()
    fallout.gsay_reply(236, 105)
    Curtis03a()
end

function Curtis03a()
    if fallout.local_var(3) == 0 then
        fallout.gsay_option(236, 106, Curtis04, 50)
    end
    if fallout.local_var(0) == 0 then
        fallout.giq_option(5, 236, 107, Curtis05, 50)
    end
    if fallout.local_var(1) == 0 then
        fallout.giq_option(4, 236, 108, Curtis06, 50)
    end
    fallout.giq_option(4, 236, 109, CurtisEnd, 50)
end

function Curtis04()
    fallout.gsay_reply(236, 110)
    fallout.set_local_var(3, 1)
    Curtis03a()
end

function Curtis05()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(236, 111)
    Curtis03a()
end

function Curtis06()
    fallout.gsay_reply(236, 112)
    fallout.giq_option(4, 236, 113, Curtis03, 50)
    if (fallout.has_skill(fallout.dude_obj(), 12) >= 40) and (fallout.local_var(1) == 0) then
        fallout.giq_option(5, 236, 114, Curtis07, 50)
    end
end

function Curtis07()
    fallout.gsay_reply(236, 115)
    fallout.giq_option(4, 236, 116, CurtisEnd, 50)
    fallout.giq_option(5, 236, 117, Curtis08, 50)
end

function Curtis08()
    fallout.gsay_message(236, 118, 50)
    fallout.set_global_var(155, fallout.global_var(155) + 2)
    fallout.set_local_var(1, 1)
    fallout.set_local_var(2, 1)
end

function CurtisEnd()
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

function movement()
    local v0 = 0
    v0 = fallout.random(0, 5)
    new_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v0, 1)
    if fallout.tile_distance(home_tile, new_tile) < 6 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), new_tile, 0)
    end
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

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
