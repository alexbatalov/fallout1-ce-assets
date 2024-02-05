local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local talk_p_proc
local timed_event_p_proc
local Sinthia00
local Sinthia00a
local Sinthia00b
local Sinthia01
local Sinthia02
local Sinthia03
local Sinthia04
local Sinthia05
local Sinthia06
local Sinthia07
local Sinthia08
local Sinthia09
local Sinthia10
local Sinthia11
local Sinthia12
local Sinthia12a
local Sinthia13
local Sinthia13a
local Sinthia14
local Sinthia15
local Sinthia16
local Sinthia16a
local Sinthia17
local Sinthia18
local Sinthia19
local Sinthia20
local Sinthia20a
local Sinthia21
local Sinthia22
local Sinthia23
local Sinthia24
local Sinthia25
local Sinthia26
local Sinthia27
local Sinthia28
local Sinthia29
local Sin
local SinOn
local SinthiaQuestions
local SinthiaEnd

local do_it = false
local dest_tile = 0
local raider_fall_down = false
local remove_Raider = false
local sleeping_disabled = false
local waypoint = 7000
local line08flag = false
local line23flag = false
local line24flag = false
local line25flag = false
local line26flag = false

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0

local damage_p_proc

function start()
    fallout.set_external_var("Sinthia_ptr", fallout.self_obj())
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    if fallout.map_var(1) == 2 then
        if fallout.local_var(6) == 0 and self_can_see_dude and distance_self_to_dude < 12 then
            fallout.dialogue_system_enter()
        end
    elseif fallout.map_var(1) == 1 then
        if fallout.local_var(7) == 0 and self_can_see_dude and distance_self_to_dude < 12 and not raider_fall_down then
            local raider_obj = fallout.external_var("JTRaider_ptr")
            fallout.rm_timer_event(self_obj)
            fallout.add_timer_event(self_obj, 15, 2)
            fallout.reg_anim_func(2, raider_obj)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_animate(raider_obj, 21, -1)
            fallout.reg_anim_animate(raider_obj, 49, -1)
            fallout.reg_anim_func(3, 0)
            raider_fall_down = true
        end
    end
    if fallout.global_var(143) == 2 then
        if fallout.map_var(1) ~= fallout.external_var("raider_dead") then
            if sleeping_disabled == 0 then
                behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
            end
        else
            fallout.set_map_var(0, 1)
            sleeping_disabled = true
            if waypoint == 0 then
                dest_tile = 22502
                waypoint = 1
            end
            if fallout.tile_distance(fallout.tile_num(self_obj), dest_tile) > 3 then
                fallout.animate_move_obj_to_tile(self_obj, dest_tile, 0)
            else
                if waypoint == 1 then
                    dest_tile = 31930
                    waypoint = 2
                elseif waypoint == 2 then
                    fallout.destroy_object(self_obj)
                end
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_external_var("Sinthia_ptr", nil)
    fallout.set_global_var(143, 2)
    if fallout.map_var(0) ~= 1 then
        fallout.set_map_var(0, 2)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
        reputation.inc_good_critter()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(5) == 1 then
        fallout.display_msg(fallout.message_str(338, 100))
    else
        fallout.display_msg(fallout.message_str(338, 101))
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    misc.set_team(self_obj, 16)
    fallout.set_external_var("Sinthia_ptr", self_obj)
    home_tile = 17485
    sleep_tile = 16681
    sleep_time = 2300
    wake_time = 1000
    if fallout.local_var(6) == 1 then
        fallout.set_external_var("Sinthia_ptr", nil)
        fallout.destroy_object(self_obj)
    end
end

function talk_p_proc()
    if fallout.local_var(6) == 1 then
        fallout.display_msg(fallout.message_str(338, 171))
    else
        if fallout.map_var(3) > 0 and fallout.map_var(3) < 3 then
            Sinthia07()
        else
            reaction.get_reaction()
            fallout.start_gdialog(338, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            fallout.set_local_var(5, 1)
            if fallout.map_var(1) == 2 then
                Sinthia16()
            elseif fallout.map_var(1) == 1 and fallout.local_var(7) == 0 then
                Sinthia17()
            elseif not line08flag and fallout.global_var(143) == 2 then
                Sinthia08()
            elseif fallout.map_var(3) < 3 then
                Sinthia00()
            elseif fallout.local_var(1) < 2 then
                Sinthia29()
            else
                Sinthia20()
            end
            fallout.gsay_end()
            fallout.end_dialogue()
            if do_it then
                Sin()
            end
            if remove_Raider then
                local raider_obj = fallout.external_var("JTRaider_ptr")
                if raider_obj ~= nil then
                    fallout.display_msg(fallout.message_str(338, 177))
                    fallout.destroy_object(raider_obj)
                    fallout.set_external_var("JTRaider_ptr", nil)
                    remove_Raider = false
                end
            end
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 2 then
        fallout.dialogue_system_enter()
    else
        fallout.anim(fallout.self_obj(), 1000, 3)
    end
end

function Sinthia00()
    fallout.gsay_reply(338, 102)
    fallout.giq_option(4, 338, 103, SinthiaEnd, 50)
    fallout.giq_option(6, 338, 104, Sinthia00a, 50)
    fallout.giq_option(-3, 338, 105, Sinthia00b, 50)
end

function Sinthia00a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        Sinthia04()
    else
        Sinthia03()
    end
end

function Sinthia00b()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        Sinthia01()
    else
        Sinthia02()
    end
end

function Sinthia01()
    fallout.gsay_message(338, 106, 50)
end

function Sinthia02()
    fallout.gsay_message(338, 107, 50)
end

function Sinthia03()
    fallout.gsay_message(338, 108, 50)
end

function Sinthia04()
    fallout.gsay_reply(338, 109)
    fallout.giq_option(6, 338, 110, Sinthia05, 50)
    if fallout.global_var(5) ~= 0 then
        fallout.giq_option(6, 338, 111, Sinthia06, 50)
    end
end

function Sinthia05()
    fallout.gsay_message(338, 112, 50)
end

function Sinthia06()
    reaction.DownReact()
    fallout.gsay_message(338, 113, 50)
end

function Sinthia07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(338, fallout.random(114, 117)), 7)
end

