local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local damage_p_proc

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 7 then
            use_obj_on_p_proc()
        else
            if fallout.script_action() == use_skill_on_p_proc() then
                use_skill_on_p_proc()
            else
                if fallout.script_action() == 14 then
                    damage_p_proc()
                end
            end
        end
    end
end

function use_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(875, 100))
end

function use_obj_on_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.obj_being_used_with())
    if fallout.local_var(0) == 0 then
        if v0 == 75 then
            fallout.script_overrides()
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)) then
                if fallout.map_var(21) == 1 then
                    fallout.set_obj_visibility(fallout.external_var("field6a_Ptr"), 1)
                    fallout.display_msg(fallout.message_str(875, 103))
                    fallout.give_exp_points(50)
                    fallout.set_map_var(21, 0)
                else
                    fallout.set_obj_visibility(fallout.external_var("field6a_Ptr"), 0)
                    fallout.display_msg(fallout.message_str(875, 105))
                    fallout.set_map_var(21, 1)
                end
            else
                fallout.display_msg(fallout.message_str(875, 104))
            end
        end
    end
end

function use_skill_on_p_proc()
    local v0 = 0
    v0 = fallout.action_being_used()
    if fallout.local_var(0) == 0 then
        if v0 == 13 then
            fallout.script_overrides()
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, -20)) then
                if fallout.map_var(21) == 1 then
                    fallout.display_msg(fallout.message_str(875, 103))
                    fallout.set_obj_visibility(fallout.external_var("field6a_Ptr"), 1)
                    fallout.give_exp_points(50)
                    fallout.set_map_var(21, 0)
                else
                    fallout.set_obj_visibility(fallout.external_var("field6a_Ptr"), 0)
                    fallout.display_msg(fallout.message_str(875, 105))
                    fallout.set_map_var(21, 1)
                end
            else
                fallout.display_msg(fallout.message_str(875, 104))
            end
        end
    end
end

function damage_p_proc()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
        fallout.set_local_var(0, 1)
        fallout.destroy_object(fallout.external_var("field6a_Ptr"))
        fallout.display_msg(fallout.message_str(875, 102))
    else
        fallout.set_map_var(21, 0)
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        fallout.display_msg(fallout.message_str(875, 101))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.damage_p_proc = damage_p_proc
return exports
