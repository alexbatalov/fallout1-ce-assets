local fallout = require("fallout")

local start
local critter_p_proc
local description_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local Neal01
local Neal02
local Neal03
local Neal04
local Neal05
local Neal06
local Neal07
local Neal08
local Neal09
local Neal10
local Neal11
local NealEnd
local NealCola
local NealBeer
local NealBooze
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local annoyed = 0
local hostile = 0
local initialized = 0
local item = 0
local moving_disabled = 0
local sfx_name = 0
local sleeping_disabled = 0

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 3 then
                description_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 15 then
                        map_enter_p_proc()
                    else
                        if fallout.script_action() == 4 then
                            pickup_p_proc()
                        else
                            if fallout.script_action() == 11 then
                                talk_p_proc()
                            else
                                if fallout.script_action() == 22 then
                                    timed_event_p_proc()
                                else
                                    if fallout.script_action() == 7 then
                                        use_obj_on_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if sleeping_disabled == 0 then
        sleeping()
    end
    if (fallout.game_time_hour() > 1700) or (fallout.game_time_hour() < 330) and (moving_disabled == 0) then
        if fallout.tile_num(fallout.self_obj()) ~= home_tile then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
        else
            if fallout.has_trait(1, fallout.self_obj(), 10) ~= 2 then
                fallout.anim(fallout.self_obj(), 1000, 2)
            end
        end
    end
    if (fallout.map_var(4) == 1) and (fallout.local_var(10) == 0) and (fallout.local_var(9) == 0) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 133), 2)
        hostile = 1
        fallout.set_local_var(10, 1)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 112) then
        fallout.destroy_object(fallout.obj_carrying_pid_obj(fallout.self_obj(), 112))
    end
    if fallout.external_var("messing_with_SkumDoor") then
        if annoyed then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 149), 2)
            fallout.set_external_var("Neal_closing_door", 0)
            if fallout.external_var("SkumDoor_ptr") ~= 0 then
                fallout.use_obj(fallout.external_var("SkumDoor_ptr"))
            end
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 6)
        else
            sleeping_disabled = 1
            fallout.set_local_var(9, 0)
            fallout.move_to(fallout.self_obj(), sleep_tile, 0)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_animate(fallout.self_obj(), 37, -1)
            fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 21283, -1)
            fallout.reg_anim_func(3, 0)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 148), 2)
            annoyed = 1
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 5)
        end
        fallout.set_external_var("messing_with_SkumDoor", 0)
    end
    if fallout.external_var("SkumDoor_ptr") ~= 0 then
        if (fallout.game_time_hour() == 409) and fallout.obj_is_open(fallout.external_var("SkumDoor_ptr")) then
            fallout.set_external_var("Neal_closing_door", 1)
            fallout.use_obj(fallout.external_var("SkumDoor_ptr"))
        end
        if (fallout.game_time_hour() == 1400) and not(fallout.obj_is_open(fallout.external_var("SkumDoor_ptr"))) then
            fallout.set_external_var("Neal_closing_door", 1)
            fallout.use_obj(fallout.external_var("SkumDoor_ptr"))
        end
    end
    if fallout.global_var(247) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(508, 102))
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
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
    fallout.set_global_var(284, 1)
    fallout.set_external_var("Neal_ptr", 0)
end

function look_at_p_proc()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(508, 100))
    else
        fallout.display_msg(fallout.message_str(508, 101))
    end
end

function map_enter_p_proc()
    night_person = 1
    wake_time = 1300
    sleep_time = 410
    home_tile = 19477
    sleep_tile = 17876
    fallout.set_external_var("Neal_ptr", fallout.self_obj())
    if fallout.map_var(2) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 149), 7)
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 26)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 56)
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 103), 2)
    hostile = 1
end

