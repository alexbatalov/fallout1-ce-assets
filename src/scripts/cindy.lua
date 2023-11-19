local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Cindy01
local Cindy02
local Cindy03
local Cindy04
local Cindy05
local Cindy06
local Cindy07
local CindyEnd
local get_rations

local crying = 0
local hostile = 0
local ration_tile = 7000
local sleeping_disabled = 0

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0

local exit_line = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 14 then
            damage_p_proc()
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
                            if fallout.script_action() == 4 then
                                pickup_p_proc()
                            else
                                if fallout.script_action() == 11 then
                                    talk_p_proc()
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
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(6) == 1 then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
                behaviour.flee_dude(1)
            else
                if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), home_tile) > 3 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                end
            end
        else
            if fallout.global_var(101) == 0 then
                if fallout.local_var(7) == 0 then
                    if (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.external_var("WtrGrd_ptr"))) and (fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.dude_obj())) then
                        if (fallout.game_time_hour() > 700) and (fallout.game_time_hour() < 900) then
                            get_rations()
                        end
                    end
                end
            end
            if not time.is_day() then
                fallout.set_local_var(7, 0)
            end
            if sleeping_disabled == 0 then
                behaviour.sleeping(5, night_person, wake_time, sleep_time, home_tile, sleep_tile)
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(6, 1)
    end
end

function description_p_proc()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(168, 101))
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(168, 100))
end

function map_enter_p_proc()
    sleep_tile = 24883
    home_tile = 24687
    sleep_time = fallout.random(1900, 1930)
    wake_time = fallout.random(600, 630)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
end

function pickup_p_proc()
    if time.game_time_in_days() >= 30 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 122), 2)
    end
    hostile = 1
end

function talk_p_proc()
    if not(fallout.local_var(4)) then
        if (fallout.global_var(261) == 1) or (fallout.local_var(6) == 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 125), 0)
            fallout.set_local_var(4, 1)
        else
            if fallout.global_var(101) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 123), 0)
            else
                if fallout.global_var(188) == 2 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(168, 124), 0)
                else
                    fallout.start_gdialog(168, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Cindy01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
end

function Cindy01()
    fallout.gsay_reply(168, fallout.message_str(168, 102) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(168, 103))
    fallout.giq_option(4, 168, 104, Cindy03, 50)
    fallout.giq_option(4, 168, 105, Cindy04, 50)
    fallout.giq_option(-3, 168, 106, Cindy02, 50)
end

function Cindy02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(168, 107)
    fallout.giq_option(-3, 168, 108, CindyEnd, 50)
end

function Cindy03()
    fallout.gsay_message(168, fallout.random(109, 111), 50)
end

function Cindy04()
    if time.game_time_in_days() < 30 then
        fallout.gsay_reply(168, 126)
        fallout.giq_option(4, 168, 127, CindyEnd, 49)
        fallout.giq_option(4, 168, 128, CindyEnd, 51)
    else
        fallout.gsay_reply(168, 113)
        fallout.giq_option(4, 168, 114, Cindy05, 50)
        fallout.giq_option(4, 168, 115, Cindy06, 50)
    end
end

function Cindy05()
    fallout.gsay_reply(168, 116)
    fallout.giq_option(4, 168, 117, CindyEnd, 50)
end

function Cindy06()
    fallout.gsay_reply(168, 118)
    fallout.giq_option(4, 168, 119, Cindy07, 50)
end

function Cindy07()
    fallout.set_global_var(188, 1)
    fallout.gsay_reply(168, 120)
    fallout.giq_option(4, 168, 121, CindyEnd, 50)
    fallout.giq_option(4, 168, 112, Cindy05, 50)
end

function CindyEnd()
end

function get_rations()
    if fallout.tile_num(fallout.self_obj()) ~= ration_tile then
        sleeping_disabled = 1
        if fallout.random(0, 1) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), ration_tile, 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), ration_tile, 1)
        end
    else
        if not(fallout.external_var("recipient")) then
            fallout.set_external_var("recipient", fallout.self_obj())
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
            fallout.set_local_var(7, 1)
            sleeping_disabled = 0
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
