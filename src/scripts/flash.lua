local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local destroy_p_proc
local Flash00
local Flash01
local Flash00N
local Flash00Na
local Flash01N
local Flash02N
local Flash03N
local Flash03Na
local Flash04N
local Flash05N
local Flash06N
local Flash07N
local Flash07Na
local Flash08Na
local Flash08Nb
local Flash09N
local Flash10N
local Flash11N
local FlashCombat
local FlashEnd

local hostile = false
local loitering = false

local damage_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("fetch_dude") ~= 0 then
            fallout.set_external_var("fetch_dude", 0)
            hostile = true
        end
    end
    if fallout.global_var(346) == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), dude_obj) then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(15) == 1 then
        fallout.kill_critter(self_obj, 57)
    end
    misc.set_team(self_obj, 19)
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if time.is_day() then
        if fallout.local_var(0) == 0 then
            Flash00()
        else
            Flash01()
        end
    else
        if loitering then
            Flash07N()
        else
            fallout.start_gdialog(36, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if fallout.local_var(0) == 0 then
                Flash00N()
            else
                Flash03N()
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function timed_event_p_proc()
    local event = fallout.fixed_param()
    if event == 1 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            loitering = true
            fallout.dialogue_system_enter()
        end
    elseif event == 2 then
        hostile = true
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
        reputation.inc_good_critter()
    end
end

function Flash00()
    fallout.set_local_var(0, 1)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(36, 100), 0)
end

function Flash01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(36, 106), 0)
end

function Flash00N()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(36, 101)
    fallout.giq_option(4, 36, 102, Flash01N, 50)
    fallout.giq_option(4, 36, 103, Flash10N, 50)
    fallout.giq_option(5, 36, 104, Flash00Na, 50)
    fallout.giq_option(4, 36, 128, Flash11N, 50)
    fallout.giq_option(-3, 36, 105, Flash10N, 50)
end

function Flash00Na()
    local max_hit_points = fallout.get_critter_stat(fallout.dude_obj(), 7)
    local curr_hit_points = fallout.get_critter_stat(fallout.dude_obj(), 35)
    if curr_hit_points == max_hit_points then
        Flash01N()
    else
        local modifier = -20
        if curr_hit_points < 5 then
            modifier = 0
        end
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, modifier)) then
            Flash02N()
        else
            Flash01N()
        end
    end
end

function Flash01N()
    local self_obj = fallout.self_obj()
    fallout.float_msg(self_obj, fallout.message_str(36, 107), 7)
    fallout.add_timer_event(self_obj, fallout.game_ticks(10), 2)
end

function Flash02N()
    fallout.gsay_message(36, 108, 50)
end

function Flash03N()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(36, 109)
    fallout.giq_option(4, 36, 110, Flash03Na, 50)
    fallout.giq_option(5, 36, 111, Flash03Na, 50)
    fallout.giq_option(-3, 36, 112, Flash06N, 50)
end

function Flash03Na()
    if fallout.elevation(fallout.self_obj()) == fallout.elevation(fallout.external_var("Morbid_ptr")) then
        Flash05N()
    else
        Flash04N()
    end
end

function Flash04N()
    fallout.gsay_reply(36, 113)
    fallout.giq_option(4, 36, 126, Flash11N, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
end

function Flash05N()
    fallout.gsay_message(36, 114, 50)
end

function Flash06N()
    fallout.gsay_message(36, 115, 50)
end

function Flash07N()
    fallout.gsay_reply(36, 116)
    fallout.giq_option(4, 36, 117, FlashCombat, 50)
    fallout.giq_option(5, 36, 118, Flash07Na, 50)
end

function Flash07Na()
    local modifier = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        modifier = -15
    else
        modifier = -25
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, modifier)) then
        Flash09N()
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            Flash08Nb()
        else
            Flash08Na()
        end
    end
end

function Flash08Na()
    fallout.gsay_reply(36, 119)
    fallout.giq_option(4, 36, 120, FlashCombat, 50)
    fallout.giq_option(5, 36, 121, FlashEnd, 50)
end

function Flash08Nb()
    fallout.gsay_reply(36, 122)
    fallout.giq_option(4, 36, 123, FlashCombat, 50)
    fallout.giq_option(5, 36, 124, FlashEnd, 50)
end

function Flash09N()
    fallout.gsay_message(36, 125, 50)
end

function Flash10N()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
end

function Flash11N()
    fallout.gsay_message(36, 127, 50)
end

function FlashCombat()
    hostile = true
end

function FlashEnd()
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(346, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
return exports
