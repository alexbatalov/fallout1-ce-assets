local fallout = require("fallout")

local Test = 0

local start
local use_skill_on_p_proc

function start()
    if fallout.script_action() == 6 then
        fallout.set_global_var(214, 1)
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        Test = fallout.roll_vs_skill(fallout.dude_obj(), 10, -30)
        if fallout.is_success(Test) then
        else
            fallout.script_overrides()
            fallout.set_global_var(214, 1)
        end
    end
end

local exports = {}
exports.start = start
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
