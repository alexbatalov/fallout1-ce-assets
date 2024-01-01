local fallout = require("fallout")

local start

local initialized = false

function start()
    if not initialized then
        initialized = true
        fallout.set_external_var("Jake_Desk_Ptr", fallout.self_obj())
    end
end

local exports = {}
exports.start = start
return exports
