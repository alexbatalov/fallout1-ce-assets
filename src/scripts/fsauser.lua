local fallout = require("fallout")
local light = require("lib.light")

local start

function start()
    if fallout.script_action() == 15 then
        light.lighting()
        if fallout.metarule(14, 0) then
            fallout.override_map_start(109, 121, 0, 5)
            fallout.display_msg(fallout.message_str(112, 314))
        end
    else
        if fallout.script_action() == 23 then
            light.lighting()
        end
    end
end

local exports = {}
exports.start = start
return exports
