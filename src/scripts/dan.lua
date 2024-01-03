local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local damage_p_proc
local Dan00
local Dan01
local Dan02
local Dan03
local Dan04
local Dan05
local Dan06
local Dan07
local Dan08
local Dan09
local Dan10
local Dan11
local Dan12
local Dan13
local Dan14
local Dan15
local Dan16
local Dan17
local Dan18
local Dan19
local Dan20
local Dan21
local Dan22
local Dan23
local Dan24
local Dan25
local Dan26
local Dan27
local Dan28
local DanAtNight
local SendToStart
local SendToStreet
local SendToCattle1
local SendToCattle2
local SendToSleep
local DanEnd

local hostile = 0
local initialized = false
local SetDayNight = 0
local NightCount = 0
local Talky = 0
local WalkToTalker = 0
local Sleeping = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 62)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
        fallout.set_external_var("Dan_ptr", fallout.self_obj())
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    else
                        if fallout.script_action() == 22 then
                            timed_event_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if time.is_morning() then
        if SetDayNight == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 3)
            SetDayNight = 1
        end
    end
    if fallout.map_var(0) == 1 then
        if WalkToTalker == 0 then
            fallout.reg_anim_func(2, fallout.self_obj())
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 13891, -1)
            fallout.reg_anim_func(3, 0)
            WalkToTalker = 1
        end
    end
    if fallout.tile_num(fallout.self_obj()) == 13891 then
        if fallout.map_var(0) == 1 then
            if Talky == 0 then
                Dan27()
                Talky = 1
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 2), 1)
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if time.is_night() then
        DanAtNight()
    else
        if fallout.local_var(4) == 1 then
            fallout.set_local_var(4, 2)
            if (fallout.map_var(0) == 2) and (fallout.local_var(8) == 0) then
                if fallout.local_var(1) > 1 then
                    fallout.start_gdialog(562, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Dan15()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    Dan28()
                end
            else
                Dan28()
            end
        else
            if fallout.local_var(4) == 2 then
                if (fallout.map_var(0) == 2) and (fallout.local_var(8) == 0) then
                    if fallout.local_var(1) == 1 then
                        fallout.start_gdialog(562, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Dan16()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        Dan28()
                    end
                else
                    Dan28()
                end
            else
                fallout.start_gdialog(562, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Dan00()
                fallout.gsay_end()
                fallout.end_dialogue()
                fallout.set_local_var(4, 1)
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(280, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(562, 100))
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        if Sleeping == 1 then
            fallout.reg_anim_func(2, fallout.self_obj())
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 12871, -1)
            fallout.reg_anim_func(3, 0)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 25), 2)
            Sleeping = 0
        else
            if fallout.fixed_param() == 1 then
                SendToStart()
            else
                if fallout.fixed_param() == 2 then
                    SendToStreet()
                else
                    if fallout.fixed_param() == 3 then
                        SendToCattle1()
                    else
                        if fallout.fixed_param() == 4 then
                            SendToCattle2()
                        end
                    end
                end
            end
        end
    else
        SendToSleep()
        if fallout.fixed_param() == 4 then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 10 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(562, 215), 2)
            end
        else
            if fallout.fixed_param() == 5 then
                NightCount = 0
                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 10 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(562, 216), 2)
                    hostile = 1
                end
            end
        end
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function Dan00()
    fallout.gsay_reply(562, 102)
    fallout.giq_option(5, 562, 106, Dan11, 50)
    fallout.giq_option(4, 562, 107, Dan01, 50)
    if fallout.map_var(0) == 2 then
        fallout.giq_option(4, 562, 108, Dan14, 50)
        fallout.set_local_var(8, 1)
    end
    fallout.giq_option(-3, 562, 109, Dan02, 50)
end

function Dan01()
    fallout.gsay_reply(562, 110)
    fallout.giq_option(4, 562, 111, Dan03, 50)
    fallout.giq_option(4, 562, 112, Dan05, 50)
    fallout.giq_option(5, 562, 113, Dan11, 50)
    fallout.giq_option(4, 562, 114, DanEnd, 50)
end

function Dan02()
    fallout.gsay_message(562, 115, 51)
end

function Dan03()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(562, 118)
    else
        fallout.gsay_reply(562, 119)
    end
    fallout.giq_option(4, 562, 120, Dan04, 51)
    fallout.giq_option(5, 562, 121, Dan11, 50)
    fallout.giq_option(4, 562, 122, DanEnd, 50)
end

function Dan04()
    fallout.gsay_reply(562, 123)
    fallout.giq_option(4, 562, 124, Dan06, 51)
    fallout.giq_option(4, 562, 125, DanEnd, 50)
end

function Dan05()
    fallout.gsay_reply(562, 126)
    fallout.giq_option(4, 562, 127, Dan06, 51)
    fallout.giq_option(4, 562, 128, DanEnd, 50)
end

function Dan06()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(562, 129)
    fallout.giq_option(4, 562, 130, Dan07, 51)
    fallout.giq_option(4, 562, 131, Dan09, 50)
end

function Dan07()
    fallout.gsay_reply(562, 132)
    fallout.giq_option(4, 562, 133, Dan10, 51)
    fallout.giq_option(4, 562, 134, Dan08, 50)
end

