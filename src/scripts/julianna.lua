local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local flee_dude
local Julianna01
local Julianna02
local Julianna03
local Julianna04
local Julianna05
local Julianna06
local Julianna07
local Julianna08
local Julianna09
local Julianna10
local JuliannaEnd
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local initialized = false
local round_counter = 0

local exit_line = 0

function start()
    if not initialized then
        if (fallout.global_var(613) == 9103) or (fallout.global_var(613) == 9102) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        sleep_time = 1930
        wake_time = 830
        sleep_tile = 23151
        home_tile = 22749
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
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

function critter_p_proc()
    if fallout.local_var(5) and (fallout.local_var(6) == 0) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) then
        flee_dude()
    else
        sleeping()
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        reputation.inc_good_critter()
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(257, 100))
    else
        fallout.display_msg(fallout.message_str(257, 101))
    end
end

function pickup_p_proc()
    fallout.set_local_var(5, 1)
end

function talk_p_proc()
    if fallout.local_var(5) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 102), 0)
    else
        fallout.start_gdialog(257, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.global_var(127) < 3 then
            Julianna01()
        else
            Julianna10()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    if fallout.global_var(127) == 2 then
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, 1)
            fallout.display_msg(fallout.message_str(257, 126))
            fallout.give_exp_points(250)
        end
    end
end

function timed_event_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(257, 124), 0)
    fallout.display_msg(fallout.message_str(257, 125))
    fallout.critter_dmg(fallout.self_obj(), 200, 0)
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
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
end

function Julianna01()
    fallout.gsay_reply(257, 102)
    fallout.giq_option(-3, 257, 103, JuliannaEnd, 50)
    fallout.giq_option(4, 257, 104, JuliannaEnd, 50)
    if fallout.global_var(127) == 1 then
        fallout.giq_option(0, 257, 105, Julianna06, 50)
    end
    if not(fallout.local_var(4)) then
        fallout.giq_option(4, 257, 106, Julianna02, 50)
    end
end

function Julianna02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(257, 107)
    fallout.giq_option(4, 257, 108, Julianna03, 50)
    fallout.giq_option(4, 257, 109, Julianna04, 50)
end

function Julianna03()
    fallout.gsay_reply(257, 110)
    fallout.giq_option(4, 257, 111, Julianna05, 50)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 634, exit_line, JuliannaEnd, 50)
end

function Julianna04()
    fallout.gsay_reply(257, 112)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 634, exit_line, JuliannaEnd, 50)
end

function Julianna05()
    fallout.gsay_reply(257, 113)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 634, exit_line, JuliannaEnd, 50)
end

function Julianna06()
    fallout.gsay_reply(257, 114)
    fallout.giq_option(0, 257, 115, Julianna07, 50)
    fallout.giq_option(0, 257, 116, Julianna08, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 99) then
        fallout.giq_option(0, 257, 117, Julianna09, 50)
    end
end

function Julianna07()
    fallout.gsay_message(257, 118, 50)
    fallout.add_timer_event(fallout.self_obj(), 1, 1)
end

function Julianna08()
    fallout.gsay_reply(257, 119)
    fallout.giq_option(4, 257, 120, JuliannaEnd, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 99) then
        fallout.giq_option(4, 257, 121, Julianna09, 50)
    end
end

function Julianna09()
    local v0 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 99)
    fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_carrying_pid_obj(fallout.dude_obj(), 99))
    fallout.add_obj_to_inven(fallout.self_obj(), v0)
    fallout.gsay_message(257, 122, 50)
    fallout.set_global_var(127, 2)
end

function Julianna10()
    fallout.gsay_message(257, 123, 50)
end

function JuliannaEnd()
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
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
