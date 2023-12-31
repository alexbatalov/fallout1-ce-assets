local fallout = require("fallout")

local start
local spatial_p_proc

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    if fallout.map_var(7) == 1 then
        fallout.display_msg(fallout.message_str(610, 100))
        fallout.float_msg(fallout.dude_obj(), fallout.message_str(610, 101), 7)
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
