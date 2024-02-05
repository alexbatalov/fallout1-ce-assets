local fallout = require("fallout")
local misc = require("lib.misc")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local timed_event_p_proc

local initialized = false
local hostile = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_ai(self_obj, 12)
        misc.set_team(self_obj, 9)
        if time.is_night() then
            fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(30, 40)), 0)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if not time.is_night() and not hostile then
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.has_trait(0, dude_obj, 44) == 0 then
                fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
                hostile = true
            end
        end
    end
    if not hostile then
        fallout.script_overrides()
        local self_tile_num = fallout.tile_num(self_obj)
        -- FIXME: Odd rotation (it's usually any direction) and fixed distance.
        local rotation = fallout.random(3, 4)
        fallout.animate_move_obj_to_tile(self_obj, fallout.tile_num_in_direction(self_tile_num, rotation, 4), 1)
    end
end

function damage_p_proc()
    fallout.attack(fallout.self_obj(), 0, 1, 0, 0, 30000, 0, 0)
end

function timed_event_p_proc()
    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
