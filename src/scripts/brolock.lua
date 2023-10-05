local fallout = require("fallout")

local start
local pickup_p_proc
local use_skill_on_p_proc

local Test = 0

function start()
    if fallout.script_action() == 8 then
        use_skill_on_p_proc()
    else
        if fallout.script_action() == pickup_p_proc() then
            pickup_p_proc()
        end
    end
end

function pickup_p_proc()
    use_skill_on_p_proc()
end

function use_skill_on_p_proc()
    if fallout.global_var(250) == 0 then
        Test = fallout.roll_vs_skill(fallout.dude_obj(), 10, 0)
        if fallout.action_being_used() == 10 then
            if not(fallout.is_success(Test)) then
                fallout.script_overrides()
                if fallout.is_critical(Test) then
                    fallout.set_global_var(250, 1)
                    fallout.display_msg(fallout.message_str(766, 181))
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    if fallout.local_var(0) > 2 then
                        fallout.set_global_var(250, 1)
                        fallout.display_msg(fallout.message_str(766, 181))
                    else
                        fallout.display_msg(fallout.message_str(766, 180))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
