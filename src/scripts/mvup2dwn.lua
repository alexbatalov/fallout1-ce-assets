local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.load_map("master34.map", 2)
    end
end

local exports = {}
exports.start = start
return exports