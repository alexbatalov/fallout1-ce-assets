local fallout = require("fallout")
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
local JohnDialog
local JohnEnd
local JohnCombat
local John1
local John2
local John3
local John4
local John5
local John6
local John7
local John8
local John9

local hostile = 0
local Only_Once = 1
local SetDayNight = 0
local Sleeping = 0
local LastMove = 0
local CaravanAgain = 1

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
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 64)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
        fallout.obj_set_light_level(fallout.self_obj(), 100, 8)
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
    if time.is_evening() or time.is_night() then
        WakeUpCall()
    else
        SendToSleep()
    end
    if Sleeping == 1 then
        if fallout.tile_num(fallout.self_obj()) ~= 11099 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 11099, 0)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            Sleeping = 2
            LastMove = 11099
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    JohnDialog()
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
    fallout.display_msg(fallout.message_str(609, 400))
end

function timed_event_p_proc()
    if fallout.random(1, 100) > 85 then
        fallout.anim(fallout.self_obj(), 1000, fallout.random(0, 5))
    else
        if time.is_evening() or time.is_night() then
            SendToWork()
        end
    end
end

function map_enter_p_proc()
    if time.is_night() then
        fallout.move_to(fallout.self_obj(), 11099, 0)
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        Sleeping = 2
        LastMove = 11099
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
    v1 = fallout.random(5, 10)
    if fallout.random(0, 100) > 70 then
        while v0 == 0 do
            v0 = fallout.random(1, 4)
            if v0 == 1 then
                v0 = 10311
            else
                if v0 == 2 then
                    v0 = 10103
                else
                    if v0 == 3 then
                        v0 = 11914
                    else
                        if v0 == 4 then
                            v0 = 111504
                        end
                    end
                end
            end
            if v0 == LastMove then
                v0 = 0
            end
        end
    else
        if LastMove == 10910 then
            v0 = 10903
        else
            v0 = 10910
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
        Sleeping = 0
        SetDayNight = 1
        fallout.set_obj_visibility(fallout.self_obj(), 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 5)
    end
end

function JohnDialog()
    fallout.start_gdialog(609, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    John1()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function JohnEnd()
end

function JohnCombat()
    hostile = 1
end

function John1()
    fallout.gsay_reply(609, 203)
    fallout.giq_option(-3, 609, 204, John2, 50)
    fallout.giq_option(4, 609, 401, John9, 50)
    fallout.giq_option(4, 609, 205, John3, 50)
    if fallout.global_var(101) == 0 then
        fallout.giq_option(4, 609, 206, John4, 50)
    end
    fallout.giq_option(4, 609, 207, John5, 50)
    fallout.giq_option(4, 609, 208, JohnEnd, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 609, 209, JohnCombat, 51)
    end
end

function John2()
    fallout.gsay_message(609, 402, 50)
end

function John3()
    fallout.gsay_reply(609, 211)
    if fallout.global_var(101) == 0 then
        fallout.giq_option(4, 609, 212, John4, 50)
    end
    fallout.giq_option(4, 609, 213, John5, 50)
    fallout.giq_option(4, 609, 214, John6, 50)
    fallout.giq_option(4, 609, 215, John7, 50)
    fallout.giq_option(4, 609, 216, JohnEnd, 50)
end

function John4()
    fallout.gsay_reply(609, 403)
    fallout.giq_option(4, 609, 218, John5, 50)
    fallout.giq_option(4, 609, 219, JohnEnd, 50)
end

function John5()
    fallout.gsay_reply(609, 404)
    if CaravanAgain == 1 then
        fallout.giq_option(4, 609, 221, John8, 50)
        CaravanAgain = 0
    end
    fallout.giq_option(4, 609, 222, John6, 50)
    fallout.giq_option(4, 609, 223, John3, 50)
    fallout.giq_option(4, 609, 224, John7, 50)
    fallout.giq_option(4, 609, 225, JohnEnd, 50)
end

function John6()
    fallout.gsay_reply(609, 405)
    if fallout.global_var(101) == 0 then
        fallout.giq_option(4, 609, 227, John4, 50)
    end
    fallout.giq_option(4, 609, 228, John7, 50)
    fallout.giq_option(4, 609, 229, JohnEnd, 50)
end

function John7()
    fallout.gsay_reply(609, 406)
    fallout.giq_option(4, 609, 231, John3, 50)
    if fallout.global_var(101) == 0 then
        fallout.giq_option(4, 609, 232, John4, 50)
    end
    fallout.giq_option(4, 609, 233, John5, 50)
    fallout.giq_option(4, 609, 234, JohnEnd, 50)
end

function John8()
    fallout.gsay_reply(609, 235)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 609, 236, JohnCombat, 51)
    end
    fallout.giq_option(4, 609, 237, John7, 50)
    fallout.giq_option(4, 609, 238, JohnEnd, 50)
end

function John9()
    fallout.gsay_reply(609, 407)
    fallout.giq_option(4, 609, 223, John3, 50)
    if fallout.global_var(101) == 0 then
        fallout.giq_option(4, 609, 232, John4, 50)
    end
    fallout.giq_option(4, 609, 408, John5, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 609, 409, JohnCombat, 51)
    end
    fallout.giq_option(4, 609, 410, JohnEnd, 50)
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
exports.map_enter_p_proc = map_enter_p_proc
exports.damage_p_proc = damage_p_proc
return exports
