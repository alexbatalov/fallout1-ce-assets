local fallout = require("fallout")

local start
local critter_p_proc
local timed_event_p_proc

local hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 13)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 8)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 0)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 22 then
                timed_event_p_proc()
            end
        end
    end
end

function critter_p_proc()
    if hostile or (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) <= 2) then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 4)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
