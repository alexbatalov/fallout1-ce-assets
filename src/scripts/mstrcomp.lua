local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    fallout.display_msg(fallout.message_str(725, 201))
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    fallout.script_overrides()
    if skill == 12 then
        fallout.display_msg(fallout.message_str(725, 203))
        if fallout.global_var(78) ~= 1 then
            fallout.set_global_var(78, 1)
            local xp = 1250
            fallout.display_msg(fallout.message_str(725, 204) .. xp .. fallout.message_str(725, 205))
            fallout.give_exp_points(xp)
        end
    elseif skill == 13 then
        fallout.display_msg(fallout.message_str(725, 202))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(725, 200))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
