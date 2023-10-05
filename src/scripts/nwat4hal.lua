local fallout = require("fallout")

local start

local HEREBEFORE = 0

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if HEREBEFORE == 0 then
                fallout.load_map("hallded.map", 6)
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
