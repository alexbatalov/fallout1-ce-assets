local fallout = require("fallout")

local start
local description_p_proc
local map_enter_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc

local test = 0

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 15 then
            map_enter_p_proc()
        else
            if fallout.script_action() == 6 then
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
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(363, 100))
end

function map_enter_p_proc()
    fallout.obj_lock(fallout.self_obj())
end

function use_p_proc()
    if fallout.obj_is_locked(fallout.self_obj()) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(363, 101))
    end
end

function use_obj_on_p_proc()
    if fallout.obj_being_used_with() == 77 then
        fallout.script_overrides()
        if not(fallout.obj_is_locked(fallout.self_obj())) then
            fallout.display_msg(fallout.message_str(363, 104))
        else
            test = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
            if fallout.is_success(test) then
                fallout.display_msg(fallout.message_str(363, 102))
                fallout.obj_unlock(fallout.self_obj())
            else
                if fallout.is_critical(test) then
                    fallout.display_msg(fallout.message_str(363, 103))
                    fallout.jam_lock(fallout.self_obj())
                else
                    fallout.display_msg(fallout.message_str(363, 106))
                end
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        if not(fallout.obj_is_locked(fallout.self_obj())) then
            fallout.display_msg(fallout.message_str(363, 104))
        else
            test = fallout.roll_vs_skill(fallout.source_obj(), fallout.action_being_used(), -20)
            if fallout.is_success(test) then
                fallout.display_msg(fallout.message_str(363, 102))
                fallout.obj_unlock(fallout.self_obj())
            else
                if fallout.is_critical(test) then
                    fallout.display_msg(fallout.message_str(363, 103))
                    fallout.jam_lock(fallout.self_obj())
                else
                    fallout.display_msg(fallout.message_str(363, 105))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