function Sinthia08()
    line08flag = true
    reaction.BigUpReact()
    fallout.gsay_reply(338, 118)
    fallout.giq_option(4, 338, 119, Sinthia10, 50)
    fallout.giq_option(5, 338, 120, Sinthia11, 50)
    fallout.giq_option(-3, 338, 121, Sinthia09, 50)
end

function Sinthia09()
    fallout.gsay_message(338, 122, 50)
end

function Sinthia10()
    reaction.DownReact()
    fallout.gsay_message(338, 123, 50)
end

function Sinthia11()
    fallout.gsay_reply(338, 124)
    fallout.giq_option(5, 338, 125, Sinthia12, 50)
    fallout.giq_option(5, 338, 126, Sinthia15, 50)
end

function Sinthia12()
    fallout.gsay_reply(338, 127)
    fallout.giq_option(0, 634, 106, Sinthia12a, 49)
end

function Sinthia12a()
    fallout.gsay_reply(338, 128)
    fallout.giq_option(5, 338, 129, Sinthia14, 50)
    fallout.giq_option(5, 338, 130, Sinthia13, 50)
end

function Sinthia13()
    fallout.gsay_reply(338, 131)
    fallout.giq_option(0, 634, 106, Sinthia13a, 50)
end

function Sinthia13a()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, 0)) then
        fallout.gsay_reply(338, 132)
        fallout.giq_option(0, 634, 106, SinOn, 49)
    else
        fallout.gsay_message(338, 133, 49)
    end
end

function Sinthia14()
    fallout.gsay_message(338, 134, 50)
    if fallout.global_var(37) == 0 and fallout.global_var(38) == 0 then
        fallout.gsay_message(338, 136, 50)
    end
end

function Sinthia15()
    fallout.gsay_reply(338, 137)
    fallout.giq_option(5, 338, 138, Sinthia14, 50)
end

function Sinthia16()
    fallout.set_local_var(6, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(338, 141)
    else
        fallout.gsay_reply(338, 142)
    end
    fallout.giq_option(0, 634, 106, Sinthia16a, 50)
end

function Sinthia16a()
    reaction.BottomReact()
    dest_tile = 7521
    fallout.gsay_message(338, 143, 50)
end

function Sinthia17()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(338, 144)
    fallout.giq_option(4, 338, 145, Sinthia19, 50)
    fallout.giq_option(-3, 338, 146, Sinthia18, 50)
end

function Sinthia18()
    reaction.BottomReact()
    fallout.gsay_message(338, 147, 50)
end

function Sinthia19()
    fallout.gsay_reply(338, 148)
    fallout.giq_option(4, 338, 149, Sinthia08, 50)
    remove_Raider = true
end

function Sinthia20()
    fallout.gsay_reply(338, 150)
    fallout.giq_option(4, 338, 151, Sinthia22, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 338, 152, Sinthia20a, 50)
    end
    if not line23flag then
        fallout.giq_option(6, 338, 153, Sinthia23, 50)
    end
end

function Sinthia20a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 40 then
        fallout.item_caps_adjust(fallout.dude_obj(), -40)
        Sinthia27()
    else
        Sinthia28()
    end
end

function Sinthia21()
    fallout.gsay_message(338, 154, 50)
end

function Sinthia22()
    fallout.gsay_message(338, 155, 50)
end

function Sinthia23()
    line23flag = true
    fallout.gsay_reply(338, 156)
    SinthiaQuestions()
end

function Sinthia24()
    line24flag = true
    fallout.gsay_reply(338, 161)
    SinthiaQuestions()
end

function Sinthia25()
    line25flag = true
    fallout.gsay_reply(338, 162)
    SinthiaQuestions()
end

function Sinthia26()
    line26flag = true
    fallout.gsay_reply(338, 163)
    SinthiaQuestions()
end

function Sinthia27()
    local msg = fallout.message_str(338, 163 + fallout.random(1, 3))
    fallout.float_msg(fallout.self_obj(), msg, 7)
    SinOn()
end

function Sinthia28()
    reaction.DownReact()
    fallout.gsay_message(338, 167, 50)
end

function Sinthia29()
    fallout.gsay_message(338, 168, 50)
end

function Sin()
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(600))
    fallout.move_to(fallout.dude_obj(), 18291, 0)
    if not fallout.is_success(fallout.do_check(fallout.dude_obj(), 4, 0)) then
        fallout.set_map_var(7, 1)
    end
    fallout.gfade_in(600)
    do_it = false
end

function SinOn()
    do_it = true
end

function SinthiaQuestions()
    if not line24flag then
        fallout.giq_option(6, 338, 157, Sinthia24, 50)
    end
    if not line25flag then
        fallout.giq_option(6, 338, 158, Sinthia25, 50)
    end
    if not line26flag then
        fallout.giq_option(6, 338, 159, Sinthia26, 50)
    end
    fallout.giq_option(6, 338, 160, SinthiaEnd, 50)
end

function SinthiaEnd()
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
