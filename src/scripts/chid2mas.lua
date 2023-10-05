local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.load_map("mstrlr12.map", 0)
    end
end

local exports = {}
exports.start = start
return exports
