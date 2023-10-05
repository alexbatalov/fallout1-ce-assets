local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.move_to(fallout.dude_obj(), 19101, 0)
    end
end

local exports = {}
exports.start = start
return exports
