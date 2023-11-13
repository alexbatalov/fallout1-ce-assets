local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    if fallout.local_var(0) == 0 and fallout.global_var(139) == 2 then
        fallout.script_overrides()
        fallout.set_local_var(1, fallout.local_var(1) + 1)
        local damage = fallout.random(1, 6) - 4 + fallout.local_var(1)
        if damage <= 0 then
            fallout.display_msg(fallout.message_str(328, 101))
        else
            if damage == 1 then
                fallout.display_msg(fallout.message_str(328, 102))
                fallout.critter_dmg(fallout.dude_obj(), damage, 0)
            else
                fallout.display_msg(fallout.message_str(328, 103) .. damage .. fallout.message_str(328, 104))
                fallout.critter_dmg(fallout.dude_obj(), damage, 0)
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 97 then
        fallout.set_local_var(0, 1)
        fallout.display_msg(fallout.message_str(328, 105))
    else
        fallout.display_msg(fallout.message_str(328, 106))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(328, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
