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
        if fallout.global_var(139) == 2 and fallout.global_var(140) ~= 0 then
            if fallout.local_var(0) == 0 then
                if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
                    fallout.display_msg(fallout.message_str(332, 100))
                end
            end
            fallout.set_local_var(0, 1)
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
