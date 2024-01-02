local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc

local hacked = false

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(110, 100))
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    if not hacked then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(910, 105))
    else
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(910, 107))
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)
        if fallout.is_success(roll) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(910, 107))
            hacked = true
        else
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(910, 106))
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
