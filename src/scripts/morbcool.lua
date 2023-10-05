local fallout = require("fallout")

local start
local pickup_p_proc
local use_p_proc
local use_skill_on_p_proc

local test = 0

function start()
    if fallout.script_action() == 4 then
        pickup_p_proc()
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
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(877, 101))
    else
        if fallout.action_being_used() == 7 then
            test = fallout.roll_vs_skill(fallout.source_obj(), fallout.action_being_used(), 0)
            if fallout.is_success(test) then
                fallout.script_overrides()
                if fallout.is_critical(test) then
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
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
