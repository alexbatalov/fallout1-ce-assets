local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    fallout.set_global_var(214, 1)
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 10, -30)
        if fallout.is_success(roll) then
        else
            fallout.script_overrides()
            fallout.set_global_var(214, 1)
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
