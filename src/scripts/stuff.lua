local fallout = require("fallout")

local start
local pickup_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local timed_event_p_proc
local anger

function start()
    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    end
end

function pickup_p_proc()
    anger()
end

function use_p_proc()
    anger()
end

function use_obj_on_p_proc()
    anger()
end

function use_skill_on_p_proc()
    anger()
end

function timed_event_p_proc()
    fallout.set_map_var(5, 0)
end

function anger()
    fallout.set_map_var(5, 1)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 0)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
