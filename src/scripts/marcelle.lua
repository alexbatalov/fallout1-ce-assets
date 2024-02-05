local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Marcelles00
local Marcelles01
local Marcelles02
local Marcelles02a
local Marcelles03
local Marcelles04
local Marcelles05
local Marcelles06
local Marcelles07
local Marcelles08
local Marcelles08a
local Marcelles08b
local Marcelles09
local Marcelles10
local Marcelles11
local Marcelles12
local Marcelles13
local Marcelles14
local Marcelles14a
local Marcelles15
local Marcelles16
local Marcelles17
local Marcelles17a
local Marcelles18
local Marcelles18a
local Marcelles19
local Marcelles19a
local Marcelles19b
local Marcelles20
local Marcelles21
local Marcelles22
local Marcelles23
local Marcelles24
local Marcelles24a
local Marcelles25
local Marcelles26
local Marcelles26a
local Marcelles27
local Marcelles28
local Marcelles29
local Marcelles29a
local Marcelles30
local Marcelles31
local Marcelles32
local Marcelles33
local go_to_room
local MarcellesEnd
local Marcelles_charge_raider

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local Bessy = nil
local hostile = false
local moving_disabled = false
local showing_room = false
local sleeping_disabled = false
local desk_tile = 19901
local dest_tile = 19901
local room_tile = 19289
local waiting_tile = 19095
local line00flag = false
local line04flag = false
local line06flag = false
local line29flag = false
local Shooting = false

