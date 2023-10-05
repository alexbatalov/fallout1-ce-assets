local fallout = require("fallout")

local start
local use_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    fallout.move_to(fallout.source_obj(), 17111, 1)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
