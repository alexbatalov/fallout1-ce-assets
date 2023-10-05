local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc

local Hacked = 0

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(110, 100))
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 8 then
                if fallout.action_being_used() == 12 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function use_p_proc()
    local v0 = 0
    if Hacked == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(910, 105))
    else
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(910, 107))
    end
end

function use_skill_on_p_proc()
    local v0 = 0
    v0 = fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)
    if fallout.is_success(v0) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(910, 107))
        Hacked = 1
    else
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(910, 106))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
