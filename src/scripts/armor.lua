local fallout = require("fallout")

local start
local use_p_proc
local pickup_p_proc
local look_at_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local chance
local try_skill
local fixed
local failure

local Test = 0
local temp = 0
local bonus = 0
local use_skill = 0

function start()
    bonus = 0
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                else
                    if fallout.script_action() == 7 then
                        use_obj_on_p_proc()
                    end
                end
            end
        end
    end
end

function use_p_proc()
    if fallout.source_obj() ~= fallout.dude_obj() then
    else
        fallout.display_msg(fallout.message_str(936, 101))
    end
end

function pickup_p_proc()
    use_p_proc()
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(936, 100))
end

function use_skill_on_p_proc()
    use_skill = fallout.action_being_used()
    try_skill()
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 75 then
        bonus = 10
        use_skill = 13
        use_skill_on_p_proc()
    else
        fallout.display_msg(fallout.message_str(936, 105))
    end
end

function chance()
    Test = fallout.roll_vs_skill(fallout.dude_obj(), 13, bonus)
    if fallout.is_success(Test) then
        fixed()
    else
        failure()
    end
end

function try_skill()
    if use_skill == 13 then
        if fallout.global_var(304) > 1 then
            if fallout.global_var(304) == 3 then
                if fallout.has_skill(fallout.dude_obj(), 13) < 75 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(936, 103))
                else
                    chance()
                end
            else
                chance()
            end
        else
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(936, 102))
        end
    else
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(936, 105))
    end
end

function fixed()
    fallout.script_overrides()
    fallout.set_global_var(304, 4)
    fallout.display_msg(fallout.message_str(936, 104))
    fallout.create_object_sid(3, 22475, 0, -1)
    temp = 500
    fallout.display_msg(fallout.message_str(936, 107) + temp + fallout.message_str(936, 108))
    fallout.give_exp_points(temp)
    fallout.destroy_object(fallout.self_obj())
end

function failure()
    fallout.script_overrides()
    fallout.set_global_var(304, 3)
    fallout.display_msg(fallout.message_str(936, 106))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
