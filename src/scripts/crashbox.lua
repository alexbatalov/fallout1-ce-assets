local fallout = require("fallout")
local time = require("lib.time")

local start
local description_p_proc
local look_at_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(852, 101))
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(852, 100))
end

function use_p_proc()
    if fallout.global_var(168) < time.game_time_in_days() then
        fallout.set_external_var("messing_with_fridge", 1)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        if not fallout.is_success(fallout.roll_vs_skill(fallout.source_obj(), fallout.action_being_used(), 0)) then
            if fallout.global_var(168) < time.game_time_in_days() then
                fallout.set_external_var("messing_with_fridge", 1)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
