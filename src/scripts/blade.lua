local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local timed_event_p_proc
local pickup_p_proc

local Initialize = 1
local PsstTime = 0

local exit_line = 0

function Start()
    if Initialize then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(10, 100))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
        if fallout.local_var(4) == 0 then
            fallout.set_local_var(4, fallout.tile_num(fallout.self_obj()))
        end
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(279, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(279, 100))
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.global_var(613) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(279, fallout.random(101, 115)), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(279, fallout.random(101, 111)), 0)
        end
    end
end

function critter_p_proc()
    local v0 = 0
    v0 = fallout.global_var(345)
    if ((time.game_time_in_seconds() - v0) >= 10) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 4) and (fallout.global_var(253) == 0) then
        if fallout.global_var(613) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(279, fallout.random(101, 115)), 0)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(279, fallout.random(101, 111)), 0)
        end
        v0 = time.game_time_in_seconds()
        fallout.set_global_var(345, v0)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(253) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        reputation.inc_good_critter()
    end
end

function timed_event_p_proc()
    local v0 = 0
    v0 = fallout.tile_num_in_direction(fallout.local_var(4), fallout.random(0, 5), fallout.random(1, 5))
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
end

function pickup_p_proc()
    fallout.set_global_var(253, 1)
end

local exports = {}
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
