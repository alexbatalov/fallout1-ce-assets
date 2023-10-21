local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Rebel01
local Rebel02
local Rebel03
local Rebel04
local Rebel05
local Rebel06
local Rebel07
local Rebel08
local Rebel09
local RebelEnd
local RebelCombat
local rebel_meeting
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local dest_tile = 0
local hostile = 0
local gword1 = 0
local gword2 = 0
local not_at_meeting = 1

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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (time.game_time_in_days() > fallout.map_var(5)) and (fallout.global_var(238) ~= 2) then
            fallout.destroy_object(fallout.self_obj())
        end
        if (fallout.game_time_hour() > 1700) and (fallout.game_time_hour() < 1710) then
            if fallout.global_var(238) ~= 2 then
                if not_at_meeting then
                    rebel_meeting()
                end
            else
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            end
        else
            sleeping()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(6, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    if fallout.global_var(238) ~= 2 then
        fallout.display_msg(fallout.message_str(379, 101))
    else
        fallout.display_msg(fallout.message_str(379, 100))
    end
end

function map_enter_p_proc()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(5)
    sleep_tile = home_tile
    sleep_time = fallout.random(1900, 1930)
    wake_time = fallout.random(700, 715)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(4) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        if fallout.local_var(6) ~= 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
        else
            if fallout.global_var(261) ~= 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(379, 139), 2)
            else
                if fallout.global_var(101) ~= 0 then
                    Rebel01()
                else
                    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                        Rebel02()
                    else
                        if fallout.local_var(1) >= 2 then
                            fallout.start_gdialog(379, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Rebel03()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            fallout.start_gdialog(379, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Rebel09()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        end
                    end
                end
            end
        end
    end
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
    not_at_meeting = 1
end

function Rebel01()
    local v0 = 0
    v0 = fallout.random(1, 5)
    if v0 == 1 then
        v0 = fallout.message_str(379, 105)
    else
        if v0 == 2 then
            v0 = fallout.message_str(379, 106)
        else
            if v0 == 3 then
                v0 = fallout.message_str(379, 107)
            else
                if v0 == 4 then
                    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                        v0 = fallout.message_str(379, 108)
                    else
                        v0 = fallout.message_str(379, 109)
                    end
                else
                    if v0 == 5 then
                        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                            v0 = fallout.message_str(379, 110)
                        else
                            v0 = fallout.message_str(379, 111)
                        end
                    end
                end
            end
        end
    end
    fallout.float_msg(fallout.self_obj(), v0, 0)
end

function Rebel02()
    local v0 = 0
    local v1 = 0
    reaction.DownReact()
    v1 = fallout.message_str(379, fallout.random(112, 115))
    fallout.float_msg(fallout.self_obj(), v1, 2)
end

function Rebel03()
    fallout.gsay_reply(379, 116)
    fallout.giq_option(4, 379, 117, Rebel04, 0)
    fallout.giq_option(4, 379, 118, Rebel05, 0)
    fallout.giq_option(-3, 379, 119, Rebel08, 0)
end

function Rebel04()
    fallout.gsay_reply(379, 120)
    fallout.giq_option(4, 379, 121, RebelEnd, 0)
end

function Rebel05()
    if fallout.global_var(238) ~= 2 then
        fallout.gsay_reply(379, 122)
        fallout.giq_option(4, 379, 123, Rebel06, 0)
        fallout.giq_option(4, 379, 124, Rebel07, 0)
    else
        fallout.gsay_reply(379, 125)
    end
    fallout.giq_option(4, 379, 126, RebelEnd, 0)
end

function Rebel06()
    fallout.gsay_reply(379, 127)
    fallout.giq_option(4, 379, 128, RebelEnd, 0)
    fallout.giq_option(4, 379, 129, RebelEnd, 0)
end

function Rebel07()
    fallout.gsay_reply(379, 130)
    fallout.giq_option(4, 379, 131, RebelEnd, 0)
    fallout.giq_option(4, 379, 132, Rebel06, 0)
end

function Rebel08()
    fallout.gsay_reply(379, 133)
    fallout.giq_option(-3, 379, 134, RebelEnd, 0)
end

function Rebel09()
    fallout.gsay_reply(379, 135)
    fallout.giq_option(4, 379, 136, RebelCombat, 0)
    fallout.giq_option(4, 379, 137, RebelEnd, 0)
    fallout.giq_option(-3, 379, 138, RebelEnd, 0)
end

function RebelEnd()
end

function RebelCombat()
    hostile = 1
end

function rebel_meeting()
    if dest_tile == 0 then
        dest_tile = fallout.tile_num_in_direction(18310, fallout.random(0, 5), 1)
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(240), 0)
    if fallout.tile_num(fallout.self_obj()) == dest_tile then
        not_at_meeting = 0
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
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
