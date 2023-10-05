local fallout = require("fallout")

local start
local search
local skills

local test = 0
local test1 = 0
local test2 = 0
local test3 = 0
local use_skill = 0

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        search()
    else
        if fallout.script_action() == 8 then
            use_skill = fallout.action_being_used()
            fallout.script_overrides()
            skills()
        else
            if fallout.script_action() == 6 then
                if fallout.global_var(31) ~= 2 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(87, 112))
                end
            else
                if fallout.script_action() == 7 then
                    if fallout.obj_pid(fallout.obj_being_used_with()) == 98 then
                        fallout.script_overrides()
                        test2 = fallout.roll_vs_skill(fallout.dude_obj(), 13, -5)
                        if fallout.is_success(test2) then
                            fallout.display_msg(fallout.message_str(87, 114))
                            fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                            fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
                            fallout.set_global_var(31, 2)
                            fallout.set_global_var(227, 0)
                            fallout.set_global_var(155, fallout.global_var(155) + 1)
                            fallout.give_exp_points(1000)
                            fallout.display_msg(fallout.message_str(87, 118))
                        else
                            if fallout.is_critical(test2) then
                                fallout.display_msg(fallout.message_str(87, 115))
                                fallout.game_time_advance(fallout.game_ticks(240))
                                fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
                                fallout.critter_dmg(fallout.dude_obj(), 1, 0)
                            else
                                fallout.display_msg(fallout.message_str(87, 116))
                                fallout.game_time_advance(fallout.game_ticks(180))
                            end
                        end
                    else
                        fallout.display_msg(fallout.message_str(87, 117))
                    end
                end
            end
        end
    end
end

function search()
    test = fallout.do_check(fallout.dude_obj(), 4, 0)
    if fallout.global_var(31) == 2 then
        fallout.display_msg(fallout.message_str(87, 100))
    else
        if fallout.is_success(test) then
            if fallout.is_critical(test) then
                fallout.display_msg(fallout.message_str(87, 101))
            else
                fallout.display_msg(fallout.message_str(87, 102))
            end
        else
            fallout.display_msg(fallout.message_str(87, 103))
        end
    end
end

function skills()
    test1 = fallout.roll_vs_skill(fallout.dude_obj(), 12, -10)
    test2 = fallout.roll_vs_skill(fallout.dude_obj(), 13, 0)
    test3 = fallout.roll_vs_skill(fallout.dude_obj(), 12, -20)
    if use_skill == 13 then
        if fallout.is_success(test2) then
            fallout.display_msg(fallout.message_str(87, 108))
        else
            if fallout.is_critical(test2) then
                fallout.display_msg(fallout.message_str(87, 107))
            else
                fallout.display_msg(fallout.message_str(87, 109))
            end
        end
    else
        if use_skill == 12 then
            if fallout.is_success(test3) then
                fallout.display_msg(fallout.message_str(87, 111))
            else
                if fallout.is_critical(test3) then
                    fallout.display_msg(fallout.message_str(87, 110))
                else
                    fallout.display_msg(fallout.message_str(87, 112))
                end
            end
        else
            fallout.display_msg(fallout.message_str(87, 113))
        end
    end
end

local exports = {}
exports.start = start
return exports
