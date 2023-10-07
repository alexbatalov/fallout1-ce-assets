local fallout = require("fallout")

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
local Only_Once = 1
local SetDayNight = 0
local Sleeping = 0
local LastMove = 0
local destination = 0
local CurrentTile = 0
local Count = 0

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

function start()
    if Only_Once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 65)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 51)
        Only_Once = 0
        LastMove = 21347
        Count = fallout.random(0, 7)
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
    if not((fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600)) then
        if SetDayNight == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(30, 40)), 1)
            SetDayNight = 1
        end
    else
        if Sleeping == 0 then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
        end
    end
    if fallout.tile_num(fallout.self_obj()) == 26728 then
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
    get_reaction()
    if (fallout.game_time_hour() >= 600) and (fallout.game_time_hour() < 700) or ((fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800)) then
        Farmer00()
    else
        Farmer01()
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
    fallout.display_msg(fallout.message_str(580, 100))
end

function timed_event_p_proc()
    if (fallout.game_time_hour() >= 600) and (fallout.game_time_hour() < 700) or ((fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800)) then
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
    if fallout.global_var(5) == 1 then
        v0 = fallout.random(101, 109)
        if v0 == 108 then
            v0 = 109
        end
        fallout.float_msg(fallout.self_obj(), fallout.message_str(580, v0), 8)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(580, fallout.random(101, 108)), 8)
    end
end

function Farmer01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(580, fallout.random(110, 114)), 8)
end

function SendToWork()
    local v0 = 0
    destination = 0
    v0 = fallout.random(8, 25)
    while destination == 0 do
        destination = fallout.random(1, 8)
        if destination == 1 then
            destination = 21347
        else
            if destination == 2 then
                destination = 22546
            else
                if destination == 3 then
                    destination = 23146
                else
                    if destination == 4 then
                        destination = 21750
                    else
                        if destination == 5 then
                            destination = 22750
                        else
                            if destination == 6 then
                                destination = 20554
                            else
                                if destination == 7 then
                                    destination = 21150
                                else
                                    if destination == 8 then
                                        destination = 24146
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
    Count = Count + 1
    if Count >= 8 then
        Count = 0
        destination = 26935
        v0 = 35
    end
    LastMove = destination
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(v0), 1)
end

function SendToSleep()
    if Sleeping == 0 then
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), 26728, -1)
        fallout.reg_anim_func(3, 0)
        Sleeping = 1
        SetDayNight = 0
        Count = 0
        LastMove = 26728
    end
end

function CheckWorkHeading()
    if Sleeping == 0 then
        CurrentTile = fallout.tile_num(fallout.self_obj())
        if CurrentTile == LastMove then
            if CurrentTile == 24146 then
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 2 then
                    fallout.anim(fallout.self_obj(), 1000, 2)
                end
            else
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 0 then
                    fallout.anim(fallout.self_obj(), 1000, 0)
                end
            end
        end
    end
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
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
