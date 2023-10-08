local fallout = require("fallout")
local light = require("lib.light")

local Start
local map_enter_p_proc
local map_update_p_proc

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

local exports = {}
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
