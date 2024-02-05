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

local hostile = false
local initialized = false
local Sleeping = false
local SetDayNight = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 62)
        misc.set_ai(self_obj, 51)
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
    if time.is_morning() then
        if not SetDayNight then
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
            SetDayNight = true
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
    if fallout.global_var(280) == 1 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(563, 103), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(563, 104), 2)
        end
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(563, fallout.random(101, 102)), 2)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.global_var(280) == 1 then
        fallout.display_msg(fallout.message_str(563, 105))
    else
        fallout.display_msg(fallout.message_str(563, 100))
    end
end

function timed_event_p_proc()
    if time.is_morning() or time.is_day() then
        Sleeping = false
        local event = fallout.fixed_param()
        if event == 1 then
            local self_obj = fallout.self_obj()
            fallout.reg_anim_func(2, self_obj)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_tile(self_obj, 15330, -1)
            fallout.reg_anim_func(3, 0)
            fallout.add_timer_event(self_obj, fallout.game_ticks(30), 2)
        elseif event == 2 then
            local self_obj = fallout.self_obj()
            fallout.reg_anim_func(2, self_obj)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_tile(self_obj, 15122, -1)
            fallout.reg_anim_func(3, 0)
            fallout.add_timer_event(self_obj, fallout.game_ticks(60 * 1), 3)
        elseif event == 3 then
            local self_obj = fallout.self_obj()
            fallout.reg_anim_func(2, self_obj)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_tile(self_obj, 14930, -1)
            fallout.reg_anim_func(3, 0)
        end
    else
        if not Sleeping then
            local self_obj = fallout.self_obj()
            fallout.reg_anim_func(2, self_obj)
            fallout.reg_anim_func(1, 1)
            fallout.reg_anim_obj_move_to_tile(self_obj, 14930, -1)
            fallout.reg_anim_func(3, 0)
            Sleeping = true
            SetDayNight = false
        end
    end
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
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
