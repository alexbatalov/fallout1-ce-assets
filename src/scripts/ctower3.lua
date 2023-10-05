local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.move_to(fallout.dude_obj(), 19294, 2)
    end
end

local exports = {}
exports.start = start
return exports
