local fallout = require("fallout")

local start
local pickup_p_proc
local use_skill_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function pickup_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(334, 101))
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if skill == 9 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -15)) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(334, 102))
        else
            fallout.display_msg(fallout.message_str(334, 103))
        end
    elseif skill == 12 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -5)) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(334, 104))
        else
            fallout.display_msg(fallout.message_str(334, 105))
        end
    else
        fallout.display_msg(fallout.message_str(334, 106))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(334, 100))
end

local exports = {}
exports.start = start
return exports
