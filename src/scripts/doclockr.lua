local fallout = require("fallout")

local start
local look_at_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local set_off_trap

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function look_at_p_proc()
    fallout.set_map_var(4, fallout.self_obj())
end

function use_p_proc()
    fallout.set_external_var("messing_with_Morbid_stuff", 1)
    local source_obj = fallout.source_obj()
    if source_obj == fallout.dude_obj() then
        if fallout.obj_is_locked(fallout.self_obj()) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(851, 100))
        else
            if fallout.local_var(2) == 0 then
                fallout.script_overrides()
                if fallout.local_var(1) == 0 then
                    local roll = fallout.roll_vs_skill(source_obj, 11, 0)
                    if fallout.is_success(roll) then
                        fallout.reg_anim_func(2, source_obj)
                        roll = fallout.roll_vs_skill(source_obj, 11, 0)
                        if fallout.is_success(roll) then
                            fallout.set_local_var(1, 1)
                            fallout.set_local_var(2, 1)
                            fallout.display_msg(fallout.message_str(851, 101))
                        else
                            if fallout.is_critical(roll) and fallout.local_var(2) == 0 then
                                fallout.set_local_var(1, 1)
                                fallout.set_local_var(2, 1)
                                fallout.display_msg(fallout.message_str(851, 103))
                                set_off_trap()
                            else
                                fallout.set_local_var(1, 1)
                                fallout.display_msg(fallout.message_str(851, 102))
                            end
                        end
                    else
                        set_off_trap()
                    end
                else
                    set_off_trap()
                end
            end
        end
    elseif source_obj == fallout.external_var("Katja_ptr") then
        fallout.set_local_var(1, 1)
        fallout.set_local_var(2, 1)
        fallout.obj_unlock(fallout.self_obj())
    end
end

function use_obj_on_p_proc()
    fallout.set_external_var("messing_with_Morbid_stuff", 1)
    if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_locked(self_obj) then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -40)
            if fallout.is_success(roll) then
                fallout.obj_unlock(self_obj)
                fallout.display_msg(fallout.message_str(851, 107))
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(self_obj)
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    if fallout.local_var(0) >= 3 and fallout.local_var(2) == 0 then
                        fallout.display_msg(fallout.message_str(851, 106))
                        set_off_trap()
                    else
                        fallout.display_msg(fallout.message_str(851, 110))
                    end
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    if fallout.local_var(0) >= 3 and fallout.local_var(2) == 0 then
                        fallout.display_msg(fallout.message_str(851, 106))
                        set_off_trap()
                    else
                        fallout.display_msg(fallout.message_str(851, 108))
                    end
                end
            end
        else
            fallout.display_msg(fallout.message_str(851, 109))
        end
    end
end

function use_skill_on_p_proc()
    fallout.set_external_var("messing_with_Morbid_stuff", 1)
    local skill = fallout.action_being_used()
    if skill == 9 then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_locked(self_obj) then
            fallout.script_overrides()
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, -60)
            if fallout.is_success(roll) then
                fallout.obj_unlock(self_obj)
                fallout.display_msg(fallout.message_str(851, 107))
            else
                if fallout.is_critical(roll) then
                    fallout.jam_lock(self_obj)
                    fallout.display_msg(fallout.message_str(851, 110))
                else
                    fallout.display_msg(fallout.message_str(851, 108))
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    if fallout.local_var(0) >= 3 and fallout.local_var(2) == 0 then
                        fallout.display_msg(fallout.message_str(851, 106))
                        set_off_trap()
                    end
                end
            end
        else
            fallout.display_msg(fallout.message_str(851, 109))
        end
    elseif skill == 11 then
        if fallout.local_var(1) == 0 then
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 11, 0)
            if fallout.is_success(roll) then
                if fallout.is_critical(roll) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(851, 101))
                    fallout.set_local_var(1, 1)
                    fallout.set_local_var(2, 1)
                else
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(851, 111))
                    fallout.set_local_var(1, 1)
                end
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(851, 106))
                    set_off_trap()
                end
            end
        else
            if fallout.local_var(2) == 0 then
                fallout.script_overrides()
                local roll = fallout.roll_vs_skill(fallout.source_obj(), 11, 0)
                if fallout.is_success(roll) then
                    fallout.display_msg(fallout.message_str(851, 104))
                    fallout.set_local_var(2, 1)
                else
                    if fallout.is_critical(roll) then
                        fallout.display_msg(fallout.message_str(851, 106))
                        set_off_trap()
                    else
                        fallout.display_msg(fallout.message_str(851, 105))
                    end
                end
            end
        end
    end
end

function set_off_trap()
    if fallout.local_var(2) == 0 then
        local self_obj = fallout.self_obj()
        fallout.explosion(fallout.tile_num(self_obj), fallout.elevation(self_obj),
            fallout.random(6, 36))
        fallout.destroy_object(self_obj)
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
