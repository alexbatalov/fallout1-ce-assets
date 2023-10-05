local fallout = require("fallout")

local start
local spatial_p_proc

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    if fallout.obj_type(fallout.source_obj()) == fallout.dude_obj() then
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, 1)
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 17, 0)) then
                fallout.display_msg(fallout.message_str(127, 100))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
