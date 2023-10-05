local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.move_to(fallout.dude_obj(), 23102, 1)
        fallout.script_overrides()
    end
end

local exports = {}
exports.start = start
return exports
