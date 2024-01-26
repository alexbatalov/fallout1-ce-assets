local fallout = require("fallout")
local light = require("lib.light")
local misc = require("lib.misc")

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
    if misc.map_first_run() then
        fallout.override_map_start(107, 118, 0, 5)
        fallout.display_msg(fallout.message_str(112, 316))
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
