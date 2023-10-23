local fallout = require("fallout")
local time = require("lib.time")

local start
local description_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
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
    local skill = fallout.action_being_used()
    if skill == 12 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), skill, 0)) then
            if time.game_time_in_days() >= 90 then
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
