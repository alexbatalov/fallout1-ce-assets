local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local child01
local child02
local child03
local child04
local child05
local child06
local childend
local critter_p_proc
local talk_p_proc
local pickup_p_proc
local destroy_p_proc
local look_at_p_proc
local description_p_proc
local timed_event_p_proc

local initialized = false
local hostile = false
local Start_Moving = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 2)
        misc.set_ai(self_obj, 68)
        local item_obj = fallout.create_object_sid(19, 0, 0, -1)
        fallout.add_mult_objs_to_inven(self_obj, item_obj, fallout.random(8, 14))
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(self_obj))
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 3 or script_action == 21 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function child01()
    fallout.gsay_reply(237, 101)
    fallout.giq_option(4, 237, 102, childend, 50)
    fallout.giq_option(5, 237, 103, child02, 50)
    fallout.giq_option(-3, 237, 104, child03, 50)
end

function child02()
    fallout.gsay_message(237, 105, 50)
end

function child03()
    fallout.gsay_message(237, 106, 50)
end

function child04()
    fallout.gsay_reply(237, 107)
    fallout.giq_option(4, 237, 108, child05, 50)
    fallout.giq_option(4, 237, 109, child06, 50)
    fallout.giq_option(-3, 237, 110, child03, 50)
end

function child05()
    fallout.gsay_message(237, 111, 50)
end

function child06()
    fallout.gsay_message(237, 112, 50)
end

function childend()
end

function critter_p_proc()
    local game_time_hour = fallout.game_time_hour()
    if game_time_hour > 600 and game_time_hour < 1900 then
        fallout.set_local_var(0, 0)
        fallout.set_local_var(1, 1)
    else
        fallout.set_local_var(1, 0)
        fallout.set_local_var(0, 1)
    end

    local cur_map_index = fallout.cur_map_index()
    local self_obj = fallout.self_obj()
    if cur_map_index == 25 then
        if fallout.local_var(0) == 1 then
            if fallout.tile_num(self_obj) ~= 14950 then
                fallout.animate_move_obj_to_tile(self_obj, 14950, 0)
            else
                fallout.set_obj_visibility(self_obj, true)
            end
        else
            fallout.set_obj_visibility(self_obj, false)
            if fallout.random(0, 15) == 1 then
                local rotation = fallout.random(0, 5)
                local distance = fallout.random(3, 7)
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.local_var(3), rotation, distance), 1)
            end
        end
    elseif cur_map_index == 26 then
        if fallout.local_var(0) == 1 then
            if fallout.tile_num(self_obj) ~= 14950 then
                fallout.animate_move_obj_to_tile(self_obj, 22443, 0)
            else
                fallout.set_obj_visibility(self_obj, true)
            end
        else
            fallout.set_obj_visibility(self_obj, false)
            if fallout.random(0, 15) == 1 then
                local rotation = fallout.random(0, 5)
                local distance = fallout.random(3, 7)
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.local_var(3), rotation, distance), 1)
            end
        end
    else
        if fallout.random(0, 15) == 1 and Start_Moving == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 6)), 1)
        end
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function talk_p_proc()
    fallout.start_gdialog(237, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if misc.is_armed(fallout.dude_obj()) then
        child04()
    else
        child01()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function pickup_p_proc()
    hostile = true
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(158, fallout.global_var(158) + 1)
        fallout.set_global_var(155, fallout.global_var(155) - 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(237, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(237, 100))
end

function timed_event_p_proc()
    Start_Moving = 0
    local self_obj = fallout.self_obj()
    if fallout.obj_on_screen(self_obj) then
        local rotation = fallout.random(0, 5)
        local distance = fallout.random(3, 7)
        fallout.animate_move_obj_to_tile(self_obj,
            fallout.tile_num_in_direction(fallout.tile_num(self_obj), rotation, distance), 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.talk_p_proc = talk_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
