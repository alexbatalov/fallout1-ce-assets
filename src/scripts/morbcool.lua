local fallout = require("fallout")

local start
local pickup_p_proc
local use_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 4 then
        pickup_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(877, 100))
        fallout.set_external_var("messing_with_Morbid_stuff", 1)
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(877, 101))
        fallout.set_external_var("messing_with_Morbid_stuff", 1)
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if skill == 10 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(877, 101))
    elseif skill == 7 then
        local roll = fallout.roll_vs_skill(fallout.source_obj(), skill, 0)
        if fallout.is_success(roll) then
            fallout.script_overrides()
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(877, 102))
            else
                fallout.display_msg(fallout.message_str(877, 104))
            end
        else
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(877, 103))
        end
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
