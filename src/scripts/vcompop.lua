local fallout = require("fallout")

local start
local look_at_p_proc
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(214, 100))
    if fallout.global_var(101) == 2 then
        fallout.display_msg(fallout.message_str(214, 104))
    end
end

function use_skill_on_p_proc()
    fallout.script_overrides()
    if fallout.global_var(101) == 2 then
        fallout.display_msg(fallout.message_str(214, 104))
    else
        if fallout.action_being_used() == 13 then
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)) then
                fallout.display_msg(fallout.message_str(214, 101))
            else
                fallout.display_msg(fallout.message_str(214, 102))
            end
        else
            fallout.display_msg(fallout.message_str(214, 103))
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
