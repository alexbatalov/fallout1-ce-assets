local fallout = require("fallout")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local timed_event_p_proc

local initialized = false
local hostile = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 12)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 9)
        initialized = true
        if time.is_night() then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(30, 40)), 0)
        end
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
            else
                if fallout.script_action() == 22 then
                    timed_event_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if not time.is_night() and not(hostile) then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.has_trait(0, fallout.dude_obj(), 44) == 0 then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                hostile = 1
            end
        end
    end
    if not(hostile) then
        fallout.script_overrides()
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(3, 4), 4), 1)
    end
end

function damage_p_proc()
    fallout.attack(fallout.self_obj(), 0, 1, 0, 0, 30000, 0, 0)
end

function timed_event_p_proc()
    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    hostile = 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
