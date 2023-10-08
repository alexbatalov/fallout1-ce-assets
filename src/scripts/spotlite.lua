local fallout = require("fallout")
local light = require("lib.light")
local time = require("lib.time")

local Start
local map_enter_p_proc
local map_update_p_proc
local Invasion

function Start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        end
    end
end

function map_enter_p_proc()
    if fallout.global_var(224) == 2 then
        fallout.set_light_level(100)
    else
        if fallout.global_var(224) == 1 then
            light.darkness()
        else
            fallout.set_light_level(1)
        end
    end
end

function map_update_p_proc()
    if fallout.global_var(224) == 2 then
        fallout.set_light_level(100)
    else
        if fallout.global_var(224) == 1 then
            light.darkness()
        else
            fallout.set_light_level(1)
        end
    end
end

function Invasion()
    if not(fallout.global_var(18) == 2) then
        if fallout.global_var(149) > time.game_time_in_days() then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(150) > time.game_time_in_days() then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(151) > time.game_time_in_days() then
            fallout.set_global_var(16, 1)
        end
        if fallout.global_var(152) > time.game_time_in_days() then
            fallout.set_global_var(15, 1)
        end
        if fallout.global_var(153) > time.game_time_in_days() then
            fallout.set_global_var(12, 1)
        end
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(148) > time.game_time_in_days() then
            fallout.set_global_var(7, 1)
        end
    end
end

local exports = {}
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
