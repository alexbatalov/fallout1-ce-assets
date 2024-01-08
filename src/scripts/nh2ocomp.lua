local fallout = require("fallout")
local time = require("lib.time")

local start
local description_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local look_at_p_proc
local search
local removal

local bonus = 20

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 2 then
        search()
    else
        fallout.display_msg(fallout.message_str(86, 107))
    end
end

function use_p_proc()
    fallout.script_overrides()
    removal()
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    if fallout.obj_pid(item_obj) == 55 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(86, 110))
        fallout.rm_obj_from_inven(fallout.dude_obj(), item_obj)
        fallout.add_obj_to_inven(fallout.self_obj(), item_obj)
        fallout.set_global_var(30, 0)
        fallout.set_global_var(101, 0)
    else
        fallout.display_msg(fallout.message_str(86, 111))
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    fallout.script_overrides()
    if skill == 13 then
        removal()
    elseif skill == 12 then
        if fallout.global_var(30) ~= 0 then
            fallout.display_msg(fallout.message_str(86, 116))
        else
            local roll = fallout.roll_vs_skill(fallout.dude_obj(), 12, 20)
            if fallout.is_success(roll) then
                bonus = 40
                fallout.display_msg(fallout.message_str(86, 115))
            else
                fallout.display_msg(fallout.message_str(86, 109))
            end
        end
    else
        fallout.display_msg(fallout.message_str(86, 109))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(86, 112))
end

function search()
    local roll = fallout.do_check(fallout.dude_obj(), 1, 0)
    if fallout.global_var(30) ~= 0 then
        fallout.display_msg(fallout.message_str(86, 100))
    else
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(86, 101))
            fallout.set_local_var(1, 1)
        else
            fallout.game_time_advance(fallout.game_ticks(1200))
            fallout.display_msg(fallout.message_str(86, 102))
            fallout.set_local_var(1, 1)
        end
    end
end

function removal()
    local dude_obj = fallout.dude_obj()
    local intelligence_roll = fallout.do_check(dude_obj, 4, 0)
    local agility_roll = fallout.do_check(dude_obj, 5, 0)
    local repair_roll = fallout.roll_vs_skill(dude_obj, 13, bonus)
    if fallout.global_var(30) == 1 then
        fallout.display_msg(fallout.message_str(86, 103))
    else
        if fallout.is_success(intelligence_roll) or fallout.is_success(agility_roll) or fallout.is_success(repair_roll) then
            if fallout.global_var(31) == 2 then
                fallout.display_msg(fallout.message_str(86, 117))
            else
                fallout.display_msg(fallout.message_str(86, 104))
            end
            fallout.add_obj_to_inven(dude_obj, fallout.create_object_sid(55, 0, 0, -1))
            fallout.set_global_var(30, 1)
            fallout.set_global_var(552, time.game_time_in_days())
            if fallout.local_var(2) < 1 then
                fallout.set_local_var(2, 1)
                local xp = 2500 - (fallout.global_var(35) * 250)
                fallout.set_global_var(155, fallout.global_var(155) + 3)
                fallout.give_exp_points(xp)
                fallout.display_msg(fallout.message_str(86, 113) .. xp .. fallout.message_str(86, 114))
            end
        else
            if fallout.is_critical(intelligence_roll) or fallout.is_critical(agility_roll) or fallout.is_critical(repair_roll) then
                fallout.game_time_advance(fallout.game_ticks(3600))
                fallout.display_msg(fallout.message_str(86, 105))
            else
                fallout.display_msg(fallout.message_str(86, 106))
                fallout.game_time_advance(fallout.game_ticks(1800))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
