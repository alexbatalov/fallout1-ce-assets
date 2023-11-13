local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local arm_doors
local shock

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(3) == 1 then
        fallout.script_overrides()
        shock()
    elseif fallout.local_var(0) == 0 then
        arm_doors()
    elseif fallout.local_var(1) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(503, 105))
    end
end

function use_obj_on_p_proc()
    fallout.script_overrides()
    if fallout.local_var(3) == 0 then
        shock()
    elseif fallout.local_var(0) == 0 then
        arm_doors()
    else
        local skill_roll
        -- FIXME: Comparing object and pid.
        if fallout.obj_being_used_with() == 84 then
            skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
        else
            skill_roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 3)
        end
        if fallout.local_var(1) == 1 then
            fallout.display_msg(fallout.message_str(503, 100))
        else
            if fallout.is_success(skill_roll) then
                fallout.display_msg(fallout.message_str(503, 101))
                fallout.set_local_var(1, 1)
            else
                fallout.display_msg(fallout.message_str(503, 102))
            end
        end
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if skill ~= 12 and skill ~= 11 then
        if fallout.local_var(3) == 1 then
            shock()
        else
            arm_doors()
        end
    else
        if fallout.local_var(0) == 1 then
            fallout.display_msg(fallout.message_str(503, 106))
        else
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), skill, 0)) then
                fallout.display_msg(fallout.message_str(503, 107))
                fallout.set_local_var(3, 0)
                fallout.set_local_var(0, 1)
            else
                if fallout.local_var(3) == 1 then
                    shock()
                else
                    arm_doors()
                end
            end
        end
    end
end

function arm_doors()
    fallout.display_msg(fallout.message_str(503, 104))
    fallout.set_local_var(3, 1)
end

function shock()
    fallout.display_msg(fallout.message_str(503, 103))
    fallout.critter_dmg(fallout.dude_obj(), 1, 0)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
