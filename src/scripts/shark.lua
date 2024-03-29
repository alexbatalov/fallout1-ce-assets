local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Shark01
local Shark01a
local Shark02
local Shark03
local Shark04
local Shark04a
local Shark04b
local Shark05
local Shark06
local Shark07
local Shark08
local SharkCombat
local SharkEnd

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local dest_tile = 7000
local hostile = false
local sleeping_disabled = false
local waypoint = 0

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
        if fallout.global_var(282) == 1 and fallout.local_var(6) == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 3)
            fallout.set_local_var(6, 1)
        else
            if fallout.global_var(555) ~= 2 then
                local self_obj = fallout.self_obj()
                if fallout.tile_num(self_obj) ~= dest_tile then
                    fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
                else
                    if waypoint == 1 then
                        waypoint = 0
                        dest_tile = 33519
                    end
                end
                if sleeping_disabled == 0 then
                    behaviour.sleeping(5, night_person, wake_time, sleep_time, home_tile, sleep_tile)
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() and fallout.map_var(0) == 1 then
        fallout.set_map_var(1, 1)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(387, 100))
    else
        fallout.display_msg(fallout.message_str(387, 101))
    end
end

function map_enter_p_proc()
    sleep_time = 2230
    wake_time = 1530
    home_tile = 20486
    sleep_tile = 7000
    local self_obj = fallout.self_obj()
    misc.set_team(self_obj, 14)
    misc.set_ai(self_obj, 58)
    if fallout.global_var(555) == 2 or fallout.global_var(282) == 1 then
        fallout.move_to(self_obj, 7000, 0)
        fallout.set_obj_visibility(self_obj, true)
        sleeping_disabled = true
        fallout.set_external_var("removal_ptr", self_obj)
    else
        dest_tile = home_tile
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(387, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        Shark01()
    else
        if fallout.local_var(1) < 2 then
            Shark08()
        else
            Shark06()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        waypoint = 1
        dest_tile = 26495
    elseif event == 2 then
        if fallout.external_var("Trish_ptr") ~= nil then
            fallout.attack(fallout.external_var("Trish_ptr"), 0, 1, 0, 0, 30000, 0, 0)
        end
    elseif event == 3 then
        local self_obj = fallout.self_obj()
        fallout.float_msg(self_obj, fallout.message_str(387, 126), 2)
        fallout.add_timer_event(self_obj, fallout.game_ticks(5), 1)
        sleeping_disabled = true
    end
end

function Shark01()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(387, 103)
    fallout.giq_option(4, 387, 104, SharkCombat, 51)
    fallout.giq_option(4, 387, 105, Shark02, 50)
    fallout.giq_option(4, 387, 106, Shark03, 50)
    fallout.giq_option(5, 387, 107, Shark01a, 49)
    fallout.giq_option(-3, 387, 108, Shark05, 50)
end

function Shark01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Shark04()
    else
        Shark03()
    end
end

function Shark02()
    fallout.gsay_message(387, 109, 51)
    SharkCombat()
end

function Shark03()
    local message = fallout.message_str(387, 110)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        message = message .. fallout.message_str(387, 111)
    else
        message = message .. fallout.message_str(387, 112)
    end
    fallout.gsay_reply(387, message)
    fallout.giq_option(4, 387, 113, SharkCombat, 50)
end

function Shark04()
    reaction.UpReactLevel()
    fallout.gsay_reply(387, 114)
    fallout.giq_option(4, 387, 115, timed_event_p_proc, 50)
    fallout.giq_option(4, 387, 116, Shark04b, 49)
    fallout.giq_option(4, 387, 117, Shark04a, 50)
    fallout.giq_option(4, 387, 118, SharkCombat, 51)
end

function Shark04a()
    if not fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        reaction.DownReactLevel()
    end
    Shark05()
end

function Shark04b()
    reaction.UpReactLevel()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 2)
end

function Shark05()
    fallout.gsay_message(387, 119, 50)
end

function Shark06()
    fallout.gsay_reply(387, 120)
    fallout.giq_option(4, 387, 121, Shark07, 50)
    fallout.giq_option(4, 387, 122, Shark03, 50)
    fallout.giq_option(-3, 387, 123, Shark05, 50)
end

function Shark07()
    fallout.gsay_message(387, 124, 50)
    SharkCombat()
end

function Shark08()
    fallout.gsay_message(387, 125, 50)
    SharkCombat()
end

function SharkCombat()
    hostile = true
end

function SharkEnd()
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
