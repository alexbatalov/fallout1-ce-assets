local fallout = require("fallout")

local start
local use_p_proc
local map_enter_p_proc
local look_at_p_proc
local timed_event_p_proc
local explode

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 22 then
        explode()
    elseif script_action == 6 then
        explode()
    end
end

function use_p_proc()
    explode()
end

function map_enter_p_proc()
    fallout.set_external_var("table_ptr", fallout.self_obj())
end

function look_at_p_proc()
end

function timed_event_p_proc()
    explode()
end

function explode()
    local self_obj = fallout.self_obj()
    local new_tile = fallout.tile_num_in_direction(fallout.tile_num(self_obj), 1, 1)
    fallout.explosion(new_tile, fallout.elevation(self_obj), 0)
    fallout.float_msg(self_obj, fallout.message_str(736, fallout.random(108, 115)), 8)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
