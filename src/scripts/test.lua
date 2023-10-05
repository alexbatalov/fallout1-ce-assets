local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        fallout.critter_heal(fallout.dude_obj(), -100)
        fallout.display_msg("Hurt dude")
    end
end

local exports = {}
exports.start = start
return exports
