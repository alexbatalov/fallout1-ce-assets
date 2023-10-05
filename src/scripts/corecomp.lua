local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
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

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(133, 100))
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(793, 100))
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), fallout.action_being_used(), 0)) then
            if (fallout.game_time() // (10 * 60 * 60 * 24)) >= 90 then
                fallout.display_msg(fallout.message_str(133, 101))
            else
                fallout.display_msg(fallout.message_str(133, 102))
            end
        else
            fallout.display_msg(fallout.message_str(133, 103))
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
