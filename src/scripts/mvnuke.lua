local fallout = require("fallout")

local start
local use_skill_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_skill_on_p_proc()
    fallout.set_map_var(5, 1)
    local skill = fallout.action_being_used()
    fallout.script_overrides()
    if skill == 12 then
        fallout.display_msg(fallout.message_str(449, 108))
    elseif skill == 13 then
        fallout.display_msg(fallout.message_str(449, 109))
    elseif skill == 9 then
        fallout.display_msg(fallout.message_str(449, 110))
    elseif skill == 11 then
        fallout.display_msg(fallout.message_str(449, 111))
    else
        fallout.display_msg(fallout.message_str(449, 105))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(449, 100))
end

local exports = {}
exports.start = start
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
