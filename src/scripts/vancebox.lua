local fallout = require("fallout")

local start

local OnceOnly = 1

function start()
    if OnceOnly then
        OnceOnly = 0
        fallout.set_external_var("Vance_Box_Ptr", fallout.self_obj())
    end
end

local exports = {}
exports.start = start
return exports
