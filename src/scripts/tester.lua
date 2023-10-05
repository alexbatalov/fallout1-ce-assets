local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        fallout.critter_dmg(fallout.dude_obj(), 1, 0)
        fallout.display_msg("Hurt dude")
    end
end

local exports = {}
exports.start = start
return exports
