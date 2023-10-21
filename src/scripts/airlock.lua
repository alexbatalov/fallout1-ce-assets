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
        if fallout.local_var(0) == 0 then
            if fallout.get_critter_stat(fallout.dude_obj(), 4) > 8 then
                fallout.display_msg(fallout.message_str(60, 100))
            end
            fallout.set_local_var(0, 1)
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
