local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(21, 100))
    end
end

local exports = {}
exports.start = start
return exports
