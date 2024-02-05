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
local look_at_p_proc
local timed_event_p_proc
local damage_p_proc
local Caravan01
local Caravan02
local SendToWork
local SendToSleep
local WakeUpCall

local hostile = false
local initialized = false
local SetDayNight = false
local Sleeping = false
local LastMove = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 64)
        misc.set_ai(self_obj, 50)
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
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    if time.is_morning() or time.is_day() then
        reaction.get_reaction()
        if fallout.map_var(2) == 1 then
            Caravan02()
        else
            Caravan01()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(609, 100))
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        SendToWork()
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function Caravan01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(609, fallout.random(101, 111)), 3)
end

function Caravan02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(609, fallout.random(112, 122)), 3)
end

local WORK_TILES <const> = {
    12718,
    12915,
    11514,
    11914,
    12120,
    11720,
    11518,
    12520,
    12313,
    11716,
    11712,
    11721,
}

function SendToWork()
    local destination = 0
    local delay = fallout.random(10, 30)
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
    if not Sleeping then
        Sleeping = true
        SetDayNight = false
    end
end

function WakeUpCall()
    if not SetDayNight then
        SetDayNight = true
        fallout.set_obj_visibility(fallout.self_obj(), false)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
        if Sleeping and fallout.random(0, 100) >= 80 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(609, 125), 3)
        end
        Sleeping = false
    end
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
