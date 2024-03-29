local fallout = require("fallout")

local start
local spatial_p_proc

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    fallout.radiation_inc(fallout.dude_obj(), fallout.random(20, 50))
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
