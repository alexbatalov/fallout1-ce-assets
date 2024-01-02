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

local hostile = false
local initialized = false
local SetDayNight = false
local Sleeping = 0
local LastMove = 0
local CaravanAgain = true

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 64)
        fallout.critter_add_trait(self_obj, 1, 5, 50)
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
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
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
    if time.is_morning() or time.is_day() then
        WakeUpCall()
    else
        SendToSleep()
    end
    if Sleeping == 1 then
        local self_obj = fallout.self_obj()
        if fallout.tile_num(self_obj) ~= 10114 then
            fallout.animate_move_obj_to_tile(self_obj, 10114, 0)
        else
            fallout.set_obj_visibility(self_obj, true)
            Sleeping = 2
            LastMove = 10114
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    if time.is_morning() or time.is_day() then
        reaction.get_reaction()
        MatDialog()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
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
        local self_obj = fallout.self_obj()
        fallout.move_to(self_obj, 10114, 0)
        fallout.set_obj_visibility(self_obj, true)
        Sleeping = 2
        LastMove = 10114
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

local WORK_TILES <const> = {
    10518,
    11117,
    11115,
    10913,
    10711,
    10313,
    10115,
    9913,
    10111,
    9918,
    11317,
    11111,
}

function SendToWork()
    local destination = 0
    local delay = fallout.random(15, 45)
    while destination == 0 do
        destination = fallout.random(1, #WORK_TILES)
        if destination == LastMove then
            destination = 0
        end
    end
    LastMove = destination

    local self_obj = fallout.self_obj()
    fallout.reg_anim_func(2, self_obj)
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(self_obj, destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(delay), 1)
end

function SendToSleep()
    if Sleeping == 0 then
        Sleeping = 1
        SetDayNight = false
        if fallout.random(0, 100) >= 90 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(609, 201), 2)
        end
    end
end

function WakeUpCall()
    if not SetDayNight then
        Sleeping = 0
        SetDayNight = true
        local self_obj = fallout.self_obj()
        fallout.set_obj_visibility(self_obj, false)
        fallout.add_timer_event(self_obj, fallout.game_ticks(1), 1)
        if fallout.random(0, 100) >= 90 then
            fallout.float_msg(self_obj, fallout.message_str(609, 202), 2)
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
    hostile = true
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
    if CaravanAgain then
        fallout.giq_option(4, 609, 221, Mat8, 50)
        CaravanAgain = false
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
