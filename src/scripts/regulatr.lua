local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local timed_event_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            fallout.item_caps_adjust(self_obj, fallout.random(1, 10))
        end
        fallout.critter_add_trait(self_obj, 1, 6, 89)
        fallout.critter_add_trait(self_obj, 1, 5, 29)
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 3)), 1)
        if fallout.local_var(4) == 0 then
            fallout.set_map_var(1, fallout.map_var(1) + 1)
            fallout.set_local_var(4, 1)
        end
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(252, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(252, 100))
end

function talk_p_proc()
    if fallout.global_var(251) == 1 or fallout.global_var(616) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(252, fallout.random(134, 138)), 0)
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if fallout.global_var(251) == 1 or fallout.global_var(616) == 1 then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
    if time.game_time_in_seconds() - fallout.global_var(341) >= 5
        and fallout.tile_distance_objs(self_obj, dude_obj) <= 4
        and fallout.global_var(251) == 0
        and fallout.global_var(616) == 0 then
        fallout.float_msg(self_obj, fallout.message_str(252, fallout.random(134, 138)), 0)
        fallout.set_global_var(341, time.game_time_in_seconds())
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(616, 1)
    end
end

function destroy_p_proc()
    fallout.set_map_var(1, fallout.map_var(1) - 1)
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(616, 1)
        reputation.inc_evil_critter()
    end
    if fallout.map_var(1) == 0 then
        fallout.terminate_combat()
    end
end

function pickup_p_proc()
    fallout.set_global_var(616, 1)
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local rotation = fallout.random(0, 5)
    local distance = fallout.random(1, 5)
    fallout.animate_move_obj_to_tile(self_obj,
        fallout.tile_num_in_direction(fallout.tile_num(self_obj), rotation, distance), 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 3)), 1)
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
