local fallout = require("fallout")

local start
local use_p_proc
local pickup_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(734, 100))
    end
end

function pickup_p_proc()
    use_p_proc()
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if skill == 9 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)
        if fallout.is_success(roll) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(734, 102))
        else
            fallout.display_msg(fallout.message_str(734, 103))
        end
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
    if fallout.obj_pid(item_obj) == 84 then
        fallout.script_overrides()
        if fallout.is_success(roll) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(734, 102))
        else
            if fallout.is_critical(roll) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
                fallout.destroy_object(item_obj)
                fallout.display_msg(fallout.message_str(734, 101))
            else
                fallout.display_msg(fallout.message_str(734, 103))
            end
        end
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(734, 100))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
