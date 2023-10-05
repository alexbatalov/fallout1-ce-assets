local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 7 then
        fallout.scr_return(fallout.critter_heal(fallout.source_obj(), 5))
    end
end

local exports = {}
exports.start = start
return exports
