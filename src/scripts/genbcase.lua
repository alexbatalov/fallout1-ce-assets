local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local skills

local use_skill = 0

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill = fallout.action_being_used()
            skills()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(810, 100))
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(810, 101))
end

function skills()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(810, 103))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
