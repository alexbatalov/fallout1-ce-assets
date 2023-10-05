local fallout = require("fallout")

local start
local weapon_check
local give_skill
local prepare_for_combat
local do_combat
local recover_from_combat
local pick_a_student
local praise
local lesson1
local destroy_p_proc
local critter_p_proc

local initialized = 0
local armed = 0
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
local fell = 0
local st_dodge = 0
local st_fall = 0
local my_knife = 0
local delay = 0
local wait2 = 0
local wait3 = 0
local my_hex = 0
local lesson_ptr = 0
local valid = 0
local temp = 0
local comment = 0
local phase = 0
local hostile = 0
local skill_pts = 0

local do_round

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
        my_hex = fallout.tile_num(fallout.self_obj())
        fallout.set_map_var(1, fallout.tile_num_in_direction(my_hex, 4, 1))
        my_knife = fallout.obj_carrying_pid_obj(fallout.self_obj(), 4)
        who = fallout.local_var(1)
        fell = fallout.local_var(2)
        st_fall = fallout.local_var(4)
        st_dodge = fallout.local_var(3)
        lesson_ptr = fallout.local_var(5)
        if who < 1 then
            who = 0
        end
        if fell < 1 then
            fell = 0
        end
        prepare_for_combat()
        fallout.set_external_var("Student_ptr", 0)
        valid = 1
        initialized = 1
    end
    if fallout.script_action() == 18 then
        destroy_p_proc()
    end
    if fallout.script_action() == 22 then
        if fallout.global_var(250) == 0 then
            if (valid == 1) and (fallout.external_var("Student_ptr") ~= 0) then
                do_combat()
            else
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 0)
            end
        end
    else
        if fallout.script_action() == 12 then
            if fallout.global_var(250) then
                hostile = 1
            end
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
                hostile = 0
            end
            if hostile then
                fallout.set_global_var(250, 1)
                hostile = 0
                fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
            if fallout.global_var(250) == 0 then
                critter_p_proc()
            end
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

function give_skill()
    fallout.set_local_var(11, fallout.local_var(11) + 1)
    skill_pts = 1
    fallout.display_msg(fallout.message_str(766, 116) + skill_pts + fallout.message_str(766, 120))
    fallout.critter_mod_skill(fallout.dude_obj(), 3, skill_pts)
    fallout.display_msg(fallout.message_str(766, 116) + skill_pts + fallout.message_str(766, 121))
    fallout.critter_mod_skill(fallout.dude_obj(), 4, skill_pts)
end

function prepare_for_combat()
    if student_armed then
        st_manuver0 = 41
        st_manuver1 = 42
        st_manuver2 = 40
        wait3 = 0
    else
        st_manuver0 = 16
        st_manuver1 = 17
        st_manuver2 = 13
        wait3 = 4
    end
    if instructor_armed then
        in_manuver0 = 41
        in_manuver1 = 42
        in_manuver2 = 40
        wait2 = 0
    else
        in_manuver0 = 16
        in_manuver1 = 17
        in_manuver2 = 13
        wait2 = 4
    end
end

function do_combat()
    if fallout.local_var(0) > 1 then
        if fallout.local_var(0) == 2 then
            lesson1()
        end
    else
        if comment then
            if fallout.random(1, 10) < comment then
                praise()
            end
            comment = 0
        end
        if fell > 0 then
            recover_from_combat()
        else
            phase = phase + 1
            atk = fallout.random(0, 1)
            if atk then
                atk = 3
            end
            x = fallout.random(1, 100)
            if who == 0 then
                if x < 81 then
                    outcome = 0
                else
                    if x < 98 then
                        comment = 3
                        outcome = 1
                    else
                        if phase > 6 then
                            comment = 6
                            outcome = 2
                        else
                            comment = 3
                            outcome = 1
                        end
                    end
                end
            else
                if x < st_fall then
                    comment = 6
                    outcome = 2
                else
                    if x < st_dodge then
                        comment = 3
                        outcome = 0
                    else
                        comment = 4
                        st_fall = st_fall + 2
                        fallout.set_local_var(4, st_fall)
                        outcome = 1
                    end
                end
            end
            sequence = atk + outcome
            if fallout.local_var(10) then
                do_round()
            else
                fell = 2
                who = 0
                fallout.set_local_var(2, fell)
                fallout.set_local_var(1, who)
            end
            who = 1 - who
            fallout.set_local_var(1, who)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 0)
        end
    end
end

