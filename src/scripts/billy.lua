local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local combat_p_proc
local timed_event_p_proc
local Billy00
local Billy01
local Billy02
local Billy03
local Billy04
local Billy05
local Billy06
local Billy07
local Billy08
local Billy09
local Billy10
local Billy11
local Billy12
local Billy13
local Billy14
local Billy14a
local Billy15
local Billy15a
local Billy16
local Billy17
local Billy18
local Billy19
local Billy20
local Billy21
local Billy22
local Billy23
local BillyRunAway
local SendToStart
local SendToLeft
local SendToRight
local SendToLower
local SendToSleep
local BillyEnd

local hostile = false
local initialized = false
local Once_Which_One = false
local Runaway = false
local Sleeping = false
local SetDayNight = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 62)
        fallout.critter_add_trait(self_obj, 1, 5, 51)
        fallout.set_external_var("Billy_ptr", self_obj)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if not Runaway then
        if fallout.global_var(280) == 1 then
            BillyRunAway()
        end
        if time.is_morning() then
            if not SetDayNight then
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
                SetDayNight = true
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        Billy11()
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(6) == 1 then
        Billy10()
    else
        local self_obj = fallout.self_obj()
        local dan_obj = fallout.external_var("Dan_ptr")
        if fallout.obj_can_see_obj(self_obj, dan_obj) or fallout.obj_can_hear_obj(self_obj, dan_obj) then
            if fallout.map_var(0) ~= 2 then
                fallout.set_map_var(0, 1)
            end
        end
        if fallout.local_var(4) == 1 then
            if fallout.map_var(1) == 1 then
                Billy21()
            elseif fallout.map_var(0) == 2 then
                Billy14()
            else
                Billy23()
            end
        else
            Billy00()
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(158, fallout.global_var(158) + 1)
        fallout.set_global_var(155, fallout.global_var(155) - 1)
    end
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(556, 100))
end

function combat_p_proc()
    fallout.set_local_var(6, 1)
end

function timed_event_p_proc()
    if not Runaway then
        if time.is_morning() or time.is_day() then
            if Sleeping then
                local self_obj = fallout.self_obj()
                fallout.reg_anim_func(2, self_obj)
                fallout.reg_anim_func(1, 1)
                fallout.reg_anim_obj_move_to_tile(self_obj, 13889, -1)
                fallout.reg_anim_func(3, 0)
                fallout.add_timer_event(self_obj, fallout.game_ticks(60 * 5), 2)
                Sleeping = false
            else
                local event = fallout.fixed_param()
                if event == 1 then
                    SendToStart()
                elseif event == 2 then
                    SendToRight()
                elseif event == 3 then
                    SendToLeft()
                elseif event == 4 then
                    SendToLower()
                end
            end
        else
            SendToSleep()
        end
    end
end

function Billy00()
    fallout.set_local_var(4, 1)
    fallout.start_gdialog(556, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.gsay_reply(556, 101)
    fallout.giq_option(4, 556, 102, Billy04, 50)
    fallout.giq_option(4, 556, 103, Billy01, 50)
    fallout.giq_option(4, 556, 104, BillyEnd, 50)
    fallout.giq_option(-3, 556, 105, Billy06, 50)
    fallout.giq_option(-3, 556, 106, Billy06, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Billy01()
    fallout.set_local_var(11, 1)
    fallout.gsay_reply(556, 107)
    fallout.giq_option(4, 556, 108, Billy02, 50)
    fallout.giq_option(4, 556, 109, Billy03, 50)
end

function Billy02()
    fallout.set_global_var(106, 1)
    fallout.gsay_message(556, 110, 50)
end

function Billy03()
    fallout.gsay_message(556, 111, 50)
end

function Billy04()
    fallout.set_local_var(10, 1)
    fallout.gsay_reply(556, 112)
    fallout.giq_option(4, 556, 113, Billy12, 50)
    fallout.giq_option(4, 556, 114, Billy05, 50)
end

function Billy05()
    fallout.gsay_reply(556, 115)
    fallout.giq_option(4, 556, 116, Billy08, 50)
    fallout.giq_option(4, 556, 117, Billy07, 49)
    fallout.giq_option(4, 556, 118, BillyEnd, 50)
end

function Billy06()
    fallout.gsay_message(556, 119, 50)
end

function Billy07()
    fallout.gsay_message(556, 120, 49)
end

function Billy08()
    fallout.gsay_reply(556, 121)
    fallout.giq_option(4, 556, 122, BillyEnd, 50)
    fallout.giq_option(4, 556, 123, Billy09, 49)
end

function Billy09()
    fallout.gsay_message(556, 124, 49)
end

function Billy10()
    local self_obj = fallout.self_obj()
    if not Once_Which_One then
        Once_Which_One = true
        fallout.float_msg(self_obj, fallout.message_str(556, 125), 8)
    else
        fallout.float_msg(self_obj, fallout.message_str(556, fallout.random(126, 129)), 8)
    end
    fallout.animate_move_obj_to_tile(self_obj, 15890, 1)
end

function Billy11()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(556, 130), 8)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(556, 131), 8)
    end
