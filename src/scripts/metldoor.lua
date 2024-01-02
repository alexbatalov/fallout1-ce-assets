local fallout = require("fallout")

local start
local damage_p_proc
local timed_event_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function damage_p_proc()
    local cur_map_index = fallout.cur_map_index()
    if cur_map_index == 14 or cur_map_index == 15 then
        fallout.set_global_var(250, 1)
    end
    fallout.set_local_var(0, fallout.local_var(0) + 1)
    if fallout.local_var(0) == 3 then
        fallout.destroy_object(fallout.self_obj())
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_open(self_obj) then
            fallout.use_obj(self_obj)
        end
    end
end

function use_p_proc()
    local cur_map_index = fallout.cur_map_index()
    if cur_map_index == 6 or cur_map_index == 14 or cur_map_index == 15 then
        local self_obj = fallout.self_obj()
        fallout.rm_timer_event(self_obj)
        fallout.add_timer_event(self_obj, fallout.game_ticks(3), 1)
    end
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_p_proc = use_p_proc
return exports
