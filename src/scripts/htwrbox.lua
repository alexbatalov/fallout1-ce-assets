local fallout = require("fallout")

local start
local look_at_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local set_off_trap

local test = 0

function start()
    if fallout.script_action() == 21 then
        look_at_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(872, 100))
    else
        fallout.display_msg(fallout.message_str(872, 101))
    end
end

function use_p_proc()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(872, 102))
    else
        if fallout.local_var(1) == 0 then
            fallout.script_overrides()
            if fallout.local_var(2) == 0 then
                test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
                if fallout.is_success(test) then
                    fallout.reg_anim_func(2, fallout.source_obj())
                    test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
                    if fallout.is_success(test) then
                        fallout.set_local_var(2, 1)
                        fallout.set_local_var(1, 1)
                        fallout.display_msg(fallout.message_str(872, 103))
                    else
                        if fallout.is_critical(test) then
                            fallout.set_local_var(2, 1)
                            fallout.set_local_var(1, 1)
                            fallout.display_msg(fallout.message_str(872, 104))
                            set_off_trap()
                        else
                            fallout.set_local_var(2, 1)
                            fallout.set_local_var(1, 0)
                            fallout.display_msg(fallout.message_str(872, 105))
                        end
                    end
                else
                    fallout.set_local_var(1, 1)
                    set_off_trap()
                end
            else
                fallout.set_local_var(1, 1)
                set_off_trap()
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 77 then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            test = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
            if fallout.is_success(test) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(872, 107))
                fallout.set_local_var(3, fallout.local_var(3) + 1)
                if (fallout.local_var(3) >= 3) and (fallout.local_var(1) == 0) then
                    fallout.display_msg(fallout.message_str(872, 108))
                    fallout.set_local_var(1, 1)
                    set_off_trap()
                end
            else
                if fallout.is_critical(test) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(872, 109))
                    fallout.set_local_var(3, fallout.local_var(3) + 1)
                    if (fallout.local_var(3) >= 3) and (fallout.local_var(1) == 0) then
                        fallout.display_msg(fallout.message_str(872, 108))
                        fallout.set_local_var(1, 1)
                        set_off_trap()
                    end
                else
                    fallout.display_msg(fallout.message_str(872, 110))
                    fallout.set_local_var(3, fallout.local_var(3) + 1)
                    if (fallout.local_var(3) >= 3) and (fallout.local_var(1) == 0) then
                        fallout.display_msg(fallout.message_str(872, 108))
                        fallout.set_local_var(1, 1)
                        set_off_trap()
                    end
                end
            end
        else
            fallout.display_msg(fallout.message_str(872, 106))
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            test = fallout.roll_vs_skill(fallout.dude_obj(), 9, -20)
            if fallout.is_success(test) then
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(872, 107))
                fallout.set_local_var(3, fallout.local_var(3) + 1)
                if (fallout.local_var(3) >= 3) and (fallout.local_var(1) == 0) then
                    fallout.display_msg(fallout.message_str(872, 108))
                    fallout.set_local_var(1, 1)
                    set_off_trap()
                end
            else
                if fallout.is_critical(test) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(872, 109))
                    fallout.set_local_var(3, fallout.local_var(3) + 1)
                    if (fallout.local_var(3) >= 3) and (fallout.local_var(1) == 0) then
                        fallout.display_msg(fallout.message_str(872, 108))
                        fallout.set_local_var(1, 1)
                        set_off_trap()
                    end
                else
                    fallout.display_msg(fallout.message_str(872, 110))
                    fallout.set_local_var(3, fallout.local_var(3) + 1)
                    if (fallout.local_var(3) >= 3) and (fallout.local_var(1) == 0) then
                        fallout.display_msg(fallout.message_str(872, 108))
                        fallout.set_local_var(1, 1)
                        set_off_trap()
                    end
                end
            end
        else
            fallout.display_msg(fallout.message_str(872, 106))
        end
    else
        if fallout.action_being_used() == 11 then
            if fallout.local_var(2) == 0 then
                test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
                if fallout.is_success(test) then
                    if fallout.is_critical(test) then
                        fallout.script_overrides()
                        fallout.display_msg(fallout.message_str(872, 111))
                        fallout.set_local_var(2, 1)
                        fallout.set_local_var(1, 1)
                    else
                        fallout.script_overrides()
                        fallout.display_msg(fallout.message_str(872, 112))
                        fallout.set_local_var(2, 1)
                    end
                else
                    if fallout.is_critical(test) then
                        fallout.script_overrides()
                        fallout.display_msg(fallout.message_str(872, 113))
                        fallout.set_local_var(1, 1)
                        set_off_trap()
                    else
                        fallout.script_overrides()
                        fallout.display_msg(fallout.message_str(872, 114))
                    end
                end
            else
                fallout.script_overrides()
                test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
                if fallout.is_success(test) then
                    fallout.display_msg(fallout.message_str(872, 115))
                    fallout.set_local_var(1, 1)
                else
                    if fallout.is_critical(test) then
                        fallout.display_msg(fallout.message_str(872, 116))
                        fallout.set_local_var(1, 1)
                        set_off_trap()
                    else
                        fallout.display_msg(fallout.message_str(872, 117))
                    end
                end
            end
        end
    end
end

function set_off_trap()
    fallout.explosion(fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), fallout.random(6, 36))
    fallout.set_local_var(0, 1)
    fallout.set_local_var(1, 1)
    fallout.obj_unlock(fallout.self_obj())
    fallout.obj_open(fallout.self_obj())
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
