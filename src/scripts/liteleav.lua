local fallout = require("fallout")
local time = require("lib.time")

local start
local map_enter_p_proc
local map_update_p_proc
local lighting

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        end
    end
end

function map_enter_p_proc()
    lighting()
end

function map_update_p_proc()
    lighting()
end

function lighting()
    if time.is_morning() then
        fallout.obj_set_light_level(fallout.self_obj(), fallout.game_time_hour() - 600 + 40, 8)
    else
        if time.is_evening() then
            fallout.obj_set_light_level(fallout.self_obj(), 100 - (fallout.game_time_hour() - 1800), 8)
        else
            if time.is_day() then
                fallout.obj_set_light_level(fallout.self_obj(), 100, 8)
            else
                fallout.obj_set_light_level(fallout.self_obj(), 40, 8)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
