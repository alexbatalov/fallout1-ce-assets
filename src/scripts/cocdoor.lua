local fallout = require("fallout")

local start
local use_p_proc

function start()
    if fallout.script_action() == 6 then
        fallout.debug_msg("in check for use_proc")
        use_p_proc()
    end
end

function use_p_proc()
    fallout.debug_msg("in use_p_proc")
    fallout.script_overrides()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.debug_msg("in check for dude")
        fallout.reg_anim_func(2, fallout.dude_obj())
        fallout.move_to(fallout.dude_obj(), 22499, 1)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
