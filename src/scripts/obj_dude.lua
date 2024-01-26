local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local timed_event_p_proc

local gun_ptr = nil

function start()
    if fallout.script_action() == 22 then
        timed_event_p_proc()
    end
end

function timed_event_p_proc()
    local dude_obj = fallout.dude_obj()
    local event = fallout.fixed_param()
    if event == 3 then
        misc.signal_end_game()
    elseif event == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(1, 500), -2)
        fallout.add_timer_event(dude_obj, fallout.game_ticks(15), 3)
    elseif event == 5 then
        fallout.game_ui_disable()
        fallout.animate_move_obj_to_tile(fallout.map_var(0), 16890, 0)
        fallout.add_timer_event(dude_obj, 5, 6)
    elseif event == 6 then
        local shoot_overseer = false
        if fallout.has_trait(2, dude_obj, 8) then
            shoot_overseer = true
        elseif reputation.has_rep_berserker() then
            shoot_overseer = true
        elseif fallout.global_var(155) < -1 then
            shoot_overseer = true
        elseif fallout.global_var(158) > 2 then
            shoot_overseer = true
        end
        if shoot_overseer then
            gun_ptr = fallout.create_object_sid(8, 0, 0, -1)
            fallout.add_obj_to_inven(dude_obj, gun_ptr)
            fallout.wield_obj_critter(dude_obj, gun_ptr)
            fallout.add_timer_event(dude_obj, 25, 7)
        else
            fallout.add_timer_event(dude_obj, 25, 8)
        end
    elseif event == 7 then
        local overseer_obj = fallout.map_var(0)
        local sfx
        fallout.reg_anim_func(2, overseer_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(dude_obj, 43, -1)
        sfx = fallout.sfx_build_weapon_name(1, gun_ptr, 0, overseer_obj)
        fallout.reg_anim_play_sfx(dude_obj, sfx, -1)
        fallout.reg_anim_animate(dude_obj, 45, -1)
        sfx = fallout.sfx_build_char_name(overseer_obj, 20, 3)
        fallout.reg_anim_play_sfx(overseer_obj, sfx, 0)
        fallout.reg_anim_animate(overseer_obj, 20, 0)
        fallout.reg_anim_animate(dude_obj, 44, 0)
        fallout.reg_anim_func(3, 0)
        fallout.add_timer_event(dude_obj, fallout.game_ticks(11), 8)
    elseif event == 8 then
        fallout.game_ui_enable()
        fallout.endgame_movie()
        misc.signal_end_game()
    end
end

local exports = {}
exports.start = start
exports.timed_event_p_proc = timed_event_p_proc
return exports
