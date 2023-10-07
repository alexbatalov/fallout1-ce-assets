local fallout = require("fallout")

local start
local look_at_p_proc
local skills

local use_skill = 0
local temp = 0

function start()
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill = fallout.action_being_used()
            fallout.script_overrides()
            skills()
        else
            if fallout.script_action() == 6 then
                fallout.display_msg(fallout.message_str(725, 201))
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(725, 200))
end

function skills()
    if use_skill == 12 then
        fallout.display_msg(fallout.message_str(725, 203))
        if fallout.global_var(78) ~= 1 then
            fallout.set_global_var(78, 1)
            temp = 1250
            fallout.display_msg(fallout.message_str(725, 204) .. temp .. fallout.message_str(725, 205))
            fallout.give_exp_points(temp)
        end
    else
        if use_skill == 13 then
            fallout.display_msg(fallout.message_str(725, 202))
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
