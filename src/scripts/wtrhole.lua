local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.add_timer_event(fallout.self_obj(), 7, 1)
    else
        if fallout.script_action() == 22 then
            fallout.move_to(fallout.dude_obj(), 19653, 0)
        end
    end
end

local exports = {}
exports.start = start
return exports
