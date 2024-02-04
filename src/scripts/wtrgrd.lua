local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local WtrGrd01
local WtrGrd02
local WtrGrd03
local WtrGrd04
local WtrGrd05
local WtrGrd06
local WtrGRd07
local WtrGRd08
local WtrGrd09
local WtrGrdEnd
local WtrGrdQuest

local asleep = false
local hostile = false
local on_rounds = false
local going_up = false
local going_down = false
local dest_tile = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
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
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.obj_is_carrying_obj_pid(dude_obj, 126) > 3 then
                if fallout.local_var(4) == 0 then
                    fallout.set_local_var(4, 1)
                    fallout.float_msg(self_obj, fallout.message_str(163, 116), 0)
                end
            end
        end
        if time.is_day() then
            if self_tile_num ~= dest_tile then
                fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
            end
        end
        if not time.is_day() then
            on_rounds = false
        end
        if fallout.game_time_hour() > 700 and fallout.game_time_hour() < 900 and not on_rounds then
            dest_tile = 21511
            on_rounds = true
            fallout.add_timer_event(self_obj, fallout.game_ticks(300), 1)
        end
        if not time.is_day() then
            if not asleep then
                if fallout.game_time_hour() > 1905 and fallout.game_time_hour() < 1915 then
                    fallout.animate_move_obj_to_tile(self_obj, 16912, 0)
                    if self_tile_num == 16912 then
                        fallout.move_to(self_obj, 7000, 2)
                        asleep = true
                    end
                else
                    fallout.move_to(self_obj, 7000, 2)
                    asleep = true
                end
            end
        else
            if fallout.game_time_hour() > 630 and asleep then
                fallout.move_to(self_obj, fallout.local_var(5), 2)
                asleep = false
            else
                if fallout.game_time_hour() > 620 and asleep then
                    if fallout.elevation(self_obj) ~= 2 then
                        fallout.move_to(self_obj, 16912, 2)
                    else
                        fallout.animate_move_obj_to_tile(self_obj, 16912, 0)
                    end
                    asleep = false
                end
            end
        end
        if fallout.external_var("getting_ration") ~= 0 then
            fallout.use_obj(fallout.external_var("recipient"))
            fallout.float_msg(self_obj, fallout.message_str(163, fallout.random(113, 114)), 3)
            fallout.set_external_var("getting_ration", 0)
        end
        if self_tile_num == 16912 and going_down then
            fallout.move_to(self_obj, 22104, 1)
            going_down = false
        elseif self_tile_num == 22104 then
            if going_down then
                fallout.move_to(self_obj, 13704, 0)
                going_down = false
            elseif going_up then
                fallout.move_to(self_obj, 16912, 2)
                going_up = false
            end
        elseif self_tile_num == 13704 and going_up then
            fallout.move_to(self_obj, 22104, 1)
            going_up = false
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(163, 100))
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, fallout.tile_num(self_obj))
    end
    dest_tile = fallout.local_var(5)
    fallout.set_external_var("WtrGrd_ptr", self_obj)
    fallout.set_external_var("recipient", nil)
    if not time.is_day() then
        fallout.move_to(self_obj, 7000, 2)
        asleep = true
    end
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(163, 115), 0)
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(261) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 102), 2)
    elseif fallout.global_var(101) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 109), 0)
    elseif fallout.global_var(188) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(507, 113), 0)
    else
        fallout.start_gdialog(163, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if time.game_time_in_days() < 30 then
            WtrGrd05()
        else
            WtrGrd01()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function timed_event_p_proc()
    if fallout.game_time_hour() > 700 and fallout.game_time_hour() < 900 then
        local event = fallout.fixed_param()
        if event == 1 then
            dest_tile = 16912
            going_down = true
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 2)
        elseif event == 2 then
            dest_tile = 20910
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(120), 3)
        elseif event == 3 then
            dest_tile = 22104
            going_down = true
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 4)
        elseif event == 4 then
            dest_tile = 14102
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(120), 5)
        elseif event == 5 then
            dest_tile = 13704
            going_up = true
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 6)
        elseif event == 6 then
            going_up = true
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60), 7)
        elseif event == 7 then
            dest_tile = fallout.local_var(5)
        end
    else
        fallout.move_to(fallout.self_obj(), 16912, 2)
    end
end

function WtrGrd01()
    fallout.gsay_reply(163,
        fallout.message_str(163, 101) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(163, 102))
    fallout.giq_option(4, 163, 103, WtrGrd03, 50)
    fallout.giq_option(4, 163, 127, WtrGrd09, 50)
    fallout.giq_option(-3, 163, 104, WtrGrd02, 50)
end

function WtrGrd02()
    fallout.gsay_reply(163, 105)
    fallout.giq_option(-3, 163, 106, WtrGrd03, 50)
end

function WtrGrd03()
    fallout.gsay_reply(163, 107)
    fallout.giq_option(4, 163, 108, WtrGrd04, 50)
    fallout.giq_option(4, 163, 127, WtrGrd09, 50)
    fallout.giq_option(-3, 163, 109, WtrGrdEnd, 50)
end

function WtrGrd04()
    fallout.gsay_reply(163, 110)
    fallout.giq_option(4, 163, 111, WtrGrdQuest, 50)
    fallout.giq_option(4, 163, 112, WtrGrdEnd, 50)
end

function WtrGrd05()
    fallout.gsay_reply(163,
        fallout.message_str(163, 118) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(163, 119))
    fallout.giq_option(4, 163, 120, WtrGrd06, 50)
    fallout.giq_option(6, 163, 121, WtrGRd07, 50)
    fallout.giq_option(4, 163, 127, WtrGrd09, 50)
    fallout.giq_option(-3, 163, 104, WtrGrd02, 50)
end

function WtrGrd06()
    fallout.gsay_reply(163, 122)
    fallout.giq_option(4, 163, 121, WtrGRd07, 50)
    fallout.giq_option(4, 634, 105, WtrGrdEnd, 50)
end

function WtrGRd07()
    fallout.gsay_reply(163, 123)
    fallout.giq_option(4, 163, 124, WtrGRd08, 50)
end

function WtrGRd08()
    fallout.gsay_message(163, 125, 50)
end

function WtrGrd09()
    fallout.gsay_message(163, 126, 50)
end

function WtrGrdEnd()
end

function WtrGrdQuest()
    if fallout.global_var(188) == 0 then
        fallout.set_global_var(188, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
