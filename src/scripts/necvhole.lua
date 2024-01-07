local fallout = require("fallout")

local start
local use_p_proc
local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.add_timer_event(fallout.self_obj(), 7, 1)
end

function timed_event_p_proc()
    fallout.load_map("vaultnec.map", 12)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
