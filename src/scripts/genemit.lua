local fallout = require("fallout")

local start
local look_at_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 3 then
            look_at_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(766, 200))
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(766, 201))
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(766, 203))
    else
        if fallout.action_being_used() == 13 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(766, 202))
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
