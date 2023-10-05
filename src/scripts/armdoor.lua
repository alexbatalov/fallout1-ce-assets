local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc
local look_at_p_proc
local use_obj_on_p_proc
local map_update_p_proc
local damage_p_proc

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        look_at_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        else
            if fallout.script_action() == 8 then
                use_skill_on_p_proc()
            else
                if fallout.script_action() == 7 then
                    use_obj_on_p_proc()
                else
                    if fallout.script_action() == 14 then
                        damage_p_proc()
                    else
                        if fallout.script_action() == 23 then
                            map_update_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function use_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
    if (fallout.local_var(0) == 0) and (fallout.source_obj() == fallout.dude_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 104))
    end
end

function use_skill_on_p_proc()
    local v0 = 0
    if fallout.local_var(0) == 0 then
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            v0 = fallout.roll_vs_skill(fallout.dude_obj(), 9, -40)
            if fallout.is_success(v0) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(63, 100))
                fallout.display_msg(fallout.message_str(766, 103) + "65" + fallout.message_str(766, 104))
                fallout.give_exp_points(65)
            else
                if fallout.is_critical(v0) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(63, 110))
                else
                    fallout.display_msg(fallout.message_str(63, 103))
                end
            end
        end
    else
        fallout.display_msg(fallout.message_str(63, 109))
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 104))
    end
end

function use_obj_on_p_proc()
    local v0 = 0
    local v1 = 0
    v0 = fallout.obj_being_used_with()
    v1 = fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)
    if fallout.obj_pid(v0) == 77 then
        fallout.script_overrides()
        if fallout.is_success(v1) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(63, 100))
            fallout.display_msg(fallout.message_str(766, 103) + "65" + fallout.message_str(766, 104))
            fallout.give_exp_points(65)
        else
            if fallout.is_critical(v1) then
                fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
                fallout.destroy_object(v0)
                fallout.display_msg(fallout.message_str(63, 101))
            else
                fallout.display_msg(fallout.message_str(63, 103))
            end
        end
    end
end

function map_update_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

function damage_p_proc()
    fallout.set_local_var(2, fallout.local_var(2) + 1)
    if fallout.local_var(2) > 2 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        fallout.set_local_var(1, 1)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.damage_p_proc = damage_p_proc
return exports
