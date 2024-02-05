local fallout = require("fallout")
local misc = require("lib.misc")
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
local destination = 0
local Count = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 65)
        fallout.critter_add_trait(self_obj, 1, 5, 51)
        initialized = true
        LastMove = 22939
        Count = fallout.random(0, 5)
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
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if not time.is_night() then
        if not SetDayNight then
            fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(20, 30)), 1)
            SetDayNight = true
        end
    else
        if not Sleeping then
            fallout.add_timer_event(self_obj, fallout.game_ticks(2), 1)
        end
    end
    if fallout.tile_num(self_obj) == 27725 then
        if fallout.has_trait(1, self_obj, 10) ~= 0 then
            fallout.anim(self_obj, 1000, 0)
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
    fallout.display_msg(fallout.message_str(580, 100))
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
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function Farmer00()
    if fallout.global_var(5) == 1 then
        local num = fallout.random(101, 109)
        if num == 108 then
            num = 109
        end
        fallout.float_msg(fallout.self_obj(), fallout.message_str(580, num), 3)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(580, fallout.random(101, 108)), 3)
    end
end

function Farmer01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(580, fallout.random(110, 114)), 3)
end

local WORK_TILES <const> = {
    22939,
    21738,
    20538,
    20742,
    21742,
    22542,
    23742,
    24146,
}

function SendToWork()
    destination = 0
    local delay = fallout.random(10, 30)
    while destination == 0 do
        destination = WORK_TILES[fallout.random(1, #WORK_TILES)]
        if destination == LastMove then
            destination = 0
        end
    end
    Count = Count + 1
    if Count >= 6 then
        Count = 0
        destination = 26935
        delay = 35
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
        local self_obj = fallout.self_obj()
        fallout.reg_anim_func(2, self_obj)
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 27725, -1)
        fallout.reg_anim_func(3, 0)
        Sleeping = true
        SetDayNight = false
        Count = 0
        LastMove = 27725
    end
end

function CheckWorkHeading()
    if not Sleeping then
        local self_obj = fallout.self_obj()
        local tile = fallout.tile_num(self_obj)
        if tile == LastMove then
            if tile == 24146 then
                if fallout.has_trait(1, self_obj, 10) ~= 2 then
                    fallout.anim(self_obj, 1000, 2)
                end
            else
                if fallout.has_trait(1, self_obj, 10) ~= 0 then
                    fallout.anim(self_obj, 1000, 0)
                end
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
