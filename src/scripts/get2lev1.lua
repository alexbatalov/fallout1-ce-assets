local fallout = require("fallout")

local start
local spatial_p_proc

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.load_map("mbent.map", 1)
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
