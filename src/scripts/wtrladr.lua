local fallout = require("fallout")

local start
local use_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    fallout.move_to(fallout.source_obj(), 19057, 1)
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.anim(fallout.source_obj(), 0, 0)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
