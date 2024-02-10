local fallout = require("fallout")
local misc = require("lib.misc")

local start
local use_skill_on_p_proc
local timed_event_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 21)
        misc.set_ai(self_obj, 8)
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(3, 30)), 0)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local rotation = fallout.random(0, 5)
    local distance = fallout.random(1, 3)
    fallout.animate_move_obj_to_tile(self_obj,
        fallout.tile_num_in_direction(fallout.tile_num(self_obj), rotation, distance), 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(3, 30)), 0)
end

local exports = {}
exports.start = start
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
