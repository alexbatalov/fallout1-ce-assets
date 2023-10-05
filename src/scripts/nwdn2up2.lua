local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.move_to(fallout.dude_obj(), 22531, 1)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.anim(fallout.source_obj(), 0, 0)
    end
end

local exports = {}
exports.start = start
return exports
