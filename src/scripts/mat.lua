local fallout = require("fallout")
local reaction = require("lib.reaction")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local map_enter_p_proc
local damage_p_proc
local SendToWork
local SendToSleep
local WakeUpCall
local MatDialog
local MatEnd
local MatCombat
local Mat1
local Mat2
local Mat3
local Mat4
local Mat5
local Mat6
local Mat7
local Mat8

local hostile = 0
local Only_Once = 1
local SetDayNight = 0
local Sleeping = 0
local LastMove = 0
local CaravanAgain = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 64)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
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
                        else
                            if fallout.script_action() == 15 then
                                map_enter_p_proc()
                            end
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
    if time.is_morning() or time.is_day() then
        WakeUpCall()
    else
        SendToSleep()
    end
    if Sleeping == 1 then
        if fallout.tile_num(fallout.self_obj()) ~= 10114 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 10114, 0)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            Sleeping = 2
            LastMove = 10114
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    if time.is_morning() or time.is_day() then
        reaction.get_reaction()
        MatDialog()
    end
end

function destroy_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(609, 200))
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        SendToWork()
    end
end

function map_enter_p_proc()
    if time.is_night() then
        fallout.move_to(fallout.self_obj(), 10114, 0)
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        Sleeping = 2
        LastMove = 10114
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function SendToWork()
    local v0 = 0
    local v1 = 0
    v0 = 0
    v1 = fallout.random(15, 45)
    while v0 == 0 do
        v0 = fallout.random(1, 12)
        if v0 == 1 then
            v0 = 10518
        else
            if v0 == 2 then
                v0 = 11117
            else
                if v0 == 3 then
                    v0 = 11115
                else
                    if v0 == 4 then
                        v0 = 10913
                    else
                        if v0 == 5 then
                            v0 = 10711
                        else
                            if v0 == 6 then
                                v0 = 10313
                            else
                                if v0 == 7 then
                                    v0 = 10115
                                else
                                    if v0 == 8 then
                                        v0 = 9913
                                    else
                                        if v0 == 9 then
                                            v0 = 10111
                                        else
                                            if v0 == 10 then
                                                v0 = 9918
                                            else
                                                if v0 == 11 then
                                                    v0 = 11317
                                                else
                                                    if v0 == 12 then
                                                        v0 = 11111
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
        if v0 == LastMove then
            v0 = 0
        end
    end
    LastMove = v0
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), v0, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(v1), 1)
end

function SendToSleep()
    if Sleeping == 0 then
        Sleeping = 1
        SetDayNight = 0
        if fallout.random(0, 100) >= 90 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(609, 201), 2)
        end
    end
end

function WakeUpCall()
    if SetDayNight == 0 then
        Sleeping = 0
        SetDayNight = 1
        fallout.set_obj_visibility(fallout.self_obj(), 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
        if fallout.random(0, 100) >= 90 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(609, 202), 2)
        end
    end
end

function MatDialog()
    fallout.start_gdialog(609, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Mat1()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function MatEnd()
end

function MatCombat()
    hostile = 1
end

function Mat1()
    fallout.gsay_reply(609, 203)
    fallout.giq_option(-3, 609, 204, Mat2, 50)
    fallout.giq_option(4, 609, 205, Mat3, 50)
    fallout.giq_option(4, 609, 206, Mat4, 50)
    fallout.giq_option(4, 609, 207, Mat5, 50)
    fallout.giq_option(4, 609, 208, MatEnd, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 609, 209, MatCombat, 51)
    end
end

function Mat2()
    fallout.gsay_message(609, 210, 50)
end

function Mat3()
    fallout.gsay_reply(609, 211)
    fallout.giq_option(4, 609, 212, Mat4, 50)
    fallout.giq_option(4, 609, 213, Mat5, 50)
    fallout.giq_option(4, 609, 214, Mat6, 50)
    fallout.giq_option(4, 609, 215, Mat7, 50)
    fallout.giq_option(4, 609, 216, MatEnd, 50)
end

function Mat4()
    fallout.gsay_reply(609, 217)
    fallout.giq_option(4, 609, 218, Mat5, 50)
    fallout.giq_option(4, 609, 219, MatEnd, 50)
end

function Mat5()
    if fallout.global_var(71) == 0 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(74) == 0 then
        fallout.set_global_var(74, 1)
    end
    if fallout.global_var(68) == 0 then
        fallout.set_global_var(68, 1)
    end
    if fallout.global_var(72) == 0 then
        fallout.set_global_var(72, 1)
    end
    if fallout.global_var(76) == 0 then
        fallout.set_global_var(76, 1)
    end
    fallout.gsay_reply(609, 220)
    if CaravanAgain == 1 then
        fallout.giq_option(4, 609, 221, Mat8, 50)
        CaravanAgain = 0
    end
    fallout.giq_option(4, 609, 222, Mat6, 50)
    fallout.giq_option(4, 609, 223, Mat3, 50)
    fallout.giq_option(4, 609, 224, Mat7, 50)
    fallout.giq_option(4, 609, 225, MatEnd, 50)
end

function Mat6()
    fallout.gsay_reply(609, 226)
    fallout.giq_option(4, 609, 227, Mat4, 50)
    fallout.giq_option(4, 609, 228, Mat7, 50)
    fallout.giq_option(4, 609, 229, MatEnd, 50)
end

function Mat7()
    fallout.gsay_reply(609, 230)
    fallout.giq_option(4, 609, 231, Mat3, 50)
    fallout.giq_option(4, 609, 232, Mat4, 50)
    fallout.giq_option(4, 609, 233, Mat5, 50)
    fallout.giq_option(4, 609, 234, MatEnd, 50)
end

function Mat8()
    fallout.gsay_reply(609, 235)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 609, 236, MatCombat, 51)
    end
    fallout.giq_option(4, 609, 237, Mat7, 50)
    fallout.giq_option(4, 609, 238, MatEnd, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.damage_p_proc = damage_p_proc
return exports
