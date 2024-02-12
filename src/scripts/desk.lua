local fallout = require("fallout")

local start
local pickup_p_proc

function start()
    if fallout.script_action() == 4 then
        pickup_p_proc()
    end
end

function pickup_p_proc()
    fallout.display_msg(fallout.message_str(25, 100))
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
return exports
