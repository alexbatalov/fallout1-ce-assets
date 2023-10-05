local fallout = require("fallout")

local start

local Rads = 0

function start()
    if fallout.script_action() == 2 then
        Rads = fallout.random(20, 50)
        fallout.radiation_inc(fallout.dude_obj(), Rads)
    end
end

local exports = {}
exports.start = start
return exports
