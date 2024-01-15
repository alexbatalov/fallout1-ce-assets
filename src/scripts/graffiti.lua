local fallout = require("fallout")

local start
local spatial_p_proc

local once = false

function start()
    local script_action = fallout.script_action()
    if script_action == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if not once then
            once = true
            fallout.display_msg(fallout.message_str(91, 100))
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
