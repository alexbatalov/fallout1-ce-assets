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
local Farmer00
local Farmer01
local SendToWork
local SendToSleep
local CheckWorkHeading

local hostile = false
local initialized = false
local SetDayNight = false
local Sleeping = false
local LastMove = 0
local CurrentTile = 0

local WORK_TILES <const> = {
    21931,
    23330,
    20934,
    23134,
    21538,
    20542,
    23342,
    22150,
    23146,
}

local HOME_TILE <const> = 26724

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 65)
        fallout.critter_add_trait(self_obj, 1, 5, 51)
        initialized = true
        LastMove = 21931
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

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if not time.is_night() then
        if not SetDayNight then
            fallout.add_timer_event(self_obj, fallout.game_ticks(30), 1)
            SetDayNight = true
        end
    else
        if not Sleeping then
            fallout.add_timer_event(self_obj, fallout.game_ticks(2), 1)
        end
    end
    if fallout.tile_num(self_obj) == HOME_TILE then
        if fallout.has_trait(1, self_obj, 10) ~= 2 then
            fallout.anim(self_obj, 1000, 2)
        end
    end
    CheckWorkHeading()
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if time.is_morning() or time.is_day() then
        Farmer00()
    else
        Farmer01()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(571, 100))
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        Sleeping = false
        SendToWork()
    else
        SendToSleep()
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function Farmer00()
    local rnd = fallout.random(1, 5)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 101), 2)
    elseif rnd == 2 then
        local game_time_hour = fallout.game_time_hour()
        if game_time_hour >= 600 and game_time_hour < 1200 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 102), 2)
        elseif game_time_hour >= 1200 and game_time_hour < 1600 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 103), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 104), 2)
        end
    elseif rnd == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 105), 2)
    elseif rnd == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 106), 2)
    elseif rnd == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 107), 2)
    else
        -- FIXME: Unreachable.
        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 108), 2)
    end
end

function Farmer01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(571, fallout.random(109, 116)), 2)
end

function SendToWork()
    local destination = 0
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
    fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(10, 30)), 1)
end

function SendToSleep()
    if not Sleeping then
        local self_obj = fallout.self_obj()
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, HOME_TILE, -1)
        fallout.reg_anim_func(3, 0)
        Sleeping = true
        SetDayNight = false
        LastMove = HOME_TILE
    end
end

function CheckWorkHeading()
    if not Sleeping then
        CurrentTile = fallout.tile_num(fallout.self_obj())
        if CurrentTile == LastMove then
            if fallout.has_trait(1, fallout.self_obj(), 10) ~= 0 then
                fallout.anim(fallout.self_obj(), 1000, 0)
            end
        end
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
