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

local hostile = false
local initialized = false
local SetDayNight = false
local Sleeping = 0
local LastMove = 0
local CaravanAgain = true

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 64)
        fallout.critter_add_trait(self_obj, 1, 5, 50)
        fallout.obj_set_light_level(self_obj, 100, 8)
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
    if time.is_evening() or time.is_night() then
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
    reaction.get_reaction()
    JohnDialog()
end

function destroy_p_proc()
    reputation.inc_good_critter()
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

function SendToWork()
    local dest = 0
    local delay = fallout.random(5, 10)
    if fallout.random(0, 100) > 70 then
        while dest == 0 do
            local rnd = fallout.random(1, 4)
            if rnd == 1 then
                dest = 10311
            elseif rnd == 2 then
                dest = 10103
            elseif rnd == 3 then
                dest = 11914
            elseif rnd == 4 then
                dest = 111504
            end
            if dest == LastMove then
                dest = 0
            end
        end
    else
        if LastMove == 10910 then
            dest = 10903
        else
            dest = 10910
        end
    end
    LastMove = dest
    local self_obj = fallout.self_obj()
    fallout.reg_anim_func(2, self_obj)
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(self_obj, dest, -1)
    fallout.reg_anim_func(3, 0)
    fallout.add_timer_event(self_obj, fallout.game_ticks(delay), 1)
end

function SendToSleep()
    if Sleeping == 0 then
        Sleeping = 1
        SetDayNight = false
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
    hostile = true
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
    if reputation.has_rep_berserker() then
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
    if CaravanAgain then
        fallout.giq_option(4, 609, 221, John8, 50)
        CaravanAgain = false
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
    if reputation.has_rep_berserker() then
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
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 609, 409, JohnCombat, 51)
    end
    fallout.giq_option(4, 609, 410, JohnEnd, 50)
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
