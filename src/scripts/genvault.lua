local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reaction = require("lib.reaction")
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
local Vault00
local Vault00a
local Vault00b
local Vault00c
local Vault01
local Vault02
local Vault03
local Vault04
local Vault05
local Vault06
local Vault07
local Vault08
local Vault09
local Vault10
local Vault11
local get_rations
local set_ration_tile
local set_sleep_tile
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local gword1 = 0
local gword2 = 0
local PICK = 0
local hostile = 0
local sleeping_disabled = 0
local ration_tile = 0

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
        if fallout.local_var(7) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) then
            behaviour.flee_dude(1)
        end
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
            sleeping_disabled = 0
            fallout.set_local_var(5, 0)
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
    if fallout.local_var(4) == 0 then
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
    reaction.get_reaction()
    if fallout.local_var(6) ~= 0 then
        if fallout.random(0, 1) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
        else
            fallout.display_msg(fallout.message_str(185, 167))
        end
    else
        if fallout.local_var(7) or fallout.global_var(261) then
            Vault00()
        else
            if (fallout.global_var(101) ~= 0) and (fallout.global_var(101) ~= 1) then
                Vault01()
            else
                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                    Vault02()
                else
                    if fallout.global_var(10) < 80 then
                        Vault00b()
                    else
                        if fallout.global_var(10) < 40 then
                            Vault00c()
                        else
                            Vault00a()
                        end
                    end
                end
            end
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

function Vault00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(101, 104)), 0)
end

function Vault00a()
    if fallout.local_var(1) == 3 then
        Vault03()
    else
        if fallout.local_var(1) == 2 then
            Vault06()
        else
            Vault09()
        end
    end
end

function Vault00b()
    if fallout.local_var(1) == 3 then
        Vault04()
    else
        if fallout.local_var(1) == 2 then
            Vault07()
        else
            Vault10()
        end
    end
end

function Vault00c()
    if fallout.local_var(1) == 3 then
        Vault05()
    else
        if fallout.local_var(1) == 2 then
            Vault08()
        else
            Vault11()
        end
    end
end

function Vault01()
    PICK = fallout.random(1, 5)
    if PICK == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 109), 0)
    else
        if PICK == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 110), 0)
        else
            if PICK == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 111), 0)
            else
                if PICK == 4 then
                    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 112), 0)
                    else
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 113), 0)
                    end
                else
                    if PICK == 5 then
                        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 114), 0)
                        else
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 115), 0)
                        end
                    end
                end
            end
        end
    end
end

function Vault02()
    reaction.DownReact()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(116, 119)), 0)
end

function Vault03()
    PICK = fallout.random(1, 4)
    if PICK == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 120), 0)
    else
        if PICK == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 121), 0)
        else
            if PICK == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 122), 0)
            else
                if PICK == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 123) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(0, 124), 0)
                end
            end
        end
    end
end

function Vault04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(125, 128)), 0)
end

function Vault05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(129, 133)), 0)
end

function Vault06()
    PICK = fallout.random(1, 5)
    if PICK == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 134), 0)
    else
        if PICK == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 135) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(185, 136), 0)
        else
            if PICK == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 137), 0)
            else
                if PICK == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 138), 0)
                else
                    if PICK == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 139), 0)
                    end
                end
            end
        end
    end
end

function Vault07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(140, 144)), 0)
end

function Vault08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(185, fallout.random(145, 149)), 0)
end

function Vault09()
    PICK = fallout.random(1, 5)
    if PICK == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 150) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(185, 151), 0)
    else
        if PICK >= 4 then
            fallout.display_msg(fallout.message_str(185, 150 + PICK))
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 150 + PICK), 0)
        end
    end
end

function Vault10()
    PICK = fallout.random(1, 5)
    if PICK == 5 then
        fallout.display_msg(fallout.message_str(185, 160))
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 155 + PICK), 0)
    end
end

function Vault11()
    PICK = fallout.random(1, 5)
    if PICK == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 161), 0)
    else
        if PICK == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 162), 0)
        else
            if PICK == 3 then
                fallout.display_msg(fallout.message_str(185, 163))
            else
                if PICK == 4 then
                    fallout.display_msg(fallout.message_str(185, 164))
                end
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
