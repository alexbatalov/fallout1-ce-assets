local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 7 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(239, 100))
        fallout.critter_heal(fallout.dude_obj(), fallout.random(1, 6))
        fallout.radiation_inc(fallout.dude_obj(), 10)
        fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.self_obj())
    end
end

local exports = {}
exports.start = start
return exports
