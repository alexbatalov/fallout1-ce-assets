local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.add_timer_event(fallout.self_obj(), 2, 1)
        fallout.set_external_var("Use_Manhole_Bottom", 1)
    else
        if fallout.script_action() == 22 then
            fallout.move_to(fallout.dude_obj(), 28276, 1)
        end
    end
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.anim(fallout.source_obj(), 0, 0)
    end
end

local exports = {}
exports.start = start
return exports
