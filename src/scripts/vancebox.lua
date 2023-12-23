local fallout = require("fallout")

local start

local initialized = false

function start()
    if not initialized then
        fallout.set_external_var("Vance_Box_Ptr", fallout.self_obj())
        initialized = true
    end
end

local exports = {}
exports.start = start
return exports
