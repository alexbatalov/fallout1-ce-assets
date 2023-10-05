local fallout = require("fallout")

local start
local timed_event_p_proc

local gun_ptr = 0

function start()
    if fallout.script_action() == 22 then
        timed_event_p_proc()
    end
end

function timed_event_p_proc()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    if fallout.fixed_param() == 3 then
        fallout.metarule(13, 0)
    else
        if fallout.fixed_param() == 4 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(1, 500), -2)
            fallout.add_timer_event(fallout.dude_obj(), fallout.game_ticks(15), 3)
        else
            if fallout.fixed_param() == 5 then
                fallout.game_ui_disable()
                fallout.animate_move_obj_to_tile(fallout.map_var(0), 16890, 0)
                fallout.add_timer_event(fallout.dude_obj(), 5, 6)
            else
                if fallout.fixed_param() == 6 then
                    v0 = 0
                    if fallout.has_trait(2, fallout.dude_obj(), 8) then
                        v0 = 1
                    else
                        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                            v0 = 1
                        else
                            if fallout.global_var(155) < -1 then
                                v0 = 1
                            else
                                if fallout.global_var(158) > 2 then
                                    v0 = 1
                                end
                            end
                        end
                    end
                    if v0 == 1 then
                        gun_ptr = fallout.create_object_sid(8, 0, 0, -1)
                        fallout.add_obj_to_inven(fallout.dude_obj(), gun_ptr)
                        fallout.wield_obj_critter(fallout.dude_obj(), gun_ptr)
                        fallout.add_timer_event(fallout.dude_obj(), 25, 7)
                    else
                        fallout.add_timer_event(fallout.dude_obj(), 25, 8)
                    end
                else
                    if fallout.fixed_param() == 7 then
                        fallout.reg_anim_func(2, fallout.map_var(0))
                        fallout.reg_anim_func(1, 1)
                        fallout.reg_anim_animate(fallout.dude_obj(), 43, -1)
                        v1 = fallout.sfx_build_weapon_name(1, gun_ptr, v2, fallout.map_var(0))
                        fallout.reg_anim_play_sfx(fallout.dude_obj(), v1, -1)
                        fallout.reg_anim_animate(fallout.dude_obj(), 45, -1)
                        v1 = fallout.sfx_build_char_name(fallout.map_var(0), 20, 3)
                        fallout.reg_anim_play_sfx(fallout.map_var(0), v1, 0)
                        fallout.reg_anim_animate(fallout.map_var(0), 20, 0)
                        fallout.reg_anim_animate(fallout.dude_obj(), 44, 0)
                        fallout.reg_anim_func(3, 0)
                        fallout.add_timer_event(fallout.dude_obj(), fallout.game_ticks(11), 8)
                    else
                        if fallout.fixed_param() == 8 then
                            fallout.game_ui_enable()
                            fallout.endgame_movie()
                            fallout.metarule(13, 0)
                        end
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.timed_event_p_proc = timed_event_p_proc
return exports