local map_update_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if not Shooting then
            local self_obj = fallout.self_obj()
            local self_tile_num = fallout.tile_num(self_obj)
            local dude_obj = fallout.dude_obj()
            local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
            if not moving_disabled and fallout.local_var(5) == 0 then
                if self_tile_num ~= dest_tile then
                    fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
                end
            end
            if showing_room then
                dest_tile = room_tile
                if self_tile_num ~= dest_tile then
                    fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
                else
                    fallout.add_timer_event(self_obj, fallout.game_ticks(5), 1)
                    showing_room = false
                end
            else
                if self_can_see_dude and fallout.external_var("messing_with_fridge") ~= 0 then
                    Marcelles33()
                end
            end
            if fallout.global_var(143) ~= 2 and fallout.map_var(3) ~= 0 then
                if self_tile_num ~= waiting_tile then
                    if fallout.local_var(5) ~= 0 then
                        fallout.set_local_var(5, 0)
                        sleeping_disabled = true
                    else
                        showing_room = false
                        fallout.rm_timer_event(self_obj)
                        dest_tile = waiting_tile
                    end
                end
                if fallout.global_var(143) == 0 then
                    if self_can_see_dude then
                        if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                            if not line00flag then
                                if self_tile_num == waiting_tile then
                                    fallout.dialogue_system_enter()
                                end
                            end
                        end
                    end
                end
            else
                if fallout.global_var(143) == 2 or fallout.map_var(0) == 2 then
                    if self_tile_num ~= sleep_tile and sleeping_disabled then
                        dest_tile = sleep_tile
                    else
                        sleeping_disabled = false
                    end
                    moving_disabled = false
                end
            end
            if fallout.tile_distance(fallout.tile_num(dude_obj), desk_tile) < 8 then
                if fallout.local_var(5) == 1 then
                    dest_tile = desk_tile
                    moving_disabled = false
                    sleeping_disabled = true
                end
            else
                sleeping_disabled = false
            end
            if not sleeping_disabled then
                behaviour.sleeping(5, night_person, wake_time, sleep_time, home_tile, sleep_tile)
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(339, 100))
    else
        fallout.display_msg(fallout.message_str(339, 101))
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.obj_carrying_pid_obj(self_obj, 94) then
        Bessy = fallout.obj_carrying_pid_obj(self_obj, 94)
    else
        Bessy = fallout.create_object_sid(94, 0, 0, -1)
        fallout.add_obj_to_inven(self_obj, Bessy)
    end
    misc.set_team(self_obj, 16)
    sleep_tile = 20509
    home_tile = 19901
    wake_time = 600
    sleep_time = 1900
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.local_var(5) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
    else
        local self_obj = fallout.self_obj()
        local self_tile_num = fallout.tile_num(self_obj)
        if self_tile_num ~= home_tile and self_tile_num ~= waiting_tile then
            fallout.script_overrides()
        else
            reaction.get_reaction()
            fallout.start_gdialog(339, self_obj, 4, -1, -1)
            fallout.gsay_start()
            if fallout.global_var(143) == 0 and not line00flag and fallout.map_var(3) ~= 0 then
                Marcelles00()
            elseif fallout.global_var(143) == 1 then
                Marcelles03()
            elseif fallout.global_var(143) == 2 and not line04flag and fallout.map_var(0) ~= 2 then
                Marcelles04()
            elseif fallout.map_var(0) == 2 and not line06flag then
                Marcelles06()
            elseif fallout.global_var(105) == 2 and not line29flag then
                Marcelles29()
            elseif fallout.local_var(4) == 0 then
                Marcelles07()
            elseif fallout.local_var(1) < 2 then
                Marcelles22()
            else
                Marcelles17()
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    sleeping_disabled = false
    if showing_room then
        go_to_room()
    end
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 2)
    elseif event == 2 then
        dest_tile = home_tile
        moving_disabled = false
    elseif event == 3 then
        local self_obj = fallout.self_obj()
        if fallout.tile_distance(fallout.tile_num(self_obj), 18089) > 2 then
            fallout.animate_move_obj_to_tile(self_obj, 18089, 1)
            fallout.add_timer_event(self_obj, 5, 3)
        else
            fallout.add_timer_event(self_obj, 5, 4)
        end
    elseif event == 4 then
        local raider_obj = fallout.external_var("JTRaider_ptr")
        local self_obj = fallout.self_obj()
        fallout.reg_anim_func(2, raider_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(raider_obj, 43, -1)
        fallout.reg_anim_animate(raider_obj, 45, -1)
        fallout.reg_anim_animate(raider_obj, 44, -1)
        fallout.reg_anim_func(3, 0)
        fallout.critter_dmg(fallout.external_var("Sinthia_ptr"), fallout.random(75, 100), 0)
        fallout.add_timer_event(self_obj, 5, 5)
        if fallout.obj_is_carrying_obj_pid(self_obj, 94) == 0 then
            Bessy = fallout.create_object_sid(94, 0, 0, -1)
            fallout.add_obj_to_inven(self_obj, Bessy)
        end
        fallout.wield_obj_critter(self_obj, fallout.obj_carrying_pid_obj(self_obj, 94))
    elseif event == 5 then
        local raider_obj = fallout.external_var("JTRaider_ptr")
        local self_obj = fallout.self_obj()
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(self_obj, 43, -1)
        fallout.reg_anim_animate(self_obj, 45, -1)
        local sfx_name = fallout.sfx_build_weapon_name(1, fallout.obj_carrying_pid_obj(self_obj, 94),
            0, raider_obj)
        fallout.reg_anim_play_sfx(self_obj, sfx_name, 0)
        fallout.reg_anim_animate(self_obj, 44, -1)
        fallout.reg_anim_func(3, 0)
        fallout.critter_dmg(raider_obj, fallout.random(75, 100), 0)
        Shooting = false
        fallout.game_ui_enable()
    elseif event == 6 then
        if fallout.global_var(143) ~= 2 then
            Marcelles_charge_raider()
        end
    end
end

function Marcelles00()
    line00flag = true
    fallout.set_global_var(143, 1)
    fallout.gsay_reply(339, 102)
    fallout.giq_option(4, 339, 103, Marcelles02, 50)
    fallout.giq_option(4, 339, 104, reaction.UpReact, 50)
    fallout.giq_option(-3, 339, 105, Marcelles01, 50)
end

function Marcelles01()
    fallout.gsay_message(339, 106, 50)
end

function Marcelles02()
    reaction.DownReact()
    fallout.gsay_reply(339, 107)
    fallout.giq_option(4, 339, 108, Marcelles02a, 51)
    fallout.giq_option(4, 339, 109, MarcellesEnd, 50)
end

function Marcelles02a()
    reaction.BigDownReact()
    Marcelles_charge_raider()
end

function Marcelles03()
    fallout.gsay_message(339, 110, 50)
end

function Marcelles04()
    line04flag = true
    fallout.gsay_reply(339, 111)
    fallout.giq_option(-3, 339, 112, Marcelles05, 50)
    fallout.giq_option(4, 339, 113, Marcelles05, 50)
end

function Marcelles05()
    fallout.gsay_message(339, 114, 50)
    if fallout.global_var(168) < time.game_time_in_days() then
        fallout.set_global_var(168, time.game_time_in_days() + 1)
    else
        fallout.set_global_var(168, fallout.global_var(168) + 1)
    end
    showing_room = true
end

function Marcelles06()
    line06flag = true
    reaction.BigDownReact()
    fallout.gsay_reply(339, 116)
    fallout.giq_option(4, 339, 117, MarcellesEnd, 50)
    fallout.giq_option(-3, 339, 118, MarcellesEnd, 50)
end

function Marcelles07()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(339, 119)
    fallout.giq_option(4, 339, 120, Marcelles12, 50)
    fallout.giq_option(4, 339, 121, Marcelles13, 50)
    fallout.giq_option(7, 339, 122, Marcelles14, 50)
    fallout.giq_option(-3, 339, 123, Marcelles08, 50)
end

function Marcelles08()
    fallout.gsay_reply(339, 124)
    fallout.giq_option(-3, 339, 125, Marcelles09, 50)
    fallout.giq_option(-3, 339, 126, Marcelles08a, 50)
    fallout.giq_option(-3, 339, 127, Marcelles08b, 50)
end

function Marcelles08a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 25 then
        fallout.item_caps_adjust(dude_obj, -25)
        local game_time_in_days = time.game_time_in_days()
        if fallout.global_var(168) < game_time_in_days then
            fallout.set_global_var(168, game_time_in_days + 1)
        else
            fallout.set_global_var(168, fallout.global_var(168) + 1)
        end
        Marcelles10()
    else
        Marcelles11()
    end
end

function Marcelles08b()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 150 then
        fallout.item_caps_adjust(dude_obj, -150)
        local game_time_in_days = time.game_time_in_days()
        if fallout.global_var(168) < game_time_in_days then
            fallout.set_global_var(168, game_time_in_days + 7)
        else
            fallout.set_global_var(168, fallout.global_var(168) + 7)
        end
        Marcelles10()
    else
        Marcelles11()
    end
end

function Marcelles09()
    fallout.gsay_message(339, 128, 50)
end

function Marcelles10()
    fallout.gsay_message(339, 129, 50)
    showing_room = true
end

function Marcelles11()
    fallout.gsay_message(339, 131, 50)
end

function Marcelles12()
    fallout.gsay_message(339, 132, 50)
end

function Marcelles13()
    fallout.gsay_reply(339, 133)
    fallout.giq_option(4, 339, 134, Marcelles08b, 50)
    fallout.giq_option(4, 339, 135, Marcelles08a, 50)
    fallout.giq_option(4, 339, 136, MarcellesEnd, 50)
end

function Marcelles14()
    fallout.gsay_reply(339, 137)
    fallout.giq_option(5, 339, 138, Marcelles14a, 50)
    fallout.giq_option(4, 339, 182, MarcellesEnd, 50)
end

function Marcelles14a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 50 then
        Marcelles15()
    else
        Marcelles16()
    end
end

function Marcelles15()
    fallout.item_caps_adjust(fallout.dude_obj(), -50)
    fallout.gsay_message(339, 139, 50)
end

function Marcelles16()
    reaction.DownReact()
    fallout.gsay_message(339, 140, 50)
end

function Marcelles17()
    fallout.gsay_reply(339, 141)
    fallout.giq_option(4, 339, 142, Marcelles17a, 50)
    fallout.giq_option(4, 339, 184, MarcellesEnd, 50)
    fallout.giq_option(-3, 339, 143, Marcelles17a, 50)
end

function Marcelles17a()
    if fallout.global_var(168) > time.game_time_in_days() then
        Marcelles18()
    else
        Marcelles20()
    end
end

function Marcelles18()
    fallout.gsay_reply(339, 144)
    fallout.giq_option(4, 339, 145, Marcelles18a, 50)
    fallout.giq_option(4, 339, 146, MarcellesEnd, 50)
    fallout.giq_option(-3, 339, 147, Marcelles18a, 50)
    fallout.giq_option(-3, 339, 148, MarcellesEnd, 50)
end

function Marcelles18a()
    reaction.DownReact()
    showing_room = true
end

function Marcelles19()
    fallout.gsay_reply(339, 150)
    fallout.giq_option(-3, 339, 151, Marcelles09, 50)
    fallout.giq_option(-3, 339, 152, Marcelles19a, 50)
    fallout.giq_option(-3, 339, 153, Marcelles19b, 50)
end

function Marcelles19a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 25 then
        fallout.item_caps_adjust(dude_obj, -25)
        local game_time_in_days = time.game_time_in_days()
        if fallout.global_var(168) < game_time_in_days then
            fallout.set_global_var(168, game_time_in_days + 1)
        else
            fallout.set_global_var(168, fallout.global_var(168) + 1)
        end
        Marcelles21()
    else
        Marcelles11()
    end
end

function Marcelles19b()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 150 then
        fallout.item_caps_adjust(dude_obj, -150)
        local game_time_in_days = time.game_time_in_days()
        if fallout.global_var(168) < game_time_in_days then
            fallout.set_global_var(168, game_time_in_days + 7)
        else
            fallout.set_global_var(168, fallout.global_var(168) + 7)
        end
        Marcelles21()
    else
        Marcelles11()
    end
end

function Marcelles20()
    fallout.gsay_reply(339, 154)
    fallout.giq_option(4, 339, 155, Marcelles19b, 50)
    fallout.giq_option(4, 339, 156, Marcelles19a, 50)
    fallout.giq_option(4, 339, 157, MarcellesEnd, 50)
end

function Marcelles21()
    reaction.UpReact()
    fallout.gsay_message(339, 158, 50)
end

function Marcelles22()
    fallout.gsay_reply(339, 159)
    fallout.giq_option(4, 339, 160, Marcelles24, 50)
    fallout.giq_option(4, 339, 184, MarcellesEnd, 50)
    fallout.giq_option(-3, 339, 161, Marcelles23, 50)
end

function Marcelles23()
    fallout.gsay_message(339, 162, 50)
end

function Marcelles24()
    fallout.gsay_reply(339, 163)
    fallout.giq_option(4, 339, 164, Marcelles24a, 50)
end

function Marcelles24a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Marcelles26()
    else
        Marcelles25()
    end
end

function Marcelles25()
    fallout.gsay_message(339, 165, 50)
end

function Marcelles26()
    fallout.gsay_reply(339, 166)
    fallout.giq_option(4, 339, 167, Marcelles27, 50)
    fallout.giq_option(4, 339, 168, Marcelles26a, 50)
end

function Marcelles26a()
    local dude_obj = fallout.dude_obj()
    if fallout.item_caps_total(dude_obj) >= 100 then
        fallout.item_caps_adjust(dude_obj, -100)
        local game_time_in_days = time.game_time_in_days()
        if fallout.global_var(168) < game_time_in_days then
            fallout.set_global_var(168, game_time_in_days + 1)
        else
            fallout.set_global_var(168, fallout.global_var(168) + 1)
        end
        Marcelles28()
    else
        Marcelles11()
    end
end

function Marcelles27()
    fallout.gsay_reply(339, 169)
    fallout.giq_option(4, 339, 170, MarcellesEnd, 50)
    fallout.giq_option(4, 339, 171, Marcelles26a, 50)
end

function Marcelles28()
    fallout.gsay_message(339, 172, 50)
end

function Marcelles29()
    line29flag = true
    fallout.gsay_reply(339, 173)
    fallout.giq_option(4, 339, 174, Marcelles31, 50)
    fallout.giq_option(4, 339, 175, Marcelles29a, 50)
    fallout.giq_option(-3, 339, 176, Marcelles30, 50)
end

function Marcelles29a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Marcelles32()
    else
        Marcelles31()
    end
end

function Marcelles30()
    reaction.BottomReact()
    fallout.gsay_message(339, 177, 51)
end

function Marcelles31()
    reaction.BottomReact()
    fallout.gsay_message(339, 178, 51)
end

function Marcelles32()
    reaction.BigDownReact()
    fallout.gsay_message(339, 179, 51)
end

function Marcelles33()
    fallout.set_external_var("messing_with_fridge", 0)
    if fallout.global_var(168) <= time.game_time_in_days() then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(339, 181), 2)
        if fallout.local_var(6) == 1 then
            hostile = true
        else
            fallout.set_local_var(6, 1)
        end
    end
end

function go_to_room()
    showing_room = true
    sleeping_disabled = true
    moving_disabled = true
end

function MarcellesEnd()
end

function Marcelles_charge_raider()
    fallout.display_msg(fallout.message_str(339, 183))
    fallout.add_timer_event(fallout.self_obj(), 5, 3)
    fallout.game_ui_disable()
    Shooting = true
end

function map_update_p_proc()
    if fallout.global_var(143) == 0 and not line00flag and fallout.map_var(3) ~= 0 then
        fallout.move_to(fallout.self_obj(), waiting_tile, 0)
        dest_tile = waiting_tile
        showing_room = false
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
