local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")

local start
local critter_p_proc
local combat_p_proc
local timed_event_p_proc
local use_skill_on_p_proc

local attacked = false
local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_ai(self_obj, 12)
        misc.set_team(self_obj, 9)
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 5)), 0)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if hostile and not attacked then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_obj = fallout.self_obj()
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.has_trait(0, dude_obj, 44) == 0 then
                hostile = true
            end
        end
        if attacked and fallout.tile_distance_objs(self_obj, dude_obj) < 8 then
            behaviour.flee_dude(1)
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        attacked = true
    end
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local rotation = fallout.random(0, 5)
    local distance = fallout.random(1, 5)
    local self_tile_num = fallout.tile_num(self_obj)
    fallout.animate_move_obj_to_tile(self_obj, fallout.tile_num_in_direction(self_tile_num, rotation, distance), 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 5)), 0)
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.combat_p_proc = combat_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
