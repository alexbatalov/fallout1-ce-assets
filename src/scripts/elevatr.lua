local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.obj_type(fallout.source_obj()) ~= 1 then
            detach()
        end
        if fallout.local_var(0) == 0 then
            if fallout.tile_distance(fallout.self_obj(), fallout.source_obj()) < 3 then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(0, 100))
            end
        end
        fallout.script_overrides()
    end
    detach()
end

local exports = {}
exports.start = start
return exports
