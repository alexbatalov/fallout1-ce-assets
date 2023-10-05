local fallout = require("fallout")

local start
local critter_p_proc
local combat_p_proc
local timed_event_p_proc
local use_skill_on_p_proc
local flee_dude

local attacked = 0
local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 12)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 9)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 0)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 13 then
                combat_p_proc()
            else
                if fallout.script_action() == 22 then
                    timed_event_p_proc()
                else
                    if fallout.script_action() == 8 then
                        use_skill_on_p_proc()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile and (attacked == 0) then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.has_trait(0, fallout.dude_obj(), 44) == 0 then
                hostile = 1
            end
        end
        if attacked and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8) then
            flee_dude()
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        attacked = 1
    end
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 3)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 0)
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.combat_p_proc = combat_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
