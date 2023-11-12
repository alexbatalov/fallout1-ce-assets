local fallout = require("fallout")

local start
local use_obj_on_p_proc
local look_at_p_proc
local timed_event_p_proc

local lit = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function use_obj_on_p_proc()
    fallout.scr_return(0)
    if lit ~= 1 and lit ~= 2 then
        local self_obj = fallout.self_obj()
        fallout.obj_set_light_level(self_obj, 100, 7)
        fallout.display_msg(fallout.message_str(223, 100))
        lit = 1
        fallout.add_timer_event(self_obj, fallout.game_ticks(1800 * 3), 1)
    else
        fallout.display_msg(fallout.message_str(223, 101))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if lit == 1 then
        fallout.display_msg(fallout.message_str(223, 103))
    elseif lit == 2 then
        fallout.display_msg(fallout.message_str(223, 104))
    else
        fallout.display_msg(fallout.message_str(223, 105))
    end
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local event = fallout.fixed_param()
    if event == 1 then
        fallout.obj_set_light_level(self_obj, 80, 7)
        fallout.add_timer_event(self_obj, fallout.game_ticks(900 * 3), 2)
    elseif event == 2 then
        fallout.obj_set_light_level(self_obj, 60, 7)
        fallout.add_timer_event(self_obj, fallout.game_ticks(450 * 3), 3)
    elseif event == 3 then
        fallout.obj_set_light_level(self_obj, 0, 1)
        lit = 2
        fallout.display_msg(fallout.message_str(223, 102))
    end
end

local exports = {}
exports.start = start
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
