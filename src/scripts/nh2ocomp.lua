local fallout = require("fallout")
local time = require("lib.time")

local start
local search
local removal
local skills

local test = 0
local test1 = 0
local test2 = 0
local test3 = 0
local temp = 0
local use_skill = 0
local bonus = 20
local Character_Point = 0

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(86, 112))
    end
    if fallout.script_action() == 3 then
        fallout.script_overrides()
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 2 then
            search()
        else
            fallout.display_msg(fallout.message_str(86, 107))
        end
    else
        if fallout.script_action() == 6 then
            fallout.script_overrides()
            removal()
        else
            if fallout.script_action() == 8 then
                use_skill = fallout.action_being_used()
                fallout.script_overrides()
                if use_skill == 13 then
                    removal()
                else
                    skills()
                end
            else
                if fallout.script_action() == 7 then
                    if fallout.obj_pid(fallout.obj_being_used_with()) == 55 then
                        fallout.script_overrides()
                        fallout.display_msg(fallout.message_str(86, 110))
                        fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                        fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
                        fallout.set_global_var(30, 0)
                        fallout.set_global_var(101, 0)
                    else
                        fallout.display_msg(fallout.message_str(86, 111))
                    end
                end
            end
        end
    end
end

function search()
    test = fallout.do_check(fallout.dude_obj(), 1, 0)
    if fallout.global_var(30) ~= 0 then
        fallout.display_msg(fallout.message_str(86, 100))
    else
        if fallout.is_success(test) then
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
    test = fallout.do_check(fallout.dude_obj(), 4, 0)
    test1 = fallout.do_check(fallout.dude_obj(), 5, 0)
    test2 = fallout.roll_vs_skill(fallout.dude_obj(), 13, bonus)
    if fallout.global_var(30) == 1 then
        fallout.display_msg(fallout.message_str(86, 103))
    else
        if fallout.is_success(test) or fallout.is_success(test1) or fallout.is_success(test2) then
            if fallout.global_var(31) == 2 then
                fallout.display_msg(fallout.message_str(86, 117))
            else
                fallout.display_msg(fallout.message_str(86, 104))
            end
            fallout.add_obj_to_inven(fallout.dude_obj(), fallout.create_object_sid(55, 0, 0, -1))
            fallout.set_global_var(30, 1)
            fallout.set_global_var(552, time.game_time_in_days())
            if fallout.local_var(2) < 1 then
                fallout.set_local_var(2, 1)
                temp = 2500 - (fallout.global_var(35) * 250)
                fallout.set_global_var(155, fallout.global_var(155) + 3)
                fallout.give_exp_points(temp)
                fallout.display_msg(fallout.message_str(86, 113) .. temp .. fallout.message_str(86, 114))
            end
            Character_Point = Character_Point + 1
        else
            if fallout.is_critical(test) or fallout.is_critical(test1) or fallout.is_critical(test2) then
                fallout.game_time_advance(fallout.game_ticks(3600))
                fallout.display_msg(fallout.message_str(86, 105))
            else
                fallout.display_msg(fallout.message_str(86, 106))
                fallout.game_time_advance(fallout.game_ticks(1800))
            end
        end
    end
end

function skills()
    if use_skill == 12 then
        if fallout.global_var(30) ~= 0 then
            fallout.display_msg(fallout.message_str(86, 116))
        else
            test = fallout.roll_vs_skill(fallout.dude_obj(), 12, 20)
            if fallout.is_success(test) then
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

local exports = {}
exports.start = start
return exports
