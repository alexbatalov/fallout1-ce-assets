local fallout = require("fallout")

local Start
local destroy_p_proc
local timed_event_p_proc

local Initialize = 1

local exit_line = 0

local critter_p_proc

function Start()
    if Initialize then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
        Initialize = 0
    end
end

function destroy_p_proc()
    fallout.set_map_var(1, fallout.map_var(1) - 1)
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 5)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
end

function critter_p_proc()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 8 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.critter_p_proc = critter_p_proc
return exports
