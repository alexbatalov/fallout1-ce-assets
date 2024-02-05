local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local map_enter_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local ChildEnd
local child_heal
local child_pois
local Child00
local Child01
local Child02
local Child03
local Child04
local Child04a
local Child05
local Child05a
local Child05b
local Child06
local Child07
local Child08
local Child09
local Child09a
local Child10
local Child11
local Child12
local Child13
local Child14
local Child15
local Child16
local Child17

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local scared = false
local cost = 0
local hp_injured = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if scared and fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 and fallout.local_var(4) == 0 then
        behaviour.flee_dude(1)
    else
        behaviour.sleeping(4, night_person, wake_time, sleep_time, home_tile, sleep_tile)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(15) == 1 then
        fallout.destroy_object(self_obj)
    end
    wake_time = 700
    sleep_time = 1900
    misc.set_team(self_obj, 20)
    if fallout.local_var(6) == 0 then
        fallout.set_local_var(6, fallout.tile_num(self_obj))
    end
    home_tile = fallout.local_var(6)
    sleep_tile = 15275
    if time.game_time_in_days() < 80 then
        fallout.set_obj_visibility(self_obj, true)
    else
        fallout.set_obj_visibility(self_obj, false)
    end
end

function map_update_p_proc()
    if time.game_time_in_days() < 80 then
        fallout.set_obj_visibility(fallout.self_obj(), true)
    else
        fallout.set_obj_visibility(fallout.self_obj(), false)
    end
end

function pickup_p_proc()
    scared = true
end

function talk_p_proc()
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(108, 145), 2)
    else
        if fallout.local_var(5) == 0 then
            fallout.start_gdialog(108, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Child00()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function ChildEnd()
end

function child_heal()
    fallout.game_time_advance(fallout.game_ticks(600 * hp_injured))
    fallout.critter_heal(fallout.dude_obj(), hp_injured)
    fallout.set_global_var(154, fallout.global_var(154) - 1)
end

function child_pois()
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        fallout.game_time_advance(fallout.game_ticks(1800))
    end
    fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
end

function Child00()
    fallout.gsay_reply(108, 100)
    fallout.giq_option(4, 108, 101, Child04, 50)
    fallout.giq_option(5, 108, 102, Child11, 50)
    if fallout.map_var(2) == 1 and fallout.local_var(7) == 0 then
        fallout.giq_option(5, 108, 103, Child15, 50)
    end
    fallout.giq_option(-3, 108, 104, Child01, 50)
end

function Child01()
    fallout.gsay_message(108, 105, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 35) < fallout.get_critter_stat(fallout.dude_obj(), 7) then
        child_heal()
        Child03()
    else
        Child02()
    end
end

function Child02()
    fallout.gsay_message(108, 106, 50)
end

function Child03()
    fallout.critter_heal(fallout.dude_obj(),
        fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35))
    fallout.poison(fallout.dude_obj(), -fallout.get_poison(fallout.dude_obj()))
    fallout.gsay_message(108, 107, 50)
end

function Child04()
    local healing_cost
    local poison_cost
    if fallout.local_var(1) == 3 then
        healing_cost = 5
        poison_cost = 12
    elseif fallout.local_var(1) == 1 then
        healing_cost = 20
        poison_cost = 50
    else
        healing_cost = 10
        poison_cost = 25
    end
    hp_injured = fallout.get_critter_stat(fallout.dude_obj(), 7) - fallout.get_critter_stat(fallout.dude_obj(), 35)
    cost = hp_injured * healing_cost
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        cost = cost + poison_cost
    end
    if hp_injured > 0 then
        fallout.gsay_message(108, 108, 50)
    end
    if fallout.get_poison(fallout.dude_obj()) ~= 0 then
        fallout.gsay_message(108, 109, 50)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 37) > 50 then
        fallout.gsay_message(108, 110, 50)
    end
    if cost > 0 then
        fallout.gsay_reply(108, fallout.message_str(108, 111) .. cost .. fallout.message_str(108, 112))
        fallout.giq_option(4, 108, 113, Child04a, 50)
        fallout.giq_option(4, 108, 114, ChildEnd, 50)
        fallout.giq_option(4, 108, 115, Child09, 50)
        fallout.giq_option(4, 108, fallout.message_str(108, 116) .. (cost * 0.75000) .. fallout.message_str(108, 117),
            Child05, 50)
    else
        fallout.gsay_message(108, 146, 50)
    end
end

function Child04a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        Child08()
    else
        Child06()
    end
end

function Child05()
    fallout.gsay_reply(108, 118)
    fallout.giq_option(4, 108, 119, Child05a, 50)
    fallout.giq_option(4, 108, 120, Child05b, 51)
end

function Child05a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        Child08()
    else
        Child06()
    end
end

function Child05b()
    fallout.set_local_var(5, 1)
    ChildEnd()
end

function Child06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(108, 121)
    else
        fallout.gsay_reply(108, 122)
    end
    fallout.giq_option(0, 634, 106, Child07, 50)
end

function Child07()
    fallout.gfade_out(600)
    fallout.item_caps_adjust(fallout.dude_obj(), -cost)
    child_heal()
    child_pois()
    fallout.gfade_in(600)
    fallout.gsay_message(108, 123, 50)
end

function Child08()
    fallout.gsay_reply(108, 124)
    cost = fallout.item_caps_total(fallout.dude_obj())
    fallout.giq_option(4, 108, 125, Child06, 50)
    fallout.giq_option(4, 108, 129, ChildEnd, 50)
end

function Child09()
    fallout.gsay_reply(108, 127)
    fallout.giq_option(4, 108, 128, Child09a, 50)
    fallout.giq_option(4, 108, 129, ChildEnd, 50)
end

function Child09a()
    if cost > fallout.item_caps_total(fallout.dude_obj()) then
        Child06()
    else
        Child10()
    end
end

function Child10()
    fallout.gsay_reply(108, 130)
    fallout.giq_option(0, 634, 106, Child06, 50)
end

function Child11()
    fallout.gsay_reply(108, 131)
    fallout.giq_option(4, 108, 132, ChildEnd, 50)
    fallout.giq_option(4, 108, 133, Child12, 50)
end

function Child12()
    fallout.gsay_reply(108, 134)
    fallout.giq_option(4, 108, 135, Child14, 50)
    fallout.giq_option(4, 108, 136, Child13, 50)
end

function Child13()
    fallout.gsay_message(108, 137, 51)
end

function Child14()
    fallout.gsay_reply(108, 138)
    fallout.giq_option(4, 108, 139, ChildEnd, 50)
end

function Child15()
    fallout.set_local_var(7, 1)
    fallout.gsay_reply(108, 140)
    fallout.giq_option(5, 108, 141, Child16, 50)
    fallout.giq_option(5, 108, 142, ChildEnd, 50)
end

function Child16()
    fallout.gsay_reply(108, 143)
    fallout.giq_option(5, 108, 144, ChildEnd, 50)
end

function Child17()
    scared = true
    fallout.gsay_message(108, 145, 51)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
