local fallout = require("fallout")

local start
local description_p_proc
local use_obj_on_p_proc
local use_skill_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 8 then
        use_skill_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.global_var(139) == 2 then
        fallout.display_msg(fallout.message_str(301, 101))
    else
        fallout.display_msg(fallout.message_str(301, 102))
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 75 then
        fallout.script_overrides()
        if fallout.has_skill(fallout.dude_obj(), 13) > 35 then
            fallout.set_local_var(0, 0)
        end
        if fallout.global_var(139) == 2 then
            fallout.display_msg(fallout.message_str(301, 103))
        else
            if fallout.local_var(0) == 0 then
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, 10)) then
                    fallout.display_msg(fallout.message_str(301, 104))
                    fallout.set_global_var(139, 2)
                    fallout.display_msg(fallout.message_str(766, 103) .. "1000" .. fallout.message_str(766, 104))
                    fallout.give_exp_points(1000)
                else
                    if fallout.has_skill(fallout.dude_obj(), 13) < 35 then
                        fallout.set_local_var(0, 1)
                    end
                    fallout.display_msg(fallout.message_str(301, 105))
                    fallout.game_time_advance(fallout.game_ticks(1200))
                end
            elseif fallout.local_var(0) == 1 then
                fallout.display_msg(fallout.message_str(301, 106))
            end
        end
    end
end

function use_skill_p_proc()
    if fallout.action_being_used() == 13 then
        fallout.script_overrides()
        if fallout.has_skill(fallout.dude_obj(), 13) > 35 then
            fallout.set_local_var(0, 0)
        end
        if fallout.global_var(139) == 2 then
            fallout.display_msg(fallout.message_str(301, 103))
        else
            if fallout.local_var(0) == 0 then
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 13, -10)) then
                    fallout.display_msg(fallout.message_str(301, 104))
                    fallout.set_global_var(139, 2)
                    fallout.give_exp_points(1000)
                    fallout.display_msg(fallout.message_str(766, 103) .. "1000" .. fallout.message_str(766, 104))
                else
                    if fallout.has_skill(fallout.dude_obj(), 13) < 35 then
                        fallout.set_local_var(0, 1)
                    end
                    fallout.display_msg(fallout.message_str(301, 105))
                    fallout.game_time_advance(fallout.game_ticks(1200))
                end
            elseif fallout.local_var(0) == 1 then
                fallout.display_msg(fallout.message_str(301, 106))
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(301, 100))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_p_proc = use_skill_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
