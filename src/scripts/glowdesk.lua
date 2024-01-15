local fallout = require("fallout")

local start
local pickup_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 4 then
        pickup_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function pickup_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(331, 100))
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(331, 101))
        else
            fallout.display_msg(fallout.message_str(331, 102))
        end
    else
        fallout.display_msg(fallout.message_str(331, 103))
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
