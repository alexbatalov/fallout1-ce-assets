local fallout = require("fallout")

local start
local prepare_for_combat
local critter_p_proc
local timed_event_p_proc
local recover_from_combat

local initialized = false
local v = false
local student_armed = false
local instructor_armed = false
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
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 30)
        fallout.critter_add_trait(self_obj, 1, 5, 62)
        initialized = true
        prepare_for_combat()
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
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

function critter_p_proc()
    if not v then
        v = true
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 0)
    end
end

function timed_event_p_proc()
    if fall > 0 then
        recover_from_combat()
    else
        atk = fallout.random(0, 1)
        if atk ~= 0 then
            atk = 3
        end
        local x = fallout.random(1, 6)
        if who == 0 then
            if x < 3 then
                outcome = 0
            elseif x < 5 then
                outcome = 1
            else
                outcome = 2
            end
        else
            if x < 4 then
                outcome = 0
            elseif x < 6 then
                outcome = 1
            else
                outcome = 2
            end
        end
        sequence = atk + outcome

        local self_obj = fallout.self_obj()
        local student_obj = fallout.external_var("Student_ptr")
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(2, student_obj)
        fallout.reg_anim_func(1, 1)
        if who == 0 then
            if sequence == 0 then
                fallout.reg_anim_animate(student_obj, st_manuver0, -1)
                fallout.reg_anim_animate(self_obj, in_manuver2, 4)
            elseif sequence == 1 then
                fallout.reg_anim_animate(student_obj, st_manuver0, -1)
                fallout.reg_anim_animate(self_obj, 14, 4)
            elseif sequence == 2 then
                fall = 1
                fallout.reg_anim_animate(student_obj, st_manuver0, -1)
                fallout.reg_anim_animate(self_obj, 20, 4)
            elseif sequence == 3 then
                fallout.reg_anim_animate(student_obj, st_manuver1, -1)
                fallout.reg_anim_animate(self_obj, in_manuver2, 6)
            elseif sequence == 4 then
                fallout.reg_anim_animate(student_obj, st_manuver1, -1)
                fallout.reg_anim_animate(self_obj, 14, 6)
            elseif sequence == 5 then
                fall = 1
                fallout.reg_anim_animate(student_obj, st_manuver1, -1)
                fallout.reg_anim_animate(self_obj, 20, 6)
            end
        else
            if sequence == 0 then
                fallout.reg_anim_animate(self_obj, in_manuver0, -1)
                fallout.reg_anim_animate(student_obj, st_manuver2, 4)
            elseif sequence == 1 then
                fallout.reg_anim_animate(self_obj, in_manuver0, -1)
                fallout.reg_anim_animate(student_obj, 14, 4)
            elseif sequence == 2 then
                fall = 2
                fallout.reg_anim_animate(self_obj, in_manuver0, -1)
                fallout.reg_anim_animate(student_obj, 20, 4)
            elseif sequence == 3 then
                fallout.reg_anim_animate(self_obj, in_manuver1, -1)
                fallout.reg_anim_animate(student_obj, st_manuver2, 6)
            elseif sequence == 4 then
                fallout.reg_anim_animate(self_obj, in_manuver1, -1)
                fallout.reg_anim_animate(student_obj, 14, 6)
            elseif sequence == 5 then
                fall = 2
                fallout.reg_anim_animate(self_obj, in_manuver1, -1)
                fallout.reg_anim_animate(student_obj, 20, 6)
            end
        end
        fallout.reg_anim_func(3, 0)
        who = 1 - who
        fallout.add_timer_event(self_obj, fallout.game_ticks(2), 0)
    end
end

function recover_from_combat()
    local self_obj = fallout.self_obj()
    local student_obj = fallout.external_var("Student_ptr")
    fallout.reg_anim_func(2, self_obj)
    fallout.reg_anim_func(2, fallout.external_var("Student_ptr"))
    fallout.reg_anim_func(1, 1)
    if fall == 1 then
        fallout.reg_anim_animate(student_obj, 0, -1)
        fallout.reg_anim_animate(self_obj, 37, -1)
    else
        fallout.reg_anim_animate(self_obj, 0, -1)
        fallout.reg_anim_animate(student_obj, 37, -1)
    end
    fallout.reg_anim_func(3, 0)
    fall = 0
    v = false
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
