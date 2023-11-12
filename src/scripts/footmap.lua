local fallout = require("fallout")
local light = require("lib.light")

local start
local map_enter_p_proc
local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function map_enter_p_proc()
    if fallout.metarule(14, 0) ~= 0 then
        fallout.display_msg(fallout.message_str(194, 116))
        fallout.override_map_start(125, 107, 0, 0)
    end
    light.lighting()
end

function map_update_p_proc()
    light.lighting()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
