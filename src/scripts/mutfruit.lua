local fallout = require("fallout")

local start
local use_obj_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_obj_on_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(239, 100))
    fallout.critter_heal(fallout.dude_obj(), fallout.random(1, 6))
    fallout.radiation_inc(fallout.dude_obj(), 10)
    fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.self_obj())
end

local exports = {}
exports.start = start
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