function recover_from_combat()
    if fallout.local_var(10) == 1 then
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(2, fallout.external_var("Student_ptr"))
        fallout.reg_anim_func(1, 1)
        if fell == 1 then
            fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 0, -1)
            fallout.reg_anim_animate(fallout.self_obj(), 37, -1)
        else
            fallout.reg_anim_animate(fallout.self_obj(), 0, -1)
            fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 37, -1)
        end
        fallout.reg_anim_func(3, 0)
    else
        fallout.set_local_var(10, 1)
    end
    fallout.set_local_var(7, 0)
    fell = 0
    fallout.set_local_var(2, fell)
    fallout.set_local_var(0, 0)
    fallout.set_map_var(0, 0)
end

function pick_a_student()
    fell = 0
    fallout.set_local_var(2, fell)
    fallout.set_map_var(0, 0)
    temp = fallout.random(1, fallout.map_var(5))
    fallout.set_local_var(8, temp)
    if temp == fallout.local_var(9) then
        fallout.set_local_var(8, fallout.local_var(9) + 1)
        if fallout.local_var(8) > fallout.map_var(5) then
            fallout.set_local_var(8, 1)
        end
    end
    fallout.set_map_var(2, fallout.local_var(8))
    fallout.set_local_var(9, fallout.local_var(8))
    student_armed = 0
    instructor_armed = 0
    if instructor_armed then
        fallout.wield_obj_critter(fallout.self_obj(), my_knife)
    end
    st_fall = fallout.random(5, 15) + 1
    fallout.set_local_var(4, st_fall)
    st_dodge = fallout.random(20, 40) + 1
    fallout.set_local_var(3, st_dodge)
end

function praise()
    temp = fallout.random(0, 2)
    if comment == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 200 + temp), 3)
    else
        if comment == 4 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 203 + temp), 3)
        else
            if comment == 6 then
                if fell == 2 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 206 + temp), 3)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 209 + temp), 3)
                end
            end
        end
    end
end

function lesson1()
    delay = 4
    if lesson_ptr < 6 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 100 + lesson_ptr), 3)
    else
        if lesson_ptr == 6 then
            who = 0
            sequence = 0
            delay = 2
            do_round()
        else
            if lesson_ptr == 7 then
                who = 0
                sequence = 0
                delay = 2
                do_round()
            else
                if lesson_ptr == 8 then
                    who = 1
                    sequence = 1
                    delay = 2
                    do_round()
                else
                    if (lesson_ptr > 8) and (lesson_ptr < 12) then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 100 + lesson_ptr), 3)
                    else
                        if lesson_ptr == 12 then
                            fallout.float_msg(fallout.external_var("Student_ptr"), fallout.message_str(633, 112), 8)
                        else
                            if lesson_ptr == 13 then
                                fallout.float_msg(fallout.external_var("Student_ptr"), fallout.message_str(633, 113), 8)
                            else
                                if (lesson_ptr > 13) and (lesson_ptr < 18) then
                                    if fallout.obj_can_see_obj(fallout.dude_obj(), fallout.self_obj()) then
                                        give_skill()
                                    end
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 100 + lesson_ptr), 3)
                                else
                                    if lesson_ptr == 19 then
                                        if fallout.obj_can_see_obj(fallout.dude_obj(), fallout.self_obj()) then
                                            give_skill()
                                        end
                                        pick_a_student()
                                    else
                                        if lesson_ptr == 20 then
                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 118), 3)
                                        else
                                            if lesson_ptr == 21 then
                                                who = 0
                                                sequence = 0
                                                delay = 2
                                                do_round()
                                            else
                                                if lesson_ptr == 22 then
                                                    who = 0
                                                    sequence = 0
                                                    delay = 2
                                                    do_round()
                                                else
                                                    if lesson_ptr == 23 then
                                                        who = 1
                                                        sequence = 0
                                                        delay = 2
                                                        do_round()
                                                    else
                                                        if lesson_ptr == 24 then
                                                            who = 0
                                                            sequence = 0
                                                            delay = 2
                                                            do_round()
                                                        else
                                                            if lesson_ptr == 25 then
                                                                fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 119), 3)
                                                            else
                                                                if lesson_ptr == 26 then
                                                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 120), 3)
                                                                else
                                                                    if lesson_ptr == 27 then
                                                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 121), 3)
                                                                    else
                                                                        if lesson_ptr == 28 then
                                                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 122), 3)
                                                                        else
                                                                            if lesson_ptr == 29 then
                                                                                fallout.float_msg(fallout.external_var("Student_ptr"), fallout.message_str(633, 107), 8)
                                                                            else
                                                                                if lesson_ptr == 30 then
                                                                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 123), 3)
                                                                                else
                                                                                    if lesson_ptr == 31 then
                                                                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 124), 3)
                                                                                    else
                                                                                        if lesson_ptr == 32 then
                                                                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 125), 3)
                                                                                        else
                                                                                            if lesson_ptr == 33 then
                                                                                                fallout.float_msg(fallout.external_var("Student_ptr"), fallout.message_str(633, 126), 8)
                                                                                            else
                                                                                                if lesson_ptr == 34 then
                                                                                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 127), 3)
                                                                                                else
                                                                                                    if lesson_ptr == 35 then
                                                                                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 128), 3)
                                                                                                    else
                                                                                                        if lesson_ptr == 36 then
                                                                                                            fallout.float_msg(fallout.self_obj(), fallout.message_str(633, 108), 3)
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    lesson_ptr = lesson_ptr + 1
    fallout.set_local_var(5, lesson_ptr)
    if lesson_ptr > 36 then
        fallout.set_local_var(0, 0)
        fallout.set_local_var(6, 1)
        if fallout.local_var(11) > 4 then
            fallout.display_msg(fallout.message_str(633, 300))
            fallout.give_exp_points(500)
        end
    else
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(delay), 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function critter_p_proc()
    if fallout.map_var(0) == 1 then
        if fallout.local_var(0) < 1 then
            fallout.set_local_var(0, 1)
            phase = 0
            if fallout.obj_can_see_obj(fallout.dude_obj(), fallout.self_obj()) then
                if fallout.local_var(6) ~= 1 then
                    lesson_ptr = 1
                    fallout.set_local_var(5, lesson_ptr)
                    fallout.set_local_var(0, 2)
                end
            end
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 0)
        end
    else
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, 1)
            pick_a_student()
        end
    end
