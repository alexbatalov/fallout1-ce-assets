local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
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

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local dest_tile = 0
local hostile = false
local not_at_meeting = true

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if time.game_time_in_days() > fallout.map_var(5) and fallout.global_var(238) ~= 2 then
            fallout.destroy_object(fallout.self_obj())
        end
        if fallout.game_time_hour() > 1700 and fallout.game_time_hour() < 1710 then
            if fallout.global_var(238) ~= 2 then
                if not_at_meeting then
                    rebel_meeting()
                end
            else
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            end
        else
            behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
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
    misc.set_team(fallout.self_obj(), 87)
end

function pickup_p_proc()
    hostile = true
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
                    if misc.is_armed(fallout.dude_obj()) then
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
    not_at_meeting = true
end

function Rebel01()
    local rnd = fallout.random(1, 5)
    local msg
    if rnd == 1 then
        msg = fallout.message_str(379, 105)
    elseif rnd == 2 then
        msg = fallout.message_str(379, 106)
    elseif rnd == 3 then
        msg = fallout.message_str(379, 107)
    elseif rnd == 4 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            msg = fallout.message_str(379, 108)
        else
            msg = fallout.message_str(379, 109)
        end
    elseif rnd == 5 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            msg = fallout.message_str(379, 110)
        else
            msg = fallout.message_str(379, 111)
        end
    end
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function Rebel02()
    reaction.DownReact()
    local msg = fallout.message_str(379, fallout.random(112, 115))
    fallout.float_msg(fallout.self_obj(), msg, 2)
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
    hostile = true
end

function rebel_meeting()
    if dest_tile == 0 then
        dest_tile = fallout.tile_num_in_direction(18310, fallout.random(0, 5), 1)
    end
    local self_obj = fallout.self_obj()
    fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(240), 0)
    if fallout.tile_num(self_obj) == dest_tile then
        not_at_meeting = false
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
