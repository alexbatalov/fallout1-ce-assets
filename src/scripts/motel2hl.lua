local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        fallout.load_map(3, 13)
    end
end

local exports = {}
exports.start = start
return exports
