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
local Farmer00
local Farmer01
local SendToWork
local SendToSleep
local CheckWorkHeading

local hostile = 0
local initialized = false
local SetDayNight = 0
local Sleeping = 0
local LastMove = 0
local destination = 0
local CurrentTile = 0

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 65)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 51)
        initialized = true
        LastMove = 21931
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
    if not time.is_night() then
        if SetDayNight == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(30), 1)
            SetDayNight = 1
        end
    else
        if Sleeping == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
        end
    end
    if fallout.tile_num(fallout.self_obj()) == 26724 then
        if fallout.has_trait(1, fallout.self_obj(), 10) ~= 2 then
            fallout.anim(fallout.self_obj(), 1000, 2)
        end
    end
    CheckWorkHeading()
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
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
        Sleeping = 0
        SendToWork()
    else
        SendToSleep()
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function Farmer00()
    local v0 = 0
    v0 = fallout.random(1, 5)
    if v0 == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 101), 2)
    else
        if v0 == 2 then
            if (fallout.game_time_hour() >= 600) and (fallout.game_time_hour() < 1200) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 102), 2)
            else
                if (fallout.game_time_hour() >= 1200) and (fallout.game_time_hour() < 1600) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 103), 2)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 104), 2)
                end
            end
        else
            if v0 == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 105), 2)
            else
                if v0 == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 106), 2)
                else
                    if v0 == 5 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 107), 2)
                    else
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(571, 108), 2)
                    end
                end
            end
        end
    end
end

function Farmer01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(571, fallout.random(109, 116)), 2)
end

function SendToWork()
    destination = 0
    while destination == 0 do
        destination = fallout.random(1, 9)
        if destination == 1 then
            destination = 21931
        else
            if destination == 2 then
                destination = 23330
            else
                if destination == 3 then
                    destination = 20934
                else
                    if destination == 4 then
                        destination = 23134
                    else
                        if destination == 5 then
                            destination = 21538
                        else
                            if destination == 6 then
                                destination = 20542
                            else
                                if destination == 7 then
                                    destination = 23342
                                else
                                    if destination == 8 then
                                        destination = 22150
                                    else
                                        if destination == 9 then
                                            destination = 23146
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if destination == LastMove then
            destination = 0
        end
    end
    LastMove = destination
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(10, 30)), 1)
end

function SendToSleep()
    if Sleeping == 0 then
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 26724, -1)
        fallout.reg_anim_func(3, 0)
        Sleeping = 1
        SetDayNight = 0
        LastMove = 26724
    end
end

function CheckWorkHeading()
    if Sleeping == 0 then
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
