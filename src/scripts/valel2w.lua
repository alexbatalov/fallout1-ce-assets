local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.add_timer_event(fallout.self_obj(), 8, 1)
    end
    if fallout.script_action() == 22 then
        fallout.move_to(fallout.dude_obj(), 13104, 0)
    end
end

local exports = {}
exports.start = start
return exports