end

function do_round()
    fallout.set_local_var(1, who)
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(2, fallout.external_var("Student_ptr"))
    fallout.reg_anim_func(1, 1)
    if who == 0 then
        if student_armed then
            student_armed = 0
        else
            if sequence == 0 then
                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver0, -1)
                fallout.reg_anim_animate(fallout.self_obj(), in_manuver2, wait2)
            else
                if sequence == 1 then
                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver0, -1)
                    fallout.reg_anim_animate(fallout.self_obj(), 14, 4)
                else
                    if sequence == 2 then
                        fell = 1
                        fallout.set_local_var(2, fell)
                        fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver0, -1)
                        fallout.reg_anim_animate(fallout.self_obj(), 20, 4)
                    else
                        if sequence == 3 then
                            fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver1, -1)
                            fallout.reg_anim_animate(fallout.self_obj(), in_manuver2, wait2 + 2)
                        else
                            if sequence == 4 then
                                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver1, -1)
                                fallout.reg_anim_animate(fallout.self_obj(), 14, 6)
                            else
                                if sequence == 5 then
                                    fell = 1
                                    fallout.set_local_var(2, fell)
                                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver1, -1)
                                    fallout.reg_anim_animate(fallout.self_obj(), 20, 6)
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        if fallout.local_var(10) == 0 then
            fallout.set_local_var(10, 1)
            sequence = 5
        end
        if instructor_armed then
            instructor_armed = 0
        else
            if sequence == 0 then
                fallout.reg_anim_animate(fallout.self_obj(), in_manuver0, -1)
                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver2, wait3)
            else
                if sequence == 1 then
                    fallout.reg_anim_animate(fallout.self_obj(), in_manuver0, -1)
                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 14, 4)
                else
                    if sequence == 2 then
                        fell = 2
                        fallout.set_local_var(2, fell)
                        fallout.reg_anim_animate(fallout.self_obj(), in_manuver0, -1)
                        fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 20, 4)
                    else
                        if sequence == 3 then
                            fallout.reg_anim_animate(fallout.self_obj(), in_manuver1, -1)
                            fallout.reg_anim_animate(fallout.external_var("Student_ptr"), st_manuver2, wait3 + 2)
                        else
                            if sequence == 4 then
                                fallout.reg_anim_animate(fallout.self_obj(), in_manuver1, -1)
                                fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 14, 6)
                            else
                                if sequence == 5 then
                                    fell = 2
                                    fallout.set_local_var(2, fell)
                                    fallout.reg_anim_animate(fallout.self_obj(), in_manuver1, -1)
                                    fallout.reg_anim_animate(fallout.external_var("Student_ptr"), 20, 6)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.reg_anim_func(3, 0)
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
return exports
