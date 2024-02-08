local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(349, 100))
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) == 1 then
        fallout.display_msg(fallout.message_str(349, 101))
    else
        fallout.display_msg(fallout.message_str(349, 102))
        fallout.set_global_var(163, 1)
        fallout.set_local_var(0, 1)
        fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.self_obj())
        fallout.display_msg(fallout.message_str(766, 103) .. "100" .. fallout.message_str(766, 104))
        fallout.give_exp_points(100)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