function talk_p_proc()
    if (fallout.game_time_hour() >= 1300) and (fallout.game_time_hour() < 1600) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 104), 0)
    else
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 112) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 143), 4)
            fallout.set_local_var(11, 1)
        else
            if (fallout.game_time_hour() >= 410) and (fallout.game_time_hour() <= 1300) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 105), 0)
            else
                fallout.start_gdialog(508, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Neal01()
                fallout.gsay_end()
                fallout.end_dialogue()
                if fallout.local_var(4) == 0 then
                    fallout.set_local_var(4, 1)
                    if fallout.external_var("Skul_target") ~= 0 then
                        if fallout.tile_distance_objs(fallout.self_obj(), fallout.external_var("Skul_target")) < 12 then
                            fallout.add_timer_event(fallout.external_var("Skul_target"), fallout.game_ticks(3), 2)
                        end
                    end
                end
            end
        end
    end
    if item then
        fallout.add_obj_to_inven(fallout.dude_obj(), item)
        item = 0
        fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 132), 3)
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.float_msg(fallout.external_var("Trish_ptr"), fallout.message_str(342, 150), 4)
        if (fallout.global_var(557) & 2) == 0 then
            fallout.set_global_var(557, fallout.global_var(557) + 2)
        end
        moving_disabled = 1
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), home_tile, -1)
        fallout.reg_anim_func(3, 0)
        fallout.set_global_var(282, 1)
        fallout.add_timer_event(fallout.self_obj(), 5, 2)
    else
        if fallout.fixed_param() == 2 then
            if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                fallout.add_timer_event(fallout.self_obj(), 5, 2)
            else
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 3 then
                    fallout.anim(fallout.self_obj(), 1000, 3)
                    fallout.add_timer_event(fallout.self_obj(), 5, 2)
                else
                    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 22) == 0 then
                        item = fallout.create_object_sid(22, 0, 0, -1)
                        fallout.add_obj_to_inven(fallout.self_obj(), item)
                        item = 0
                    end
                    fallout.wield_obj_critter(fallout.self_obj(), fallout.obj_carrying_pid_obj(fallout.self_obj(), 22))
                    fallout.add_timer_event(fallout.self_obj(), 5, 3)
                end
            end
        else
            if fallout.fixed_param() == 3 then
                fallout.reg_anim_func(2, fallout.self_obj())
                fallout.reg_anim_func(1, 1)
                fallout.reg_anim_animate(fallout.self_obj(), 43, -1)
                fallout.reg_anim_animate(fallout.self_obj(), 45, -1)
                sfx_name = fallout.sfx_build_weapon_name(1, fallout.obj_carrying_pid_obj(fallout.self_obj(), 22), 0, fallout.external_var("Skul_target"))
                fallout.reg_anim_play_sfx(fallout.self_obj(), sfx_name, 0)
                fallout.reg_anim_animate(fallout.self_obj(), 44, -1)
                fallout.reg_anim_func(3, 0)
                fallout.add_timer_event(fallout.self_obj(), 5, 4)
            else
                if fallout.fixed_param() == 4 then
                    fallout.critter_dmg(fallout.external_var("Skul_target"), fallout.random(50, 75), 0)
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 146), 2)
                    moving_disabled = 0
                else
                    if fallout.fixed_param() == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 147), 2)
                    else
                        if fallout.fixed_param() == 6 then
                            annoyed = 0
                            sleeping_disabled = 0
                        else
                            if fallout.fixed_param() == 6 then
                                hostile = 1
                            end
                        end
                    end
                end
            end
        end
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 112 then
        fallout.rm_obj_from_inven(fallout.source_obj(), fallout.obj_being_used_with())
        fallout.add_obj_to_inven(fallout.self_obj(), fallout.obj_being_used_with())
        fallout.dialogue_system_enter()
    end
end

function Neal01()
    fallout.gsay_reply(508, 106)
    fallout.giq_option(4, 508, 107, Neal02, 50)
    fallout.giq_option(4, 508, 108, Neal03, 50)
    fallout.giq_option(4, 508, fallout.message_str(508, 109) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(508, 110), Neal04, 50)
    if fallout.global_var(286) == 0 then
        fallout.giq_option(4, 508, 125, Neal09, 50)
    else
        fallout.giq_option(4, 508, 142, Neal09, 50)
    end
    fallout.giq_option(-3, 508, 111, NealEnd, 50)
    Goodbyes()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 112) then
        fallout.giq_option(4, 508, 144, Neal11, 49)
    end
    fallout.giq_option(4, 508, exit_line, NealEnd, 50)
end

