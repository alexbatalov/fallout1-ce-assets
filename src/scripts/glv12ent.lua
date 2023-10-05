local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 6) and (fallout.source_obj() == fallout.dude_obj()) then
        fallout.load_map("Glowent.map", 2)
    end
end

local exports = {}
exports.start = start
return exports
