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
local damage_p_proc
local Caravan01
local Caravan02
local SendToWork
local SendToSleep
local WakeUpCall

local hostile = 0
local Only_Once = 1
local SetDayNight = 0
local Sleeping = 0
local LastMove = 0

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
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
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
    fallout.display_msg(fallout.message_str(609, 100))
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        SendToWork()
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function Caravan01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(609, fallout.random(101, 111)), 8)
end

function Caravan02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(609, fallout.random(112, 122)), 8)
end

function SendToWork()
    local v0 = 0
    local v1 = 0
    v0 = 0
    v1 = fallout.random(10, 35)
    while v0 == 0 do
        v0 = fallout.random(1, 12)
        if v0 == 1 then
            v0 = 9698
        else
            if v0 == 2 then
                v0 = 10702
            else
                if v0 == 3 then
                    v0 = 9904
                else
                    if v0 == 4 then
                        v0 = 10103
                    else
                        if v0 == 5 then
                            v0 = 10499
                        else
                            if v0 == 6 then
                                v0 = 10098
                            else
                                if v0 == 7 then
                                    v0 = 10300
                                else
                                    if v0 == 8 then
                                        v0 = 9299
                                    else
                                        if v0 == 9 then
                                            v0 = 9101
                                        else
                                            if v0 == 10 then
                                                v0 = 9696
                                            else
                                                if v0 == 11 then
                                                    v0 = 10303
                                                else
                                                    if v0 == 12 then
                                                        v0 = 9902
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
    end
end

function WakeUpCall()
    if SetDayNight == 0 then
        SetDayNight = 1
        fallout.set_obj_visibility(fallout.self_obj(), 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 3)
        if (Sleeping == 1) and (fallout.random(0, 100) >= 80) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(609, 126), 8)
        end
        Sleeping = 0
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
