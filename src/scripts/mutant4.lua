local fallout = require("fallout")

local times = 0

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(13) == 0 then
        fallout.set_obj_visibility(self_obj, true)
    else
        if fallout.tile_num(self_obj) ~= 16929 and times == 0 then
            times = 1
            fallout.animate_move_obj_to_tile(self_obj, 16929, 0)
            fallout.add_timer_event(self_obj, fallout.game_ticks(60), 1)
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(35, fallout.global_var(35) + 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(0, 100))
end

function timed_event_p_proc()
    local self_obj = fallout.self_obj()
    local event = fallout.fixed_param()
    if event == 1 then
        fallout.animate_move_obj_to_tile(self_obj, 10917, 0)
        fallout.add_timer_event(self_obj, fallout.game_ticks(60), 2)
    elseif event == 2 then
        fallout.animate_move_obj_to_tile(self_obj, 16929, 0)
        fallout.add_timer_event(self_obj, fallout.game_ticks(60), 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
