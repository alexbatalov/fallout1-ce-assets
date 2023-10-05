local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            fallout.load_map("ShadyW.map", 2)
        end
    end
end

local exports = {}
exports.start = start
return exports
