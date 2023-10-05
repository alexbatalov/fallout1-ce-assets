local fallout = require("fallout")

local start
local spatial_p_proc

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    fallout.critter_dmg(fallout.source_obj(), fallout.random(10, 30), 4)
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
