local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local get_rations
local set_ration_tile
local set_sleep_tile
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local rndx = 0
local hostile = 0
local sleeping_disabled = 0
local ration_tile = 0

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
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(101) == 0 then
            if fallout.local_var(5) == 0 then
                if (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.external_var("WtrGrd_ptr"))) and (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.dude_obj())) then
                    if (fallout.game_time_hour() > 700) and (fallout.game_time_hour() < 900) then
                        get_rations()
                    end
                end
            end
        end
        if not time.is_day() then
            fallout.set_local_var(5, 0)
            sleeping_disabled = 0
        end
        if sleeping_disabled == 0 then
            sleeping()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(7, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function map_enter_p_proc()
    if not(fallout.local_var(4)) then
        fallout.set_local_var(4, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(4)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
    set_ration_tile()
    set_sleep_tile()
    sleep_time = fallout.random(1900, 1930)
    wake_time = sleep_time - 1300
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.local_var(6) == 1 then
        if fallout.random(0, 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
        else
            fallout.display_msg(fallout.message_str(185, 167))
        end
    else
        if fallout.local_var(7) or fallout.global_var(261) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 105), 0)
        else
            if rndx == 0 then
                rndx = fallout.random(101, 106)
            end
            fallout.float_msg(fallout.self_obj(), fallout.message_str(130, rndx), 0)
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.external_var("WtrGrd_ptr")), 2, 1), 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
    else
        if fallout.fixed_param() == 2 then
            fallout.set_external_var("getting_ration", 1)
            if fallout.random(0, 1) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 165), 0)
            end
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 3)
        else
            if fallout.fixed_param() == 3 then
                fallout.set_external_var("recipient", 0)
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            end
        end
    end
end

function get_rations()
    sleeping_disabled = 1
    if fallout.tile_num(fallout.self_obj()) ~= ration_tile then
        if fallout.random(0, 1) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), ration_tile, 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), ration_tile, 1)
        end
    else
        if not(fallout.external_var("recipient")) then
            fallout.set_external_var("recipient", fallout.self_obj())
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
            fallout.set_local_var(5, 1)
            sleeping_disabled = 0
        end
    end
end

function set_ration_tile()
    if fallout.elevation(fallout.self_obj()) == 0 then
        ration_tile = fallout.tile_num_in_direction(14704, fallout.random(0, 5), fallout.random(1, 2))
    else
        if fallout.elevation(fallout.self_obj()) == 1 then
            ration_tile = fallout.tile_num_in_direction(21895, fallout.random(0, 5), fallout.random(1, 2))
        else
            if fallout.elevation(fallout.self_obj()) == 2 then
                ration_tile = fallout.tile_num_in_direction(22513, fallout.random(0, 5), fallout.random(1, 2))
            end
        end
    end
end

function set_sleep_tile()
    if fallout.elevation(fallout.self_obj()) == 0 then
        sleep_tile = 7000
    else
        if fallout.elevation(fallout.self_obj()) == 1 then
            sleep_tile = home_tile
        else
            if fallout.elevation(fallout.self_obj()) == 2 then
                sleep_tile = 7000
            end
        end
    end
end

function sleeping()
    if fallout.local_var(6) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(6, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(6, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(6, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(6, 1)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
