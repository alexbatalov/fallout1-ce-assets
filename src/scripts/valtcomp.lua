local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        end
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(793, 100))
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        if fallout.elevation(fallout.self_obj()) == 0 then
            fallout.display_msg(fallout.message_str(793, 102))
        else
            fallout.display_msg(fallout.message_str(793, 101))
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
