local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local damage_p_proc
local destroy_p_proc
local map_enter_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local PeasantC00
local PeasantC00a
local PeasantC01
local PeasantC02
local PeasantC03
local PeasantC03a
local PeasantC04
local PeasantC05
local PeasantC06
local PeasantC07
local PeasantCEnd

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function map_enter_p_proc()
    if fallout.map_var(2) == 1 then
        fallout.set_obj_visibility(fallout.self_obj(), true)
        fallout.set_external_var("removal_ptr", fallout.self_obj())
    else
        sleep_time = fallout.random(2215, 2230)
        wake_time = fallout.random(715, 730)
        if time.game_time_in_days() < 80 then
            sleep_tile = 15275
            home_tile = 14267
        else
            sleep_tile = 23524
            home_tile = 23923
        end
    end
end

function map_update_p_proc()
    behaviour.sleeping(2, night_person, wake_time, sleep_time, home_tile, sleep_tile)
end

function pickup_p_proc()
    fallout.set_local_var(1, 1)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(438, 124), 2)
end

function talk_p_proc()
    if fallout.local_var(2) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    elseif fallout.local_var(1) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(438, 124), 2)
    elseif time.game_time_in_days() < 80 then
        fallout.set_local_var(0, 1)
        if fallout.global_var(247) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(438, 100), 2)
        elseif fallout.global_var(155) < -10 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(438, 101), 7)
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(438, fallout.random(102, 103)), 3)
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(438, fallout.random(102, 104)), 3)
            end
        end
    else
        fallout.set_map_var(2, 1)
        fallout.start_gdialog(438, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        PeasantC00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function PeasantC00()
    fallout.gsay_reply(438, 105)
    fallout.giq_option(4, 438, 106, PeasantCEnd, 50)
    fallout.giq_option(5, 438, 107, PeasantC00a, 50)
    fallout.giq_option(-3, 438, 108, PeasantC01, 50)
end

function PeasantC00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        PeasantC03()
    else
        PeasantC02()
    end
end

function PeasantC01()
    fallout.gsay_message(438, 109, 50)
end

function PeasantC02()
    fallout.gsay_message(438, 110, 50)
end

function PeasantC03()
    fallout.gsay_reply(438, 111)
    fallout.giq_option(5, 438, 112, PeasantC04, 51)
    fallout.giq_option(6, 438, 113, PeasantC03a, 50)
    fallout.giq_option(4, 438, 106, PeasantCEnd, 50)
end

function PeasantC03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        PeasantC06()
    else
        PeasantC05()
    end
end

function PeasantC04()
    fallout.set_local_var(1, 1)
    fallout.gsay_message(438, 114, 51)
end

function PeasantC05()
    fallout.gsay_message(438, 115, 50)
end

function PeasantC06()
    local msg = fallout.message_str(438, 116)
    if fallout.global_var(37) == 1 then
        if fallout.global_var(38) == 1 then
            msg = msg .. fallout.message_str(438, 120)
        else
            msg = msg .. fallout.message_str(438, 119)
        end
    else
        if fallout.global_var(38) == 1 then
            msg = msg .. fallout.message_str(438, 118)
        else
            msg = msg .. fallout.message_str(438, 117)
        end
    end
    fallout.gsay_reply(438, msg)
    fallout.giq_option(5, 438, 121, PeasantC07, 50)
    fallout.giq_option(5, 438, 122, PeasantCEnd, 50)
end

function PeasantC07()
    fallout.gsay_message(438, 123, 50)
end

function PeasantCEnd()
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
