local fallout = require("fallout")

local start
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    if fallout.global_var(31) ~= 2 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(87, 112))
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    if fallout.obj_pid(item_obj) == 98 then
        fallout.script_overrides()
        local dude_obj = fallout.dude_obj()
        local roll = fallout.roll_vs_skill(dude_obj, 13, -5)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(87, 114))
            fallout.rm_obj_from_inven(dude_obj, item_obj)
            fallout.add_obj_to_inven(fallout.self_obj(), item_obj)
            fallout.set_global_var(31, 2)
            fallout.set_global_var(227, 0)
            fallout.set_global_var(155, fallout.global_var(155) + 1)
            fallout.give_exp_points(1000)
            fallout.display_msg(fallout.message_str(87, 118))
        else
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(87, 115))
                fallout.game_time_advance(fallout.game_ticks(240))
                fallout.rm_obj_from_inven(dude_obj, item_obj)
                fallout.critter_dmg(dude_obj, 1, 0)
            else
                fallout.display_msg(fallout.message_str(87, 116))
                fallout.game_time_advance(fallout.game_ticks(180))
            end
        end
    else
        fallout.display_msg(fallout.message_str(87, 117))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    local roll = fallout.do_check(fallout.dude_obj(), 4, 0)
    if fallout.global_var(31) == 2 then
        fallout.display_msg(fallout.message_str(87, 100))
    else
        if fallout.is_success(roll) then
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(87, 101))
            else
                fallout.display_msg(fallout.message_str(87, 102))
            end
        else
            fallout.display_msg(fallout.message_str(87, 103))
        end
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    fallout.script_overrides()
    if skill == 13 then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(87, 108))
        else
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(87, 107))
            else
                fallout.display_msg(fallout.message_str(87, 109))
            end
        end
    elseif skill == 12 then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 12, -20)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(87, 111))
        else
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(87, 110))
            else
                fallout.display_msg(fallout.message_str(87, 112))
            end
        end
    else
        fallout.display_msg(fallout.message_str(87, 113))
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
