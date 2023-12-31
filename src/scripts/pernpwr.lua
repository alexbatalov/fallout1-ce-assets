local fallout = require("fallout")

local start
local look_at_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.global_var(74) == 2 and fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
        fallout.display_msg(fallout.message_str(297, 100))
    else
        fallout.display_msg(fallout.message_str(297, 101))
    end
end

function use_skill_on_p_proc()
    fallout.script_overrides()
    if fallout.action_being_used() == 7 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 7, 0)) then
            fallout.display_msg(fallout.message_str(297, 102))
        else
            fallout.display_msg(fallout.message_str(297, 103))
        end
    else
        fallout.display_msg(fallout.message_str(297, 104))
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
