local fallout = require("fallout")

local start
local spatial_p_proc
local use_p_proc
local timed_event_p_proc

local ready = true

function start()
    local script_action = fallout.script_action()
    if script_action == 2 then
        spatial_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function spatial_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ready then
            use_p_proc()
        end
    end
end

function use_p_proc()
    fallout.use_obj(fallout.external_var("J_Door_Ptr"))
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(4), 1)
end

function timed_event_p_proc()
    ready = true
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
exports.use_p_proc = use_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