function Dan08()
    fallout.gsay_reply(562, 135)
    fallout.giq_option(4, 562, 136, Dan09, 50)
    fallout.giq_option(4, 562, 137, Dan11, 50)
end

function Dan09()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(562, 138, 51)
    else
        fallout.gsay_message(562, 139, 51)
    end
end

function Dan10()
    fallout.gsay_message(562, 141, 51)
    combat()
end

function Dan11()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(562, 142)
    else
        fallout.gsay_reply(562, fallout.message_str(562, 142) .. " " .. fallout.message_str(562, 143))
    end
    fallout.giq_option(7, 562, 144, Dan12, 50)
    fallout.giq_option(4, 562, 145, Dan13, 50)
    fallout.giq_option(4, 562, 146, DanEnd, 50)
end

function Dan12()
    fallout.gsay_reply(562, 147)
    fallout.giq_option(4, 562, 148, DanEnd, 50)
    fallout.giq_option(4, 562, 149, DanEnd, 50)
    fallout.giq_option(5, 562, 150, Dan13, 50)
end

function Dan13()
    fallout.gsay_message(562, 151, 50)
end

function Dan14()
    fallout.gsay_reply(562, 152)
    fallout.giq_option(4, 562, 153, Dan17, 50)
    fallout.giq_option(4, 562, 154, DanEnd, 50)
end

function Dan15()
    fallout.gsay_reply(562, 155)
    fallout.giq_option(5, 562, 156, Dan11, 50)
    fallout.giq_option(4, 562, 157, Dan01, 50)
    if fallout.map_var(0) == 2 then
        fallout.giq_option(4, 562, 158, Dan14, 50)
    end
    fallout.giq_option(4, 562, 159, DanEnd, 50)
    fallout.giq_option(-3, 562, 160, Dan02, 50)
end

function Dan16()
    fallout.gsay_reply(562, 161)
    if fallout.map_var(0) == 2 then
        fallout.giq_option(4, 562, 162, Dan14, 50)
    end
    fallout.giq_option(4, 562, 163, DanEnd, 50)
    fallout.giq_option(-3, 562, 164, Dan02, 50)
end

function Dan17()
    fallout.gsay_reply(562, 168)
    fallout.giq_option(4, 562, 169, Dan19, 50)
    fallout.giq_option(4, 562, 170, Dan18, 50)
    fallout.giq_option(4, 562, 171, DanEnd, 50)
end

function Dan18()
    fallout.gsay_reply(562, 172)
    fallout.giq_option(5, 562, 173, Dan19, 50)
    fallout.giq_option(4, 562, 174, DanEnd, 50)
end

function Dan19()
    fallout.gsay_reply(562, 175)
    fallout.giq_option(4, 562, 176, Dan20, 51)
    fallout.giq_option(4, 562, 177, DanEnd, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 562, 178, Dan20, 51)
    end
    fallout.giq_option(4, 562, 179, Dan22, 50)
    fallout.giq_option(4, 562, 180, Dan23, 50)
end

function Dan20()
    fallout.gsay_reply(562, 181)
    fallout.giq_option(4, 562, 182, Dan21, 51)
    fallout.giq_option(4, 562, 183, Dan21, 51)
    fallout.giq_option(4, 562, 184, Dan24, 50)
    fallout.giq_option(4, 562, 185, Dan25, 50)
end

function Dan21()
    fallout.gsay_reply(562, 186)
    fallout.giq_option(4, 562, 187, DanEnd, 50)
    fallout.giq_option(4, 562, 188, DanEnd, 50)
    fallout.giq_option(4, 562, 189, DanEnd, 50)
end

function Dan22()
    fallout.set_local_var(7, 1)
    fallout.set_map_var(1, 1)
    fallout.gsay_message(562, 190, 50)
end

function Dan23()
    fallout.gsay_message(562, 191, 50)
end

function Dan24()
    fallout.gsay_reply(562, 192)
    fallout.giq_option(4, 562, 193, DanEnd, 51)
    fallout.giq_option(4, 562, 194, DanEnd, 51)
    fallout.giq_option(4, 562, 195, DanEnd, 51)
end

function Dan25()
    fallout.gsay_message(562, 196, 50)
end

function Dan26()
    if fallout.tile_num(fallout.external_var("Billy_ptr")) ~= 9858 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(562, fallout.random(197, 199)), 2)
    end
end

function Dan27()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(562, fallout.random(200, 203)), 2)
    fallout.set_map_var(0, 2)
end

function Dan28()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(562, fallout.random(208, 213)), 2)
end

function DanAtNight()
    if NightCount == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(562, 214), 2)
        NightCount = 1
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 4)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 5)
    end
end

function SendToStart()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 15522, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 12), 2)
end

function SendToStreet()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 15295, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 2), 3)
end

function SendToCattle1()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 12871, -1)
    fallout.reg_anim_func(3, 0)
    if fallout.random(1, 10) >= 6 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 3), 4)
    else
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 4), 1)
    end
end

function SendToCattle2()
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 12871, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(60 * 4), 1)
end

function SendToSleep()
    if Sleeping == 0 then
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 14932, -1)
        fallout.reg_anim_func(3, 0)
        SetDayNight = 0
        Sleeping = 1
    end
end

function DanEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.damage_p_proc = damage_p_proc
return exports
