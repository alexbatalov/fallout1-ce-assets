local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local map_exit_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local set_sleep_tile
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local dest_tile = 7000
local hostile = 0
local sleeping_disabled = 0
local waypoint = 0

function start()
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
                    if fallout.script_action() == 16 then
                        map_exit_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.cur_map_index() == 11 then
            if (fallout.map_var(2) == 2) and (waypoint == 0) then
                waypoint = 1
                dest_tile = 26297
                sleeping_disabled = 1
            else
                if (fallout.global_var(282) == 1) and (waypoint == 0) then
                    waypoint = 1
                    sleeping_disabled = 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(8), 3)
                end
            end
            if waypoint ~= 0 then
                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), dest_tile) > 3 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 0)
                else
                    if waypoint == 1 then
                        if fallout.map_var(2) == 0 then
                            dest_tile = 33519
                        else
                            dest_tile = 20076
                            waypoint = 2
                        end
                    end
                end
            end
            if sleeping_disabled == 0 then
                sleeping()
            end
        else
            if fallout.cur_map_index() == 12 then
                if (fallout.global_var(555) ~= 2) and (sleeping_disabled == 0) then
                    sleeping()
                end
            end
        end
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
    if home_tile == 20082 then
        fallout.set_external_var("Skul_target", 0)
    end
    if (fallout.cur_map_index() == 11) and (fallout.map_var(2) == 1) then
        fallout.set_map_var(0, fallout.map_var(0) - 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(390, 100))
end

function map_enter_p_proc()
    if not(fallout.local_var(5)) then
        fallout.set_local_var(5, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(5)
    if fallout.cur_map_index() == 10 then
        if fallout.global_var(555) == 2 then
            fallout.set_obj_visibility(fallout.self_obj(), 0)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
    end
    if fallout.cur_map_index() ~= 11 then
        if fallout.cur_map_index() == 10 then
            if fallout.global_var(555) == 2 then
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(30, 60)), 1)
            end
        else
            if fallout.cur_map_index() == 12 then
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(30, 60)), 1)
            end
        end
    else
        if (fallout.global_var(282) == 1) and (fallout.map_var(2) == 0) then
            fallout.destroy_object(fallout.self_obj())
        end
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 14)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 59)
    if fallout.global_var(555) == 2 then
        if fallout.cur_map_index() == 10 then
            fallout.set_obj_visibility(fallout.self_obj(), 0)
        else
            fallout.destroy_object(fallout.self_obj())
        end
    end
    set_sleep_tile()
    if (home_tile == 20082) and (fallout.cur_map_index() == 11) then
        fallout.set_external_var("Skul_target", fallout.self_obj())
    end
end

function map_exit_p_proc()
    if fallout.cur_map_index() == 11 then
        if (fallout.global_var(282) == 1) and (fallout.map_var(2) == 0) then
            fallout.destroy_object(fallout.self_obj())
        end
    end
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(390, 101), 2)
    hostile = 1
end

function talk_p_proc()
    local v0 = 0
    if fallout.cur_map_index() == 10 then
        fallout.set_local_var(6, 104)
    else
        if (fallout.cur_map_index() == 11) and (fallout.map_var(2) == 2) then
            fallout.set_local_var(6, 112)
        else
            if fallout.local_var(6) == 0 then
                fallout.set_local_var(6, fallout.random(102, 105))
            end
        end
    end
    v0 = fallout.message_str(390, fallout.local_var(6))
    if fallout.local_var(4) == 1 then
        v0 = fallout.message_str(390, 106)
    end
    fallout.float_msg(fallout.self_obj(), v0, 0)
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        if (fallout.local_var(4) == 0) and (fallout.combat_is_initialized() == 0) then
            if fallout.random(0, 1) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(390, fallout.random(107, 112)), 0)
            else
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.local_var(5), fallout.random(0, 3), fallout.random(0, 5)), 0)
            end
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(30, 60)), 1)
    else
        if (fallout.fixed_param() == 2) and (fallout.external_var("Trish_ptr") ~= 0) and (fallout.external_var("Neal_ptr") ~= 0) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(387, 102), 2)
            fallout.reg_anim_func(2, fallout.self_obj())
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_obj(fallout.self_obj(), fallout.external_var("Trish_ptr"), -1)
            fallout.reg_anim_animate(fallout.self_obj(), 16, -1)
            fallout.reg_anim_animate(fallout.external_var("Trish_ptr"), 20, 4)
            fallout.reg_anim_animate(fallout.external_var("Trish_ptr"), 48, -1)
            fallout.reg_anim_animate(fallout.external_var("Trish_ptr"), 37, -1)
            fallout.reg_anim_obj_run_to_tile(fallout.external_var("Trish_ptr"), 19889, -1)
            fallout.reg_anim_func(3, 0)
            fallout.add_timer_event(fallout.external_var("Neal_ptr"), fallout.game_ticks(3), 1)
        else
            if fallout.fixed_param() == 3 then
                dest_tile = 26297
                sleeping_disabled = 1
            end
        end
    end
end

function set_sleep_tile()
    if fallout.cur_map_index() == 12 then
        if home_tile == 13502 then
            sleep_tile = 13093
        else
            if home_tile == 13516 then
                sleep_tile = 13719
            else
                if home_tile == 13717 then
                    sleep_tile = 13721
                end
            end
        end
        sleep_time = fallout.random(2200, 2215)
        wake_time = fallout.random(800, 815)
    else
        if fallout.cur_map_index() == 11 then
            sleep_tile = 7000
            sleep_time = 300
            wake_time = 1600
            night_person = 1
        else
            if fallout.cur_map_index() == 10 then
                sleep_tile = home_tile
                sleep_time = 2200
                wake_time = 1000
            end
        end
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
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_exit_p_proc = map_exit_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
