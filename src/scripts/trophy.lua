local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

local item = 0

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 4 then
            use_p_proc()
        else
            if fallout.script_action() == 7 then
                use_obj_on_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(527, 100))
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.global_var(286) == 0 then
        if (fallout.game_time_hour() >= 410) and (fallout.game_time_hour() <= 1200) then
            fallout.script_overrides()
            fallout.set_global_var(286, 1)
            item = fallout.create_object_sid(112, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.source_obj(), item)
            fallout.display_msg(fallout.message_str(527, 101))
            fallout.animate_stand_obj(fallout.self_obj())
        else
            fallout.display_msg(fallout.message_str(527, 103))
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 112 then
        fallout.script_overrides()
        fallout.set_global_var(286, 0)
        fallout.set_map_var(4, 0)
        fallout.animate_stand_obj(fallout.self_obj())
        fallout.rm_obj_from_inven(fallout.source_obj(), fallout.obj_being_used_with())
        fallout.destroy_object(fallout.obj_being_used_with())
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        if fallout.global_var(286) == 0 then
            fallout.script_overrides()
            fallout.set_global_var(286, 1)
            item = fallout.create_object_sid(112, 0, 0, -1)
            fallout.add_obj_to_inven(fallout.source_obj(), item)
            if fallout.is_success(fallout.roll_vs_skill(fallout.source_obj(), 10, 0)) then
                fallout.display_msg(fallout.message_str(527, 101))
            else
                fallout.display_msg(fallout.message_str(527, 102))
                fallout.set_map_var(4, 1)
            end
            fallout.reg_anim_func(2, fallout.self_obj())
            fallout.animate_stand_obj(fallout.self_obj())
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
