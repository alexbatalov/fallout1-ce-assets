local fallout = require("fallout")
local time = require("lib.time")

local start
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local armit
local disarmit
local reset

local lockmod = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    end
end

function use_p_proc()
    fallout.set_map_var(5, 1)
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(448, 100))
    local my_iq = fallout.get_critter_stat(fallout.dude_obj(), 4)
    local my_pe = fallout.get_critter_stat(fallout.dude_obj(), 1)
    local roll
    if my_iq < my_pe then
        roll = fallout.do_check(fallout.dude_obj(), 4, 0)
    else
        roll = fallout.do_check(fallout.dude_obj(), 1, 0)
    end
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(448, 101))
    end
end

function use_obj_on_p_proc()
    fallout.set_map_var(5, 1)
    local pid = fallout.obj_pid(fallout.obj_being_used_with())
    if pid == 105 then
        fallout.script_overrides()
        if fallout.external_var("BOMB_ARMED") == 1 then
            if fallout.external_var("MASTER_HAS_ARMED") == 1 then
                fallout.display_msg(fallout.message_str(448, 105))
            else
                disarmit()
            end
        else
            armit()
        end
    else
        if pid == 77 then
            lockmod = 40
        else
            fallout.display_msg(fallout.message_str(448, 105))
        end
    end
end

function use_skill_on_p_proc()
    fallout.set_map_var(5, 1)
    local skill = fallout.action_being_used()
    fallout.script_overrides()
    if fallout.external_var("BOMB_ARMED") == 1 then
        fallout.display_msg(fallout.message_str(448, 105))
    else
        if skill == 12 then
            if fallout.has_skill(fallout.dude_obj(), 12) < 70 then
                fallout.display_msg(fallout.message_str(448, 112))
            else
                local roll = fallout.roll_vs_skill(fallout.dude_obj(), 12, -40)
                if fallout.is_success(roll) then
                    armit()
                else
                    fallout.display_msg(fallout.message_str(448, 112))
                end
            end
        elseif skill == 9 then
            if fallout.has_skill(fallout.dude_obj(), 13) < 70 then
                fallout.display_msg(fallout.message_str(448, 112))
            else
                local roll = fallout.roll_vs_skill(fallout.dude_obj(), 9, lockmod - 60)
                if fallout.is_success(roll) then
                    armit()
                else
                    fallout.display_msg(fallout.message_str(448, 112))
                end
            end
        elseif skill == 11 then
            fallout.display_msg(fallout.message_str(448, 111))
        elseif skill == 13 then
            fallout.display_msg(fallout.message_str(448, 110))
        else
            fallout.display_msg(fallout.message_str(448, 105))
        end
    end
end

function armit()
    fallout.display_msg(fallout.message_str(448, 102))
    if fallout.global_var(55) == 0 then
        fallout.set_global_var(55, time.game_time_in_seconds())
    end
    fallout.set_global_var(18, 1)
    if fallout.global_var(17) == 0 then
        fallout.set_global_var(51, 1)
    end
end

function disarmit()
    if time.game_time_in_seconds() - fallout.global_var(55) > 30 or fallout.external_var("SKILL_USED") == 1 then
        reset()
    else
        fallout.set_external_var("KEY_USED", 1)
        fallout.display_msg(fallout.message_str(448, 105))
    end
end

function reset()
    fallout.display_msg(fallout.message_str(448, 103))
    fallout.set_global_var(55, 0)
    fallout.set_global_var(18, 0)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
