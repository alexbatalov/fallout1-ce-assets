local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    end
end

function use_p_proc()
    fallout.display_msg(fallout.message_str(766, 187))
    if fallout.local_var(0) ~= 0 then
        fallout.set_local_var(0, 0)
        fallout.set_map_var(7, 0)
    else
        fallout.set_local_var(0, 1)
        if fallout.local_var(1) == 0 then
            fallout.set_local_var(1, 1)
            local xp = 2000
            fallout.display_msg(fallout.message_str(682, 301) .. xp .. fallout.message_str(682, 302))
            fallout.give_exp_points(xp)
        end
        fallout.set_map_var(7, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
