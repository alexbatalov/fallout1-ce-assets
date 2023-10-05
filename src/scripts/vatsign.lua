local fallout = require("fallout")

local start
local description_p_proc

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(362, 100))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
return exports
