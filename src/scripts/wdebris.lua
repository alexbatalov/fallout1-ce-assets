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
        if fallout.map_var(3) == 0 then
            fallout.set_map_var(3, 1)
            fallout.set_map_var(4, fallout.map_var(4) + 1)
            if fallout.map_var(4) > 3 then
                fallout.display_msg(fallout.message_str(824, 104))
            else
                fallout.display_msg(fallout.message_str(824, 103))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
