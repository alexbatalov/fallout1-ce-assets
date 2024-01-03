local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
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
local LukeDialog
local LukeEnd
local LukeCombat
local Luke1
local Luke2
local Luke3
local Luke4
local Luke5
local Luke6
local Luke7
local Luke8

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
        if fallout.tile_num(self_obj) ~= 11099 then
            fallout.animate_move_obj_to_tile(self_obj, 11099, 0)
        else
            fallout.set_obj_visibility(self_obj, true)
            Sleeping = 2
            LastMove = 11099
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
        LukeDialog()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(609, 300))
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        SendToWork()
    end
end

function map_enter_p_proc()
    if time.is_night() then
        local self_obj = fallout.self_obj()
        fallout.move_to(self_obj, 11099, 0)
        fallout.set_obj_visibility(self_obj, true)
        Sleeping = 2
        LastMove = 11099
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

local WORK_TILES <const> = {
    11504,
    11904,
    12102,
    12299,
    11098,
    11497,
    10698,
    13503,
    13503,
    12700,
    12704,
    12305,
}

function SendToWork()
    local destination = 0
    local delay = fallout.random(15, 45)
    while destination == 0 do
        destination = WORK_TILES[fallout.random(1, #WORK_TILES)]
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
        if fallout.random(0, 100) >= 80 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(609, 124), 4)
        end
    end
end

function WakeUpCall()
    if not SetDayNight then
        Sleeping = 0
        SetDayNight = true
        local self_obj = fallout.self_obj()
        fallout.set_obj_visibility(self_obj, false)
        fallout.add_timer_event(self_obj, fallout.game_ticks(1), 5)
    end
end

function LukeDialog()
    fallout.start_gdialog(609, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Luke1()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function LukeEnd()
end

function LukeCombat()
    hostile = true
end

function Luke1()
    fallout.gsay_reply(609, 203)
    fallout.giq_option(-3, 609, 204, Luke2, 50)
    fallout.giq_option(4, 609, 205, Luke3, 50)
    fallout.giq_option(4, 609, 206, Luke4, 50)
    fallout.giq_option(4, 609, 207, Luke5, 50)
    fallout.giq_option(4, 609, 208, LukeEnd, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 609, 209, LukeCombat, 51)
    end
end

function Luke2()
    fallout.gsay_message(609, 210, 50)
end

function Luke3()
    fallout.gsay_reply(609, 211)
    fallout.giq_option(4, 609, 212, Luke4, 50)
    fallout.giq_option(4, 609, 213, Luke5, 50)
    fallout.giq_option(4, 609, 214, Luke6, 50)
    fallout.giq_option(4, 609, 215, Luke7, 50)
    fallout.giq_option(4, 609, 216, LukeEnd, 50)
end

function Luke4()
    fallout.gsay_reply(609, 217)
    fallout.giq_option(4, 609, 218, Luke5, 50)
    fallout.giq_option(4, 609, 219, LukeEnd, 50)
end

function Luke5()
    fallout.gsay_reply(609, 301)
    if CaravanAgain then
        fallout.giq_option(4, 609, 221, Luke8, 50)
        CaravanAgain = false
    end
    fallout.giq_option(4, 609, 222, Luke6, 50)
    fallout.giq_option(4, 609, 223, Luke3, 50)
    fallout.giq_option(4, 609, 224, Luke7, 50)
    fallout.giq_option(4, 609, 225, LukeEnd, 50)
end

function Luke6()
    fallout.gsay_reply(609, 226)
    fallout.giq_option(4, 609, 227, Luke4, 50)
    fallout.giq_option(4, 609, 228, Luke7, 50)
    fallout.giq_option(4, 609, 229, LukeEnd, 50)
end

function Luke7()
    fallout.gsay_reply(609, 230)
    fallout.giq_option(4, 609, 231, Luke3, 50)
    fallout.giq_option(4, 609, 232, Luke4, 50)
    fallout.giq_option(4, 609, 233, Luke5, 50)
    fallout.giq_option(4, 609, 234, LukeEnd, 50)
end

function Luke8()
    fallout.gsay_reply(609, 235)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 609, 236, LukeCombat, 51)
    end
    fallout.giq_option(4, 609, 237, Luke7, 50)
    fallout.giq_option(4, 609, 238, LukeEnd, 50)
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
