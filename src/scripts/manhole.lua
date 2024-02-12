local fallout = require("fallout")

local start
local use_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.map_var(fallout.local_var(0)) ~= 0 then
        fallout.move_to(fallout.dude_obj(), fallout.local_var(1), fallout.local_var(2))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
