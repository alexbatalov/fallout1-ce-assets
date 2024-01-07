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
    fallout.add_timer_event(fallout.self_obj(), 2, 1)
    fallout.set_external_var("Use_Manhole_Top", 1)
end

function timed_event_p_proc()
    fallout.move_to(fallout.dude_obj(), 15499, 0)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
