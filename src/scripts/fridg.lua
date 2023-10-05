local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.set_map_var(0, 1)
    end
end

local exports = {}
exports.start = start
return exports
