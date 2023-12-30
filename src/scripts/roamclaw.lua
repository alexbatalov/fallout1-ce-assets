local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local timed_event_p_proc

local initialized = false

function start()
    if not initialized then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
        initialized = true
    end
end

function destroy_p_proc()
    fallout.set_map_var(1, fallout.map_var(1) - 1)
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local rotation = fallout.random(0, 5)
    local distance = fallout.random(1, 5)
    fallout.animate_move_obj_to_tile(self_obj,
        fallout.tile_num_in_direction(fallout.tile_num(self_obj), rotation, distance), 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(3, 5)), 1)
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.tile_distance_objs(fallout.self_obj(), dude_obj) <= 8 then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.critter_p_proc = critter_p_proc
return exports
