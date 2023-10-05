local fallout = require("fallout")

local start
local use_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.move_to(fallout.dude_obj(), 19278, 0)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