end

function Billy12()
    fallout.gsay_reply(556, 132)
    fallout.giq_option(4, 556, 133, Billy13, 50)
    fallout.giq_option(4, 556, 134, BillyEnd, 50)
end

function Billy13()
    fallout.gsay_message(556, 135, 50)
end

function Billy14()
    if fallout.local_var(7) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(556, 142), 8)
    else
        fallout.set_local_var(7, 1)
        fallout.start_gdialog(556, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.gsay_reply(556, 136)
        fallout.giq_option(4, 556, 137, Billy15, 50)
        fallout.giq_option(4, 556, 138, Billy14a, 50)
        fallout.giq_option(4, 556, 139, BillyEnd, 50)
        fallout.giq_option(-3, 556, 140, Billy06, 50)
        fallout.giq_option(-3, 556, 141, Billy06, 50)
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Billy14a()
    if fallout.item_caps_total(fallout.dude_obj()) > 50 then
        fallout.item_caps_adjust(fallout.dude_obj(), -50)
        fallout.item_caps_adjust(fallout.self_obj(), 50)
        Billy19()
    else
        Billy20()
    end
end

function Billy15()
    fallout.gsay_reply(556, 143)
    fallout.giq_option(4, 556, 144, Billy15a, 50)
    fallout.giq_option(4, 556, 145, Billy18, 51)
    fallout.giq_option(4, 556, 146, BillyEnd, 50)
end

function Billy15a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Billy16()
    else
        Billy17()
    end
end

function Billy16()
    fallout.gsay_message(556, 147, 50)
end

function Billy17()
    fallout.gsay_message(556, 148, 51)
end

function Billy18()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(556, 149, 51)
    else
        fallout.gsay_message(556, 150, 51)
    end
end

function Billy19()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(556, 151, 49)
    else
        fallout.gsay_message(556, 152, 49)
    end
    BillyRunAway()
end

function Billy20()
    fallout.gsay_message(556, 153, 49)
end

function Billy21()
    if fallout.local_var(8) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(556, fallout.random(158, 164)), 8)
    else
        fallout.set_local_var(8, 1)
        fallout.start_gdialog(556, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.gsay_reply(556, 154)
        fallout.giq_option(4, 556, 155, Billy22, 50)
        fallout.giq_option(4, 556, 156, BillyEnd, 50)
        fallout.giq_option(-3, 556, 157, Billy06, 50)
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Billy22()
    fallout.gsay_message(556, 165, 50)
end

function Billy23()
    if fallout.local_var(9) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(556, fallout.random(172, 178)), 8)
    else
        fallout.set_local_var(9, 1)
        fallout.start_gdialog(556, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.gsay_reply(556, 166)
        if fallout.local_var(10) == 0 then
            fallout.giq_option(4, 556, 167, Billy04, 50)
        end
        if fallout.local_var(11) == 4 then
            fallout.giq_option(4, 556, 168, Billy01, 50)
        end
        fallout.giq_option(4, 556, 169, BillyEnd, 50)
        fallout.giq_option(-3, 556, 170, Billy06, 50)
        fallout.giq_option(-3, 556, 171, Billy06, 50)
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function BillyRunAway()
    Runaway = true
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 9858, 1)
end

function SendToStart()
    local self_obj = fallout.self_obj()
    if fallout.random(1, 10) >= 7 then
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 13889, -1)
        fallout.reg_anim_func(3, 0)
    else
        fallout.animate_move_obj_to_tile(self_obj, 13889, 1)
    end
    fallout.add_timer_event(self_obj, fallout.game_ticks(120), 2)
end

function SendToLeft()
    local self_obj = fallout.self_obj()
    if fallout.random(1, 10) >= 7 then
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 13889, -1)
        fallout.reg_anim_func(3, 0)
    else
        fallout.animate_move_obj_to_tile(self_obj, 13889, 1)
    end
    fallout.add_timer_event(self_obj, fallout.game_ticks(60), 4)
end

function SendToRight()
    local self_obj = fallout.self_obj()
    if fallout.random(1, 10) >= 7 then
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 12072, -1)
        fallout.reg_anim_func(3, 0)
    else
        fallout.animate_move_obj_to_tile(self_obj, 12072, 1)
    end
    fallout.add_timer_event(self_obj, fallout.game_ticks(60), 3)
end

function SendToLower()
    local self_obj = fallout.self_obj()
    if fallout.random(1, 10) >= 7 then
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 13872, -1)
        fallout.reg_anim_func(3, 0)
    else
        fallout.animate_move_obj_to_tile(self_obj, 13872, 1)
    end
    fallout.add_timer_event(self_obj, fallout.game_ticks(90), 1)
end

function SendToSleep()
    if not Sleeping then
        local self_obj = fallout.self_obj()
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 16285, -1)
        fallout.reg_anim_func(3, 0)
        Sleeping = true
        SetDayNight = false
    end
end

function BillyEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.combat_p_proc = combat_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
