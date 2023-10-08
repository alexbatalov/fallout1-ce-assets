local fallout = require("fallout")
local light = require("lib.light")

local map_enter_p_proc
local start

function map_enter_p_proc()
    if fallout.metarule(14, 0) then
        fallout.override_map_start(107, 118, 0, 5)
        fallout.display_msg(fallout.message_str(112, 316))
    end
    light.lighting()
end

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            light.lighting()
        end
    end
end

local exports = {}
exports.map_enter_p_proc = map_enter_p_proc
exports.start = start
return exports
