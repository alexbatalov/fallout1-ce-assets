local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.add_timer_event(fallout.self_obj(), 2, 1)
        fallout.set_external_var("Use_Manhole_Middle", 1)
    else
        if fallout.script_action() == 22 then
            fallout.move_to(fallout.dude_obj(), 19139, 0)
        end
    end
end

local exports = {}
exports.start = start
return exports