function Neal02()
    fallout.gsay_reply(508, 112)
    fallout.giq_option(0, 508, 113, NealCola, 50)
    fallout.giq_option(0, 508, 114, NealBeer, 50)
    fallout.giq_option(0, 508, 115, NealBooze, 50)
    Goodbyes()
    fallout.giq_option(0, 508, exit_line, NealEnd, 50)
end

function Neal03()
    fallout.gsay_reply(508, 116)
    if not(fallout.local_var(5)) then
        fallout.giq_option(4, 508, 117, Neal06, 50)
    end
    if (fallout.global_var(121) == 0) and not(fallout.local_var(6)) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.external_var("Tycho_ptr")) < 12) then
        fallout.giq_option(4, 508, 118, Neal07, 50)
    end
    if not(fallout.local_var(8)) then
        if (fallout.global_var(555) ~= 2) and (fallout.global_var(282) == 1) then
            fallout.giq_option(4, 508, 119, Neal08, 50)
        end
    end
    Goodbyes()
    fallout.giq_option(0, 508, exit_line, NealEnd, 50)
end

function Neal04()
    fallout.gsay_reply(508, 120)
    fallout.giq_option(4, 508, 121, Neal02, 50)
    fallout.giq_option(4, 508, 122, Neal03, 50)
    fallout.giq_option(4, 508, 123, NealEnd, 50)
end

function Neal05()
    fallout.gsay_message(508, 124, 50)
end

function Neal06()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(508, 126)
    fallout.giq_option(4, 508, 127, Neal02, 0)
    fallout.giq_option(4, 508, 128, Neal10, 0)
end

function Neal07()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(508, 129)
    fallout.giq_option(4, 508, 130, Neal03, 50)
    Goodbyes()
    fallout.giq_option(0, 508, exit_line, NealEnd, 50)
end

function Neal08()
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(508, 131)
    fallout.giq_option(4, 508, 130, Neal03, 50)
    Goodbyes()
    fallout.giq_option(0, 508, exit_line, NealEnd, 50)
end

function Neal09()
    if fallout.global_var(286) == 0 then
        fallout.gsay_reply(508, 134)
    else
        fallout.gsay_reply(508, 145)
    end
    fallout.giq_option(4, 508, 138, Neal10, 50)
end

function Neal10()
    fallout.gsay_reply(508, 135)
    fallout.giq_option(4, 508, 139, Neal02, 50)
    fallout.giq_option(4, 508, 136, Neal03, 50)
    fallout.giq_option(4, 508, 137, NealEnd, 50)
end

function Neal11()
    fallout.gsay_message(508, 143, 49)
    fallout.set_local_var(11, 1)
    item = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 112)
    fallout.set_global_var(155, fallout.global_var(155) + 2)
    fallout.rm_obj_from_inven(fallout.dude_obj(), item)
    fallout.add_obj_to_inven(fallout.self_obj(), item)
end

function NealEnd()
end

function NealCola()
    if fallout.local_var(11) == 0 then
        if fallout.item_caps_total(fallout.dude_obj()) >= 3 then
            fallout.item_caps_adjust(fallout.dude_obj(), -3)
            item = fallout.create_object_sid(106, 0, 0, -1)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 140), 0)
        end
    else
        item = fallout.create_object_sid(106, 0, 0, -1)
    end
end

function NealBeer()
    if fallout.local_var(11) == 0 then
        if fallout.item_caps_total(fallout.dude_obj()) >= 5 then
            fallout.item_caps_adjust(fallout.dude_obj(), -5)
            item = fallout.create_object_sid(124, 0, 0, -1)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 140), 0)
        end
    else
        item = fallout.create_object_sid(124, 0, 0, -1)
    end
end

function NealBooze()
    if fallout.local_var(11) == 0 then
        if fallout.item_caps_total(fallout.dude_obj()) >= 20 then
            fallout.item_caps_adjust(fallout.dude_obj(), -20)
            item = fallout.create_object_sid(125, 0, 0, -1)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(508, 140), 0)
        end
    else
        item = fallout.create_object_sid(125, 0, 0, -1)
    end
end

function sleeping()
    if fallout.local_var(9) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(9, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(9, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(9, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(9, 1)
                end
            end
        end
    end
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
