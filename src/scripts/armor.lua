local fallout = require("fallout")

local start
local use_p_proc
local pickup_p_proc
local look_at_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local chance
local try_skill

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
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
    try_skill(fallout.action_being_used(), 0)
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 75 then
        try_skill(13, 10)
    else
        fallout.display_msg(fallout.message_str(936, 105))
    end
end

function chance(bonus)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, bonus)) then
        local xp = 500
        fallout.script_overrides()
        fallout.set_global_var(304, 4)
        fallout.display_msg(fallout.message_str(936, 104))
        fallout.create_object_sid(3, 22475, 0, -1)
        fallout.display_msg(fallout.message_str(936, 107) .. xp .. fallout.message_str(936, 108))
        fallout.give_exp_points(xp)
        fallout.destroy_object(fallout.self_obj())
    else
        fallout.script_overrides()
        fallout.set_global_var(304, 3)
        fallout.display_msg(fallout.message_str(936, 106))
    end
end

function try_skill(use_skill, bonus)
    if use_skill == 13 then
        if fallout.global_var(304) > 1 then
            if fallout.global_var(304) == 3 then
                if fallout.has_skill(fallout.dude_obj(), 13) < 75 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(936, 103))
                else
                    chance(bonus)
                end
            else
                chance(bonus)
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

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
