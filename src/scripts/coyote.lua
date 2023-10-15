local fallout = require("fallout")

local start
local use_skill_on_p_proc
local timed_event_p_proc

local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 21)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 8)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 30)), 0)
        initialized = true
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        else
            if fallout.script_action() == 22 then
                timed_event_p_proc()
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(1, 3)), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 30)), 0)
end

local exports = {}
exports.start = start
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
