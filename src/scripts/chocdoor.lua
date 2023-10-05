local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        if fallout.source_obj() == fallout.dude_obj() then
            fallout.reg_anim_func(2, fallout.dude_obj())
            fallout.move_to(fallout.dude_obj(), 19701, 0)
        end
    end
end

local exports = {}
exports.start = start
return exports
