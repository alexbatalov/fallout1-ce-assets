local fallout = require("fallout")

local start
local critter_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local destroy_p_proc
local Victor01
local Victor02
local Victor03
local Victor04
local Victor05
local Victor06
local Victor07
local VictorEnd
local VictorCombat
local VictorDies
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 21 then
            look_at_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(555) ~= 2 then
        sleeping()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(386, 100))
    else
        fallout.display_msg(fallout.message_str(386, 101))
    end
end

function map_enter_p_proc()
    home_tile = 13907
    sleep_tile = 13097
    sleep_time = 2203
    wake_time = 707
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 14)
    if fallout.global_var(555) == 2 then
        fallout.destroy_object(fallout.self_obj())
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.local_var(5) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(386, 116), 0)
    else
        fallout.start_gdialog(386, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(4) then
            Victor06()
        else
            Victor01()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function timed_event_p_proc()
    if fallout.obj_can_hear_obj(fallout.dude_obj(), fallout.self_obj()) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(386, 102), 5)
    end
    fallout.critter_dmg(fallout.self_obj(), 250, 0)
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
end

function Victor01()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(386, 103)
    fallout.giq_option(4, 386, 104, Victor02, 50)
    fallout.giq_option(4, 386, 105, Victor03, 50)
    fallout.giq_option(-3, 386, 106, Victor07, 50)
end

function Victor02()
    fallout.gsay_message(386, 107, 50)
    VictorCombat()
end

function Victor03()
    fallout.gsay_reply(386, 108)
    fallout.giq_option(4, 386, 109, Victor04, 50)
    fallout.giq_option(4, 386, 110, Victor02, 50)
    fallout.giq_option(6, 386, 111, Victor05, 50)
end

function Victor04()
    fallout.gsay_message(386, 112, 50)
    VictorCombat()
end

function Victor05()
    fallout.gsay_message(386, 113, 50)
end

function Victor06()
    fallout.gsay_reply(386, 114)
    fallout.giq_option(4, 386, 117, Victor04, 50)
    fallout.giq_option(4, 386, 118, VictorEnd, 50)
end

function Victor07()
    fallout.gsay_message(386, 115, 50)
    VictorDies()
end

function VictorEnd()
end

function VictorCombat()
    hostile = 1
end

function VictorDies()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
end

function sleeping()
    if fallout.local_var(5) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(5, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(5, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(5, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(5, 1)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
