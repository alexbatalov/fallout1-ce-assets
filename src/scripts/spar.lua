local fallout = require("fallout")

local start
local weapon_check
local prepare_for_combat
local do_combat
local recover_from_combat

local initialized = 0
local armed = 0
local v = 0
local x = 0
local student_armed = 0
local instructor_armed = 0
local st_manuver0 = 0
local st_manuver1 = 0
local st_manuver2 = 0
local in_manuver0 = 0
local in_manuver1 = 0
local in_manuver2 = 0
local outcome = 0
local sequence = 0
local atk = 0
local who = 0
local fall = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 62)
        initialized = 1
        prepare_for_combat()
    end
    if fallout.script_action() == 22 then
        do_combat()
    else
        if (fallout.script_action() == 12) and (v ~= 1) then
            v = 1
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 0)
        end
    end
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.external_var("Student_ptr"), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.external_var("Student_ptr"), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

function prepare_for_combat()
    if student_armed then
        st_manuver0 = 41
        st_manuver1 = 42
        st_manuver2 = 40
    else
        st_manuver0 = 16
        st_manuver1 = 17
        st_manuver2 = 13
    end
    if instructor_armed then
        in_manuver0 = 41
        in_manuver1 = 42
        in_manuver2 = 40
    else
        in_manuver0 = 16
        in_manuver1 = 17
        in_manuver2 = 13
    end
end

function do_combat()
    if fall > 0 then
        recover_from_combat()
    else
        atk = fallout.random(0, 1)
        if atk then
            atk = 3
        end
        x = fallout.random(1, 6)
        if who == 0 then
            if x < 3 then
                outcome = 0
            else
                if x < 5 then
                    outcome = 1
                else
                    outcome = 2
                end
            end
        else
            if x < 4 then
                outcome = 0
            else
                if x < 6 then
                    outcome = 1
                else
                    outcome = 2
                end
            end
        end
        sequence = atk + outcome
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(2, fallout.external_var("Student_ptr"))
        fallout.reg_anim_func(1, 1)
        if who == 0 then
            if sequence == 0 then
                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver0, -1)
                fallout.reg_anim_animate(fallout.self_obj(), in_manuver2, 4)
            else
                if sequence == 1 then
                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver0, -1)
                    fallout.reg_anim_animate(fallout.self_obj(), 14, 4)
                else
                    if sequence == 2 then
                        fall = 1
                        fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver0, -1)
                        fallout.reg_anim_animate(fallout.self_obj(), 20, 4)
                    else
                        if sequence == 3 then
                            fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver1, -1)
                            fallout.reg_anim_animate(fallout.self_obj(), in_manuver2, 6)
                        else
                            if sequence == 4 then
                                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver1, -1)
                                fallout.reg_anim_animate(fallout.self_obj(), 14, 6)
                            else
                                if sequence == 5 then
                                    fall = 1
                                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver1, -1)
                                    fallout.reg_anim_animate(fallout.self_obj(), 20, 6)
                                end
                            end
                        end
                    end
                end
            end
        else
            if sequence == 0 then
                fallout.reg_anim_animate(fallout.self_obj(), in_manuver0, -1)
                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver2, 4)
            else
                if sequence == 1 then
                    fallout.reg_anim_animate(fallout.self_obj(), in_manuver0, -1)
                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 14, 4)
                else
                    if sequence == 2 then
                        fall = 2
                        fallout.reg_anim_animate(fallout.self_obj(), in_manuver0, -1)
                        fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 20, 4)
                    else
                        if sequence == 3 then
                            fallout.reg_anim_animate(fallout.self_obj(), in_manuver1, -1)
                            fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver2, 6)
                        else
                            if sequence == 4 then
                                fallout.reg_anim_animate(fallout.self_obj(), in_manuver1, -1)
                                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 14, 6)
                            else
                                if sequence == 5 then
                                    fall = 2
                                    fallout.reg_anim_animate(fallout.self_obj(), in_manuver1, -1)
                                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 20, 6)
                                end
                            end
                        end
                    end
                end
            end
        end
        fallout.reg_anim_func(3, 0)
        who = 1 - who
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 0)
    end
end

function recover_from_combat()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(2, fallout.external_var("Student_ptr"))
    fallout.reg_anim_func(1, 1)
    if fall == 1 then
        fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 0, -1)
        fallout.reg_anim_animate(fallout.self_obj(), 37, -1)
    else
        fallout.reg_anim_animate(fallout.self_obj(), 0, -1)
        fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 37, -1)
    end
    fallout.reg_anim_func(3, 0)
    fall = 0
    v = 0
end

local exports = {}
exports.start = start
return exports
