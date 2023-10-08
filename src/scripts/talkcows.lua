local fallout = require("fallout")
local light = require("lib.light")

local start
local map_enter_p_proc
local map_update_p_proc

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
    light.lighting()
    if fallout.metarule(14, 0) then
        fallout.override_map_start(111, 96, 0, 5)
        fallout.display_msg(fallout.message_str(112, 318))
    end
end

function map_update_p_proc()
    light.lighting()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
