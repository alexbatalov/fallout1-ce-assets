local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(94, 107))
end

function use_obj_on_p_proc()
    local dude_obj = fallout.dude_obj()
    local item_obj = fallout.obj_being_used_with()
    fallout.script_overrides()
    if fallout.has_skill(dude_obj, 9) then
        local roll = fallout.roll_vs_skill(dude_obj, 9, -10)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(94, 100))
            fallout.set_local_var(0, 1)
        else
            fallout.display_msg(fallout.message_str(94, 101))
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(94, 102))
                fallout.rm_obj_from_inven(dude_obj, item_obj)
            end
        end
    else
        fallout.display_msg(fallout.message_str(94, 103))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(94, 104))
    else
        if fallout.local_var(2) == 1 then
            fallout.display_msg(fallout.message_str(94, 105))
        else
            fallout.display_msg(fallout.message_str(94, 106))
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
