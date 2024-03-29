local fallout = require("fallout")

local start
local look_at_p_proc
local description_p_proc
local use_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local map_enter_p_proc
local map_update_p_proc
local damage_p_proc
local Locked_And_Trapped
local Door_Locked
local Door_Trapped

local Set_Off_Trap = false

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
        fallout.display_msg(fallout.message_str(911, 101))
    else
        fallout.display_msg(fallout.message_str(911, 100))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(1) == 0 and fallout.local_var(0) == 0 then
        Locked_And_Trapped()
    elseif fallout.local_var(0) == 0 then
        Door_Trapped()
    elseif fallout.local_var(1) == 0 then
        Door_Locked()
    else
        fallout.display_msg(fallout.message_str(911, 102))
    end
end

function use_p_proc()
    local source_obj = fallout.source_obj()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local roll = fallout.roll_vs_skill(source_obj, 11, 0)
    if fallout.local_var(1) == 0 and fallout.local_var(0) == 0 then
        fallout.script_overrides()
        if fallout.is_success(roll) then
            fallout.reg_anim_func(2, source_obj)
            if source_obj == dude_obj then
                fallout.display_msg(fallout.message_str(911, 106))
            else
                fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                    fallout.message_str(911, 105))
            end
        else
            fallout.display_msg(fallout.message_str(911, 104))
            Set_Off_Trap = true
            fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(self_obj),
                fallout.random(10, 30))
            fallout.set_local_var(0, 1)
            fallout.set_local_var(2, fallout.local_var(2) + 1)
            fallout.display_msg(fallout.message_str(911, 103))
        end
    elseif fallout.local_var(0) == 0 then
        if fallout.is_success(roll) then
            fallout.script_overrides()
            fallout.reg_anim_func(2, source_obj)
            if source_obj == dude_obj then
                fallout.display_msg(fallout.message_str(911, 106))
            else
                fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                    fallout.message_str(911, 105))
            end
        else
            fallout.display_msg(fallout.message_str(911, 104))
            Set_Off_Trap = true
            fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(self_obj),
                fallout.random(10, 30))
            fallout.set_local_var(0, 1)
            fallout.set_local_var(2, fallout.local_var(2) + 1)
        end
    else
        if fallout.local_var(1) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(911, 103))
        end
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    local source_obj = fallout.source_obj()
    if skill == 11 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(source_obj, skill, 0)
        if fallout.is_success(roll) then
            fallout.reg_anim_func(2, source_obj)
            if source_obj == fallout.dude_obj() then
                fallout.display_msg(fallout.message_str(911, 106))
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(766, 103) .. "50" .. fallout.message_str(766, 104))
                fallout.give_exp_points(50)
            else
                fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                    fallout.message_str(911, 105))
            end
        else
            fallout.display_msg(fallout.message_str(911, 104))
            Set_Off_Trap = true
            fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(fallout.self_obj()),
                fallout.random(10, 30))
            fallout.set_local_var(0, 1)
            fallout.set_local_var(2, fallout.local_var(2) + 1)
        end
    elseif skill == 9 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(source_obj, skill, -20)
        if fallout.is_success(roll) then
            fallout.set_local_var(1, 1)
            fallout.display_msg(fallout.message_str(911, 111))
            fallout.obj_unlock(fallout.self_obj())
            fallout.display_msg(fallout.message_str(766, 103) .. "50" .. fallout.message_str(766, 104))
            fallout.give_exp_points(50)
        else
            if fallout.is_critical(roll) then
                fallout.jam_lock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(911, 112))
            else
                fallout.display_msg(fallout.message_str(911, 110))
            end
        end
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local item_pid = fallout.obj_pid(item_obj)
    local source_obj = fallout.source_obj()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if item_pid == 84 then
        local trap_roll = fallout.roll_vs_skill(source_obj, 11, 0)
        local lockpick_roll = fallout.roll_vs_skill(source_obj, 9, 0)
        if fallout.local_var(1) == 0 and fallout.local_var(0) == 0 then
            fallout.script_overrides()
            if fallout.is_success(trap_roll) then
                fallout.reg_anim_func(2, source_obj)
                if source_obj == dude_obj then
                    fallout.display_msg(fallout.message_str(911, 106))
                else
                    fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                        fallout.message_str(911, 105))
                end
            else
                fallout.display_msg(fallout.message_str(911, 104))
                Set_Off_Trap = true
                fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(fallout.self_obj()),
                    fallout.random(10, 30))
                fallout.set_local_var(0, 1)
                fallout.set_local_var(2, fallout.local_var(2) + 1)
            end
            fallout.display_msg(fallout.message_str(911, 108))
        elseif fallout.local_var(0) == 0 then
            fallout.script_overrides()
            if fallout.is_success(trap_roll) then
                fallout.reg_anim_func(2, source_obj)
                if source_obj == dude_obj then
                    fallout.display_msg(fallout.message_str(911, 106))
                else
                    fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                        fallout.message_str(911, 105))
                end
            else
                fallout.display_msg(fallout.message_str(911, 104))
                Set_Off_Trap = true
                fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(self_obj),
                    fallout.random(10, 30))
                fallout.set_local_var(0, 1)
                fallout.set_local_var(2, fallout.local_var(2) + 1)
            end
            fallout.display_msg(fallout.message_str(911, 108))
        elseif fallout.local_var(1) == 0 then
            fallout.script_overrides()
            if fallout.is_success(lockpick_roll) then
                fallout.set_local_var(1, 1)
                fallout.display_msg(fallout.message_str(911, 111))
                fallout.display_msg(fallout.message_str(766, 103) .. "50" .. fallout.message_str(766, 104))
                fallout.give_exp_points(50)
                fallout.obj_unlock(self_obj)
            else
                if fallout.is_critical(lockpick_roll) then
                    fallout.rm_obj_from_inven(dude_obj, item_obj)
                    fallout.destroy_object(item_obj)
                    fallout.jam_lock(self_obj)
                    fallout.display_msg(fallout.message_str(911, 109))
                else
                    fallout.display_msg(fallout.message_str(911, 110))
                end
            end
        end
    else
        fallout.script_overrides()
        local trap_roll = fallout.roll_vs_skill(source_obj, 11, 0)
        if fallout.local_var(1) == 0 and fallout.local_var(0) == 0 then
            fallout.script_overrides()
            if fallout.is_success(trap_roll) then
                fallout.reg_anim_func(2, source_obj)
                if source_obj == dude_obj then
                    fallout.display_msg(fallout.message_str(911, 106))
                else
                    fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                        fallout.message_str(911, 105))
                end
            else
                fallout.display_msg(fallout.message_str(911, 104))
                Set_Off_Trap = true
                fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(self_obj),
                    fallout.random(10, 30))
                fallout.set_local_var(0, 1)
                fallout.set_local_var(2, fallout.local_var(2) + 1)
            end
        elseif fallout.local_var(0) == 0 then
            if fallout.is_success(trap_roll) then
                fallout.reg_anim_func(2, source_obj)
                if source_obj == dude_obj then
                    fallout.display_msg(fallout.message_str(911, 106))
                else
                    fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) ..
                        fallout.message_str(911, 105))
                end
            else
                fallout.display_msg(fallout.message_str(911, 104))
                Set_Off_Trap = true
                fallout.explosion(fallout.tile_num(source_obj), fallout.elevation(self_obj),
                    fallout.random(10, 30))
                fallout.set_local_var(0, 1)
                fallout.set_local_var(2, fallout.local_var(2) + 1)
            end
        elseif fallout.local_var(1) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(911, 107))
        end
    end
