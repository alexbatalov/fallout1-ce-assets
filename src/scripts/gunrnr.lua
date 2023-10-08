local fallout = require("fallout")
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
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(2, 20))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 48)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 28)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(10, 116))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(10, 116))
end

function talk_p_proc()
    if fallout.global_var(617) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(10, fallout.random(100, 115)), 0)
    end
end

function critter_p_proc()
    local v0 = 0
    v0 = fallout.global_var(342)
    if ((time.game_time_in_seconds() - v0) >= 10) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 4) and (fallout.global_var(617) == 0) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(10, fallout.random(100, 115)), 0)
        v0 = time.game_time_in_seconds()
        fallout.set_global_var(342, v0)
    end
    if fallout.global_var(265) == 2 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 3)), 1)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(617) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(617, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(617, 1)
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(159, fallout.global_var(159) + 1)
            if (fallout.global_var(159) % 2) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) - 1)
            end
        end
    end
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 5)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 3)), 1)
end

function pickup_p_proc()
    fallout.set_global_var(617, 1)
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
