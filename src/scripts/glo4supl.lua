local fallout = require("fallout")

local start
local open_door
local pick_lock
local disarm_electronics
local arm_doors
local shock

local skill_roll = 0

function start()
    if fallout.script_action() == 6 then
        open_door()
    else
        if fallout.script_action() == 7 then
            pick_lock()
        else
            if fallout.script_action() == 8 then
                disarm_electronics()
            end
        end
    end
end

function open_door()
    if fallout.local_var(3) == 1 then
        fallout.script_overrides()
        shock()
    else
        if fallout.local_var(0) == 0 then
            arm_doors()
        else
            if fallout.local_var(1) == 0 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(503, 105))
            end
        end
    end
end

function pick_lock()
    fallout.script_overrides()
    if fallout.local_var(3) == 0 then
        shock()
    else
        if fallout.local_var(0) == 0 then
            arm_doors()
        else
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
end

function disarm_electronics()
    if (fallout.action_being_used() ~= 12) and (fallout.action_being_used() ~= 11) then
        if fallout.local_var(3) == 1 then
            shock()
        else
            arm_doors()
        end
    else
        if fallout.local_var(0) == 1 then
            fallout.display_msg(fallout.message_str(503, 106))
        else
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), fallout.action_being_used(), 0)) then
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
return exports