end

function map_enter_p_proc()
    if fallout.local_var(1) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

function map_update_p_proc()
    if fallout.local_var(1) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

function damage_p_proc()
    fallout.set_local_var(2, fallout.local_var(2) + 1)
    if not Set_Off_Trap then
        fallout.display_msg(fallout.message_str(911, 104))
        fallout.explosion(fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()),
            fallout.random(20, 40))
        fallout.set_local_var(0, 1)
        Set_Off_Trap = true
    end
    if fallout.local_var(2) > 1 then
        fallout.set_obj_visibility(fallout.self_obj(), true)
    end
end

function Locked_And_Trapped()
    local trap_roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
    local lockpick_roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
    if fallout.is_success(trap_roll) then
        if fallout.is_critical(trap_roll) then
            if fallout.is_success(lockpick_roll) then
                fallout.display_msg(fallout.message_str(911, 113))
            else
                if fallout.is_critical(lockpick_roll) then
                    fallout.display_msg(fallout.message_str(911, 114))
                end
            end
        else
            if fallout.is_success(lockpick_roll) then
                fallout.display_msg(fallout.message_str(911, 115))
            else
                if fallout.is_critical(lockpick_roll) then
                    fallout.display_msg(fallout.message_str(911, 116))
                end
            end
        end
    else
        if fallout.is_critical(trap_roll) then
            if fallout.is_success(lockpick_roll) then
                fallout.display_msg(fallout.message_str(911, 117))
            else
                if fallout.is_critical(lockpick_roll) then
                    fallout.display_msg(fallout.message_str(911, 118))
                end
            end
        else
            if fallout.is_success(lockpick_roll) then
                fallout.display_msg(fallout.message_str(911, 117))
            else
                if fallout.is_critical(lockpick_roll) then
                    fallout.display_msg(fallout.message_str(911, 118))
                end
            end
        end
    end
end

function Door_Locked()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(911, 117))
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(911, 117))
        end
    end
end

function Door_Trapped()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
    if fallout.is_success(roll) then
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(911, 114))
        else
            fallout.display_msg(fallout.message_str(911, 116))
        end
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(911, 118))
        else
            fallout.display_msg(fallout.message_str(911, 118))
        end
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.damage_p_proc = damage_p_proc
return exports
